#! /bin/bash

## REF: https://kind.sigs.k8s.io/docs/user/loadbalancer/

# create MetalLB Namespace
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/master/manifests/namespace.yaml

# create Memberlist Secrets
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" 

# Apply metallb manifest 
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/master/manifests/metallb.yaml


watch kubectl get pods -n metallb-system