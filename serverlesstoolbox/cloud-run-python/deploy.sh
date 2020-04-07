#!/bin/bash
echo ""
echo "=================="
echo "Deployed in Cloud Run"
echo " Youtube : https://www.youtube.com/watch?v=AoNulKfMl_Q"
gcloud builds submit --tag gcr.io/agb-gcp2/milli-to-in
gcloud run deploy --image gcr.io/agb-gcp2/milli-to-in --platform managed
echo "https://milli-to-in-ghjhsh2ltq-uk.a.run.app"
echo "=================="
echo "Script terminé"