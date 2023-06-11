# These can be overidden with env vars.
CLUSTER ?= nyu-devops

.PHONY: help
help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-\\.]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: all
all: help

.PHONY: clean
clean:	## Removes all dangling docker images
	$(info Removing all dangling docker images..)
	docker image prune -f

.PHONY: venv
venv: ## Create a Python virtual environment
	$(info Creating Python 3 virtual environment...)
	python3 -m venv .venv

.PHONY: install
install: ## Install dependencies
	$(info Installing dependencies...)
	sudo python3 -m pip install --upgrade pip wheel
	sudo pip install -r requirements.txt

.PHONY: lint
lint: ## Run the linter
	$(info Running linting...)
	flake8 service tests --count --select=E9,F63,F7,F82 --show-source --statistics
	flake8 service tests --count --max-complexity=10 --max-line-length=127 --statistics
	pylint service tests --max-line-length=127

.PHONY: tests
test: ## Run the unit tests
	$(info Running tests...)
	green -vvv --processes=1 --run-coverage --termcolor --minimum-coverage=95

.PHONY: run
run: ## Run the service
	$(info Starting service...)
	honcho start

.PHONY: cluster
cluster: ## Create a K3D Kubernetes cluster with load balancer and registry
	$(info Creating Kubernetes cluster with a registry and 1 node...)
	k3d cluster create --agents 1 --registry-create cluster-registry:0.0.0.0:32000 --port '8080:80@loadbalancer'

.PHONY: cluster-rm
cluster-rm: ## Remove a K3D Kubernetes cluster
	$(info Removing Kubernetes cluster...)
	k3d cluster delete

.PHONY: login
login: ## Login to IBM Cloud using yur api key
	$(info Logging into IBM Cloud cluster $(CLUSTER)...)
	ibmcloud login -a cloud.ibm.com -g Default -r us-south --apikey @~/apikey.json
	ibmcloud cr login
	ibmcloud ks cluster config --cluster $(CLUSTER)
	ibmcloud ks workers --cluster $(CLUSTER)
	kubectl cluster-info

.PHONY: deploy
depoy: ## Deploy the service on local Kubernetes
	$(info Deploying service locally...)
	kubectl apply -f deploy/

