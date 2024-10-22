#!/bin/bash

DOCKER_BUILDKIT=1 docker build --tag baukasten:local-build .
docker run --interactive --tty --rm --publish 8161:8161 baukasten:local-build