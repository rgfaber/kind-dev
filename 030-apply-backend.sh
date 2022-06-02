#! /bin/bash

echo =====================================
echo 'Create the volumes for CouchDB'
sudo mkdir -p /volume/logatron/couch-db/data
sudo mkdir -p /volume/logatron/couch-db/logs
echo 'Create the volumes for EventStoreDB'
sudo mkdir -p /volume/logatron/es-db/data
echo =====================================


## Start the Backend Services
echo "========================="
echo "STARTING Backend Services"
echo "========================="

# echo "Starting Traefik Ingress"
# kubectl apply -f manifests/backend/traefik/dpl-state

echo "Starting K8S Monitor"
kubectl apply -f manifests/backend/cadvisor/state


echo "Starting CouchDB"
kubectl apply -f manifests/backend/couchdb/state

# echo "Starting Object Storage"
# kubectl delete -f manifests/backend/minio/state
# kubectl apply -f manifests/backend/minio/state
echo "Starting NATS and STAN"
kubectl apply -f manifests/backend/nats/state


echo "Starting EventStoreDB"
kubectl apply -f manifests/backend/eventstore/state

echo "Starting Zookeeper + Kafka"
kubectl apply --kustomize manifests/backend/kafka-manifests/base 


# # kubectl delete -f manifests/backend/nats/state2
# # kubectl apply -f manifests/backend/nats/state2


# echo "Starting MySql"
# sudo kubectl apply -f manifests/backend/mysql/state

# echo "***** Resting 2 minutes before spinning Camunda *****"
# sleep 2m
# sudo kubectl apply -f manifests/backend/camunda/state


