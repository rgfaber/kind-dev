#! /bin/bash
## Start the notouch-pms MicroServices

kubectl config use-context pms.local
echo "================================="
echo "| DELETING notouch-pms MicroServices |"
echo "================================="
# sleep 10s
# sudo kubectl apply -f manifests/apps/10-geo-svc/state
# sleep 10s
# sudo kubectl apply -f manifests/apps/20-contacts-svc/state
echo 'DELETING Authentication Service'
kubectl delete -f manifests/apps/01-m5-auth-svc/state

echo 'DELETING ALerts Service'
kubectl delete -f manifests/apps/02-m5-alerts-svc/state


echo 'DELETING Cultures Service'
kubectl delete -f manifests/apps/03-m5-cultures-svc/state



echo 'DELETING Accounts Service'
kubectl delete -f manifests/apps/33-pms-accs-svc/state



# echo 'DELETING Assets Service'
# kubectl delete -f manifests/apps/40-pms-assets-svc/state
# kubectl apply -f manifests/apps/40-pms-assets-svc/state

echo 'DELETING Devices Service'
kubectl delete -f manifests/apps/50-pms-devices-svc/state


echo 'DELETING Vehicles Service'
kubectl delete -f manifests/apps/60-pms-vehicles-svc/state


echo 'DELETING NoTouch PMS Mobile Gateway'
kubectl delete -f manifests/apps/500-pms-pwa-svc/state



## Start the notouch-pms MicroApps
echo "=================================="
echo "| DELETING notouch-pms MicroApps |"
echo "=================================="
kubectl delete -f manifests/apps/10001-pms-pwa-ui/state




## Start the notouch-pms MicroApps
echo "=================================="
echo "| DELETING notouch-pms SAGA's |"
echo "=================================="
kubectl delete -f manifests/apps/101-pms-entry-saga-reader-bus/state
kubectl delete -f manifests/apps/102-pms-entry-saga-writer-bus/state





