#! /bin/bash

docker build -t registry.macula.io/couch-dev:latest .
docker push registry.macula.io/couch-dev:latest