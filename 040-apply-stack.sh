#! /bin/bash
## Start the notouch-pms MicroServices

kubectl config use-context logatron.local
echo "======================================"
echo "| STARTING Logatron Context Services |"
echo "======================================"
# sleep 10s
# sudo kubectl apply -f manifests/apps/10-geo-svc/state
# sleep 10s
# sudo kubectl apply -f manifests/apps/20-contacts-svc/state
echo 'Starting Authentication Service'
kubectl apply -f manifests/apps/01-m5-auth-svc/state



echo 'Starting ALerts Service'
kubectl apply -f manifests/apps/02-m5-alerts-svc/state

echo 'Starting Cultures Service'
kubectl apply -f manifests/apps/03-m5-cultures-svc/state


echo 'Starting Accounts Service'
kubectl apply -f manifests/apps/33-pms-accs-svc/state


# echo 'Starting Assets Service'
# kubectl delete -f manifests/apps/40-pms-assets-svc/state
# kubectl apply -f manifests/apps/40-pms-assets-svc/state

echo 'Starting Devices Service'
kubectl apply -f manifests/apps/50-pms-devices-svc/state

echo 'Starting Vehicles Service'
kubectl apply -f manifests/apps/60-pms-vehicles-svc/state

echo 'Starting NoTouch PMS Mobile Gateway'
kubectl apply -f manifests/apps/500-pms-pwa-svc/state


## Start the notouch-pms MicroApps
echo "=================================="
echo "| STARTING notouch-pms MicroApps |"
echo "=================================="
kubectl apply -f manifests/apps/10001-pms-pwa-ui/state



## Start the notouch-pms MicroApps
# echo "=================================="
# echo "| STARTING notouch-pms SAGA's |"
# echo "=================================="
# kubectl apply -f manifests/apps/101-pms-entry-saga-reader-bus/state
# kubectl apply -f manifests/apps/102-pms-entry-saga-writer-bus/state




