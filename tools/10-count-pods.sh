#! /bin/bash

kubectl get pods --all-namespaces | grep -i running | wc -l