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

echo
echo "Delete K8S Monitor"
kubectl delete -f manifests/backend/cadvisor/state

echo
echo "Delete CouchDB"
kubectl delete -f manifests/backend/couchdb/state
kubectl delete pvc couch-data-pvc-couchdb-0
kubectl delete pvc couch-log-pvc-couchdb-0
kubectl delete pv couch-logs
kubectl delete pv couch-data



# echo "Starting Object Storage"
# kubectl delete -f manifests/backend/minio/state
# kubectl apply -f manifests/backend/minio/state
echo
echo "Delete NATS and STAN"
kubectl delete -f manifests/backend/nats/state

echo
echo "Delete EventStoreDB"
kubectl delete -f manifests/backend/eventstore/state
kubectl delete pvc es-pv-storage-eventstore-0
kubectl delete pvc es-pv-storage-eventstore-1
kubectl delete pvc es-pv-storage-eventstore-2




# # kubectl delete -f manifests/backend/nats/state2
# # kubectl apply -f manifests/backend/nats/state2


# echo "Starting MySql"
# sudo kubectl apply -f manifests/backend/mysql/state

# echo "***** Resting 2 minutes before spinning Camunda *****"
# sleep 2m
# sudo kubectl apply -f manifests/backend/camunda/state


