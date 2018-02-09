#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
# https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-architecture
# https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1/projects.zones.clusters#AddonsConfig
#

PROJECT     	:= $(shell gcloud config get-value project)
ACCOUNT     	:= $(shell gcloud config get-value core/account)
CLUSTER_NAME	?= "cluster-$(shell echo $$(($(shell gcloud container clusters list --uri|wc -w|tr -d '[:space:]')+1)))"
TYPE        	?= n1-standard-2
NODES	    	?= 2
USERNAME    	?= $(shell cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)
PASSWORD    	?= $(shell cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)
NETWORK     	?= $(shell gcloud compute networks list --filter='-name:default' --format='value(name)' --limit=1)
create:

	gcloud beta container clusters create   "$(CLUSTER_NAME)" 										\
											--project "$(PROJECT)" 									\
											--zone "us-central1-a" 									\
											--username="$(USERNAME)"								\
											--password="$(PASSWORD)"								\											--cluster-version "1.8.7-gke.0" \
											--machine-type "$(TYPE)"	 							\
											--image-type "UBUNTU" 									\
											--disk-size "100" 										\
											--num-nodes "$(NODES)" 									\
											--network "$(NETWORK)"									\
											--enable-ip-alias				 						\
											--enable-master-authorized-networks 					\
											--disable-addons HttpLoadBalancing,KubernetesDashboard 	\
											--scopes "https://www.googleapis.com/auth/compute","https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \

delete:

	gcloud container clusters delete $(NAME)

rbac:

	kubectl create clusterrolebinding cluster-admin-binding             \
										--clusterrole=cluster-admin     \
										--user="$(gcloud config get-value core/account)"
