#! /bin/bash

set -eu



export PLATFORM=docktrace
export CLUSTER_NAME=docktrace.edge
export REGISTRY=docktrace.azurecr.io



sudo rm -rf /volume/"$PLATFORM"

rm -rf "$CLUSTER_NAME".secret

kind delete cluster --name "$CLUSTER_NAME"

kind create cluster --config manifests/cluster/00-cluster.yaml --name "$CLUSTER_NAME"

kubectl cluster-info --context kind-"$CLUSTER_NAME"

# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/mandatory.yaml
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml

# kubectl apply -f manifests/cluster/01-dashboard-admin.yaml


echo
echo 'Waiting 10 seconds for the cluster to be ready...'
sleep 10s
echo


echo '********************************************************************'
echo 'REF: https://github.com/nats-io/k8s/issues/9#issuecomment-887154588'
echo 'Adding external node IPS'
echo '********************************************************************'


export NODE_CP="$CLUSTER_NAME"-control-plane
export NODE_1="$CLUSTER_NAME"-worker
export NODE_2="$CLUSTER_NAME"-worker2
export NODE_3="$CLUSTER_NAME"-worker3


kubectl label node "$NODE_CP" nats.io/node-external-ip=$(hostname -I | awk '{print $1}')
kubectl label node "$NODE_1" nats.io/node-external-ip=$(hostname -I | awk '{print $1}')
kubectl label node "$NODE_2" nats.io/node-external-ip=$(hostname -I | awk '{print $1}')
kubectl label node "$NODE_3" nats.io/node-external-ip=$(hostname -I | awk '{print $1}')

echo

echo 
echo 'Creating Docker Secrets'
echo

kubectl create secret docker-registry azdo-regcred \
          --docker-server="$REGISTRY" \
          --docker-username="$DOCKTRACE_OCI_USR" \
          --docker-password="$DOCKTRACE_OCI_PWD1" \
          --docker-email="$DOCKTRACE_OCI_EMAIL"

kubectl create secret docker-registry regcred \
          --docker-server="$DOCKERHUB_REGISTRY" \
          --docker-username="$DOCKERHUB_USER" \
          --docker-password="$DOCKERHUB_PWD" \
          --docker-email="$DOCKERHUB_EMAIL"


echo
echo 'Creating github secret'
echo

cat > github-secret.yaml <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: github-secret
type: kubernetes.io/basic-auth
stringData:
  username: $GITHUB_USER
  password: $GITHUB_TOKEN
EOF

kubectl apply -f github-secret.yaml

rm github-secret.yaml

echo "DO YOU WISH TO ADD docktrace.azurecr.io SECRET? (y/N)"

read add_azdo_secret

if [ "$add_azdo_secret" == "y" ];
then


cat > azdo-secret.yaml <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: azdo-secret
type: kubernetes.io/basic-auth
stringData:
  username: $DOCKTRACE_OCI_USR
  password: $DOCKTRACE_OCI_PWD1
EOF

kubectl apply -f azdo-secret.yaml

rm azdo-secret.yaml

fi

# helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
# helm repo update

# helm install ingress-nginx \
#   --namespace ingress-nginx \
#     ingress-nginx/ingress-nginx          


# # echo "===================================="
# # echo "Configuring the Kubernetes Dashboard"
# # echo "===================================="
# # kubectl get secret \
# #           -n kubernetes-dashboard $(kubectl get serviceaccount admin-user -n kubernetes-dashboard -o jsonpath="{.secrets[0].name}") \
# #           -o jsonpath="{.data.token}" | base64 --decode > "$CLUSTER_NAME".secret


echo "===================================="
echo "     Applying NGINX Ingress         "
echo "===================================="
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# kubectl apply -f manifests/cluster/02-ingress-deploy.yaml
# kubectl apply -f manifests/cluster/03-ingress-patch.yaml

# kubectl apply -f ./manifests/cluster/04-ingress-deploy-21.07.29.yaml

# echo '########## WORKAROUND CODE #############################################################################'
# echo '## IMPORTANT: THE LINE THAT FOLLOWS IS TO TACKLE THE ingress validation error bug'
# echo '## REF: https://githubmemory.com/repo/kubernetes/ingress-nginx/issues/7306'
# echo '## We must update to higer kind release asap, hoping the bug will be solved'
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/a8408cdb51086a099a2c71ed3e68363eb3a7ae60/deploy/static/provider/kind/deploy.yaml
# echo '###########################################################################################################'


kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "mac-regcred"},{"name": "regcred"}]}'
kubectl patch serviceaccount default \
  -p '{"imagePullSecrets": [{"name": "mac-regcred"},{"name": "regcred"}]}' \
  -n ingress-nginx

kubectl get secrets


kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s


# echo "==================================="
# echo "| THIS IS YOUR CURRENT HOSTS FILE |"
# echo "==================================="
# cat /etc/hosts
# echo "==================================="

# echo "DO YOU WISH TO EDIT THIS FILE? (y/N)"

# read edithosts

# if [ "$edithosts" == "y" ];
# then
#   sudo nano /etc/hosts
#   sudo systemctl restart networking
#   sudo systemctl restart networking.service
# fi


# echo
# echo "====================================================="
# echo "DO YOU WISH TO PREPARE BACKEND SERVICES NOW? (y/N)"
# echo "====================================================="


# read applybackend

# if [ "$applybackend" == "y" ];  
# then
  
  echo 'Preparing for Mass...'
  sleep 2s
  echo
  echo 'Create the volumes for CouchDB'
  sudo mkdir -p /volume/"$PLATFORM"/couch-0/data
  sudo mkdir -p /volume/"$PLATFORM"/couch-0/log

  sudo mkdir -p /volume/"$PLATFORM"/couch-1/data
  sudo mkdir -p /volume/"$PLATFORM"/couch-1/log

  sudo mkdir -p /volume/"$PLATFORM"/couch-2/data
  sudo mkdir -p /volume/"$PLATFORM"/couch-2/log
  
  echo 'Create the volumes for EventStoreDB'
  sudo mkdir -p /volume/"$PLATFORM"/eventstore-0/data
  sudo mkdir -p /volume/"$PLATFORM"/eventstore-0/log
  sudo mkdir -p /volume/"$PLATFORM"/eventstore-0/index

  sudo mkdir -p /volume/"$PLATFORM"/eventstore-1/data
  sudo mkdir -p /volume/"$PLATFORM"/eventstore-1/log
  sudo mkdir -p /volume/"$PLATFORM"/eventstore-1/index
  
  sudo mkdir -p /volume/"$PLATFORM"/eventstore-2/data
  sudo mkdir -p /volume/"$PLATFORM"/eventstore-2/log
  sudo mkdir -p /volume/"$PLATFORM"/eventstore-2/index
  

  echo 'Create the volumes for NATS'
  sudo mkdir -p /volume/"$PLATFORM"/nats/data


  # . 030-apply-backend.sh
# fi

