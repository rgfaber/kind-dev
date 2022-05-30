#! /bin/sh

## Cleanup
kubectl delete namespace cert-manager
kubectl delete namespace default
kubectl delete pod nats-box
kubectl delete pod nats-setup
kubectl delete secret nats-sys-creds
kubectl delete secret nats-test-creds
kubectl delete secret nats-test2-creds
kubectl delete secret stan-creds
kubectl delete configmap nats-accounts

#Install without TLS for minikube
curl -sSL https://nats-io.github.io/k8s/setup.sh | sh -s -- --without-tls
