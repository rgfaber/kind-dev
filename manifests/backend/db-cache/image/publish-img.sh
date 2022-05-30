#! /bin/bash

docker build -t registry.macula.io/db-cache:latest .
docker push registry.macula.io/db-cache:latest