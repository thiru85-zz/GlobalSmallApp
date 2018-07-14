PROJECT_ID=$(shell gcloud config list project --format=flattened | awk 'FNR == 1 {print $$2}')
CLUSTER_NAME=myfirstcluster
ASIACLUSTER_NAME=asia-cluster
EUCLUSTER_NAME=eu-cluster
USCLUSTER_NAME=us-cluster
FEDNAME=federatedcluster
INGRESSIPNAME=globalapp-ip

GCLOUD_USER=$(shell gcloud config get-value core/account)
ZONE=asia-southeast1-a
ASIAZONE=asia-southeast1-a
EUZONE=
USZONE

create-cluster1:
	gcloud container --project "$(PROJECT_ID)" clusters create "$(CLUSTER_NAME)" --zone "$(ZONE)" --machine-type "n1-standard-1" --image-type "COS" --disk-size "100" --scopes "https://www.googleapis.com/auth/compute","https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "3" --network "default" --enable-cloud-logging --enable-cloud-monitoring
	kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(GCLOUD_USER)
	gcloud container clusters get-credentials "$(CLUSTER_NAME)" --zone "$(ZONE)" --project gcpdemoproject

create-deployment1:
	kubectl create -f manifests/GlobalGoApp-deployment.yaml

create-loadbalancer1:
	kubectl create -f manifests/GlobalGoApp-loadbalancer.yaml

delete-cluster1:
    gcloud container clusters delete "$(CLUSTER_NAME)"
	kubectl config delete-contexts gke_"$(PROJECT_ID)"_"$(ZONE)"_"$(CLUSTER_NAME)"

create-allclusters:


