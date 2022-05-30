#! /bin/bash

docker build image/ -t registry.macula.io/cache-db
docker push registry.macula.io/cache-db