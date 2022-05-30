#! /bin/sh
rm -rf ./EventStore

git clone https://github.com/EventStore/EventStore.git

docker build ./EventStore -t registry.macula.io/es-db

docker push registry.macula.io/es-db

rm -rf ./EventStore


