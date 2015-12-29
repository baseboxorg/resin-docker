#!/bin/bash

# Jenkins build steps
docker build -t  boxup/rpi-nfs
# run some way
docker push boxup/rpi-nfs
