#! /bin/sh
docker build . -t registry.macula.io/es-db

docker push registry.macula.io/es-db


