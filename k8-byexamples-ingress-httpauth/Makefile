#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#

NS              ?= ingress-nginx
SERVICE_NAME    ?= kibana
SERVICE_PORT    ?= 5601
USERNAME		?="user"
PASSWORD		?="$(shell openssl rand -base64 32)"
export

install:    ingress-install
delete:     ingress-delete
get:        service-account-get cluster-role-get cluster-role-binding-get configmap-get daemonset-get


htpasswd:

	@echo USERNAME=$(USERNAME)
	@echo PASSWORD=$(PASSWORD)

	@htpasswd -cb auth inovex ${BASIC_PASSWORD}


## Generate .htpasswd contents
htpasswd:

	docker run --rm -it appsoa/docker-alpine-htpasswd $(USERNAME) $(PASSWORD) > .htpasswd
#
# Find first pod and follow log output
#
logs:

	@$(eval POD:=$(shell kubectl get pods --all-namespaces -lk8s-app=fluentd-logging -o jsonpath='{.items[0].metadata.name}'))
	echo $(POD)

	kubectl --namespace $(NS) logs -f $(POD)


## Install Ingress Resource
ingress-install:

	@echo Installing:
	@envsubst < ingress.yaml
	@echo --
	@envsubst < ingress.yaml | kubectl --namespace $(NS) apply -f -

## Delete Ingress Resource
ingress-delete:

	@envsubst < ingress.yaml | kubectl --namespace $(NS) delete -f -

## Create basic-auth secret from .htpasswd file
secret-create:
	@kubectl create secret generic basic-auth --from-file=.htpasswd

## Retrieve secret from server
secret-get:
	@kubectl get secret basic-auth -o yaml

service-install:

	@echo Installing:
	envsubst < glbc-service.yaml
	@echo --
	envsubst < glbc-service.yaml | kubectl --namespace $(NS) apply -f -

service-delete:

	envsubst < glbc-service.yaml | kubectl --namespace $(NS) delete -f -


## Find first pod and follow log output
logs:

	@$(eval POD:=$(shell kubectl get pods --all-namespaces -lk8s-app=ingress-controller -o jsonpath='{.items[0].metadata.name}'))
	echo $(POD)

	kubectl --namespace $(NS) logs -f $(POD)

#     kubectl create rolebinding default-test \
#                                 --clusterrole=admin \
#                                 --serviceaccount=default:default \
#                                 --namespace=infra-ingress
# kubectl create clusterrolebinding varMyClusterRoleBinding \
#   --clusterrole=cluster-admin \
#   --serviceaccount=kube-system:default

kubectl create clusterrolebinding infra-ingress-default --clusterrole=cluster-admin --serviceaccount=infra-ingress:default
