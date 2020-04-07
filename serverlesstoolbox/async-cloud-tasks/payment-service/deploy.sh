# GOOGLE_PROJECT_ID=[YOUR GCP PROJECT ID GOES HERE]

gcloud builds submit --tag gcr.io/$GOOGLE_PROJECT_ID/payment-service \
  --project $GOOGLE_PROJECT_ID

gcloud beta run deploy payment-service \
  --image gcr.io/$GOOGLE_PROJECT_ID/payment-service \
  --platform managed \
  --no-allow-unauthenticated \
  --region us-central1 \
  --project $GOOGLE_PROJECT_ID
