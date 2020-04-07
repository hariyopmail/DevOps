# This script creates the Cloud SQL database that will be used by the REST API.
# At the end of the script, a connection is opened to the newly created
# database. Enter the root password when prompted. When connected to the
# database, paste in the contents of the file load-data.sql. This will load
# some test data into the database.

PROJECT_ID=[YOUR GCP PROJECT ID FROM THE CLOUD CONSOLE]
ROOT_PASSWORD=[DECIDE ON A ROOT PASSWORD]
INSTANCE_NAME=[DECIDE ON THE NAME OF YOUR CLOUD SQL INSTANCE/MACHINE]
REGION=[DECIDE WHICH REGION TO PUT SQL INSTANCE, e.g., us-central]
DB_NAME=pet-theory

gcloud sql instances create $INSTANCE_NAME \
  --region=$REGION \
  --root-password=$ROOT_PASSWORD \
  --project=$PROJECT_ID

gcloud sql databases create $DB_NAME \
  --instance=$INSTANCE_NAME \
  --project=$PROJECT_ID

gcloud sql connect $INSTANCE_NAME \
  --user=root \
  --project=$PROJECT_ID
