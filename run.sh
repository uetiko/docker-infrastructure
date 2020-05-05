#!/bin/bash

set -x

export HOST_USER_ID=$(id -u $(whoami))
export HOST_GROUP_ID=$(id -g $(whoami))
export HOST_NAME=$1

docker-compose up --build
