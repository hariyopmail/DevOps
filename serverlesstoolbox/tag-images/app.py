import base64
import io
import json
import os
import sys
from google.cloud import storage
from google.cloud import vision
from google.cloud.vision import types
from google.cloud import firestore
db = firestore.Client()

from flask import Flask
from flask import request
app = Flask(__name__)

@app.route('/', methods = ['POST'])
def handlePubSubMessage():
  try:
    print(request.json['message']['attributes']['eventType'], flush=True)
    if request.json['message']['attributes']['eventType'] == 'OBJECT_FINALIZE':
      file = decodeBase64Json(request.json['message']['data'])
      tags = getImageTags(file['bucket'], file['name'])
      writeToFirestore(file['name'], tags)
      deleteFile(file['bucket'], file['name'])
  except:
    print(sys.exc_info()[0], flush=True)
  return '', 204

def decodeBase64Json(data):
  return json.loads(base64.b64decode(data))

def getImageTags(bucketName, fileName):
  client = vision.ImageAnnotatorClient()
  image_uri = "gs://" + bucketName + "/" + fileName
  request = {
    "image": {"source": {"image_uri": image_uri}},
    "features": [
      {
        "type": vision.enums.Feature.Type.LABEL_DETECTION,
        "max_results": 6
      },
      {
        "type": vision.enums.Feature.Type.LANDMARK_DETECTION,
        "max_results": 3
      }
    ],
  }
  response = client.annotate_image(request)
  return getTagsFromResponse(response)

def getTagsFromResponse(visionApiResp):
  landmarks = [ x.description for x in visionApiResp.landmark_annotations ]
  labels = [ x.description for x in visionApiResp.label_annotations ]
  return landmarks + labels

def writeToFirestore(fileName, tags):
  doc_ref = db.collection('photos').document(fileName)
  doc_ref.set({'tags': tags})

def deleteFile(bucketName, fileName):
  client = storage.Client()
  bucket = client.bucket(bucketName)
  file = bucket.blob(fileName)
  file.delete()

if __name__ == "__main__":
  app.run(
    debug=True,
    host='0.0.0.0',
    port=int(os.environ.get('PORT', 8080))
  )
