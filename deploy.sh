#! /bin/bash
echo "ENTER YOUR PROJECT ID:-"
read PROJECT_ID
gcloud config set project $PROJECT_ID
gcloud services enable cloudbuild.googleapis.com compute.googleapis.com file.googleapis.com \
vpcaccess.googleapis.com  run.googleapis.com artifactregistry.googleapis.com 
gcloud filestore instances create nfs-server --zone=us-central1-c  \
--tier=BASIC_HDD --file-share=name="vol1",capacity=1TB \
--network=name="default"
gcloud compute networks vpc-access connectors create connector-us \
--region us-central1 \
--subnet  10.8.0.0/28 \
--network default \
--min-instances 2 \
--max-instances 3 \
cd app
FILESTORE_INSTANCE_IP=$(gcloud filestore instances describe nfs-server --location=us-central1-c --format="value(networks.ipAddresses[0])")
gcloud run deploy frontend --region us-central1 \
--source . \
--allow-unauthenticated \
--set-env-vars=NFS_IP=$FILESTORE_INSTANCE_IP \
--vpc-connector connector-us
