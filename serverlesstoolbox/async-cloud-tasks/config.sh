# GOOGLE_PROJECT_ID=[YOUR GCP PROJECT ID GOES HERE]


# Create the payments queue in Cloud Tasks.
gcloud tasks queues create payments --project $GOOGLE_PROJECT_ID

# Find your project number.
gcloud projects describe $GOOGLE_PROJECT_ID --format='table(projectNumber)'

PROJECT_NUMBER=[PROJECT NUMBER RETURNED BY PREVIOUS COMMAND]

# Grant the Cloud Tasks service account the Cloud Tasks Service Agent role.
gcloud projects add-iam-policy-binding $GOOGLE_PROJECT_ID \
  --member serviceAccount:service-$PROJECT_NUMBER@gcp-sa-cloudtasks.iam.gserviceaccount.com \
  --role roles/cloudtasks.serviceAgent \
  --project $GOOGLE_PROJECT_ID

# Set a rate limit of 5 calls per second.
gcloud tasks queues update payments \
  --max-dispatches-per-second=5 \
  --project $GOOGLE_PROJECT_ID
