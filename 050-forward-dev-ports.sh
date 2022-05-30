#! /bin/bash

export NAMESPACE=logatron
export NAMESPACE=default


set -eu

echo 'kubectl port-forward service/dev-cdb-couchdb 5984:5984 --namespace "$NAMESPACE" &' | sh
echo 'kubectl port-forward service/dev-eventstore 2113:2113 --namespace "$NAMESPACE" &' | sh
echo 'kubectl port-forward service/nats 4222:4222 &' | sh
echo 'kubectl port-forward service/grafana 3000:3000 &' | sh
echo 'kubectl port-forward deployments/nats-surveyor-grafana 3000:3000 &'

