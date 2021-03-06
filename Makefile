DOCKER_IMAGE_VERSION=1.0
DOCKER_IMAGE_NAME=lerebel103/rpi-mosquitto
DOCKER_IMAGE_TAGNAME=$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

default: build

build:
	docker build -t $(DOCKER_IMAGE_TAGNAME) .
	docker tag $(DOCKER_IMAGE_TAGNAME) $(DOCKER_IMAGE_NAME):latest

push:
	docker push $(DOCKER_IMAGE_NAME)

rmi:
	docker rmi -f $(DOCKER_IMAGE_TAGNAME)

rebuild: rmi build
