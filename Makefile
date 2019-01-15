# Commands
DOCKER_TEMPLATE_COMPILER=dockerfile-template
DOCKERFILE_TEMPLATE=Dockerfile.template

# Device used for local testing
BALENA_MACHINE_NAME=raspberry-pi2
APP_NAME=rpi_home
BALENA_CMD=balena

# Device name of the target
PI_HOSTNAME=new-pi-2.local
PI_ADDRESS=$(shell getent hosts $(PI_HOSTNAME) | grep -o "\b.* ")

%/Dockerfile: %/$(DOCKERFILE_TEMPLATE)
	$(DOCKER_TEMPLATE_COMPILER) -f $< -d BALENA_MACHINE_NAME=$(BALENA_MACHINE_NAME) > $@

local-test: hass/Dockerfile git/Dockerfile
	$(BALENA_CMD) push $(PI_ADDRESS)

deploy: hass/Dockerfile git/Dockerfile
	$(BALENA_CMD) push $(APP_NAME)

clean:
	rm */Dockerfile
