PROJECT_ID=[YOUR GCP PROJECT ID FROM THE CLOUD CONSOLE]

gcloud builds submit --tag gcr.io/$PROJECT_ID/tag-images \
  --project $PROJECT_ID

gcloud beta run deploy tag-images \
  --image gcr.io/$PROJECT_ID/tag-images \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --project $PROJECT_ID
