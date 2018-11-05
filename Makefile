IMAGE_JENKINS= jenkins_ci
CONTAINER_NAME= jenkins
DOCKER_NETWORK= {{NOMBRE-RED-DOCKER}}
LOCAL_PROJECT_NAME = jenkins

build: ## build image to dev and cli: make build
	docker build -f docker/Dockerfile -t ${IMAGE_JENKINS} docker/

up: ## up docker containers: make up
	@make verify_network &> /dev/null
	@IMAGE_JENKINS=$(IMAGE_JENKINS) \
	CONTAINER_NAME=$(CONTAINER_NAME) \
	DOCKER_NETWORK=$(DOCKER_NETWORK) \
	docker-compose -p $(LOCAL_PROJECT_NAME) up -d jenkins

verify_network: ## Verify the local network was created in docker: make verify_network
	@if [ -z $$(docker network ls | grep $(DOCKER_NETWORK) | awk '{print $$2}') ]; then\
		(docker network create $(DOCKER_NETWORK));\
	fi