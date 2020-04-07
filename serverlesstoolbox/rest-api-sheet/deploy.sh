GOOGLE_PROJECT_ID=# YOUR GCP PROJECT ID GOES HERE

# The service currently reads from the "Ingredients" tab in the Google Sheet
# https://docs.google.com/spreadsheets/d/1rcj3SbeK_VcMOBrwwdAksJXQVoHTZHRzVOBO8A3X148/edit#gid=0
# Feel free to make a copy of that sheet and adapt it and the code to your needs.
SHEET_ID=1rcj3SbeK_VcMOBrwwdAksJXQVoHTZHRzVOBO8A3X148
TAB_ID=Ingredients

gcloud builds submit --tag gcr.io/$GOOGLE_PROJECT_ID/slipslap-warehouse \
  --project=$GOOGLE_PROJECT_ID

gcloud beta run deploy slipslap-warehouse \
  --image gcr.io/$GOOGLE_PROJECT_ID/slipslap-warehouse \
  --platform managed \
  --region us-central1 \
  --set-env-vars SHEET_ID=$SHEET_ID,TAB_ID=$TAB_ID \
  --project=$GOOGLE_PROJECT_ID
