# GOOGLE_PROJECT_ID=[YOUR GCP PROJECT ID GOES HERE]

gcloud builds submit --tag gcr.io/$GOOGLE_PROJECT_ID/store-service \
  --project $GOOGLE_PROJECT_ID

gcloud beta run deploy store-service \
  --image gcr.io/$GOOGLE_PROJECT_ID/store-service \
  --platform managed \
  --allow-unauthenticated \
  --region us-central1 \
  --project $GOOGLE_PROJECT_ID

# When both the store and payment services have been deployed, make a POST
# request to the store service:
#
# curl -X POST [STORE SERVICE URL]
#
# Then check the Stackdriver log to make sure that the store service added
# the order to the queue, and that the payment service picked it up from the
# queue.
