#!/bin/bash

set -i

docker build -t docker-rclone-mounter .

docker image tag docker-rclone-mounter megamaid/docker-rclone-mounter:latest

docker image push megamaid/docker-rclone-mounter:latest