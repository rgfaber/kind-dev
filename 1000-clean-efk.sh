#! /bin/sh
green=`tput setaf 2`
reset=`tput sgr 0`
yellow=`tput setaf 3`

read -p "${yellow} Are you sure you want use this scripts ?? ${reset} (y/N)" CONFIRM

if [ "$CONFIRM" = "y" ]; then
echo  "${green} \n Deleteing all EFK stack components\n ${reset}"  

sudo kubectl delete clusterrole fluentd
sudo kubectl delete persistentvolume apps-logging-pv
sudo kubectl delete storageclass elastic-local-storage
sudo kubectl delete -n default service fluentd-svc
sudo kubectl delete -n default service kibana-svc
sudo kubectl delete -n default service elasticsearch-svc
sudo kubectl delete -n default configmap fluentd-config-map
sudo kubectl delete -n default configmap kibana-configmap
sudo kubectl delete -n default configmap elasticsearch-configmap
sudo kubectl delete -n default deployment kibana
sudo kubectl delete -n default daemonset fluentd
sudo kubectl delete -n default statefulset es-cluster 
sudo kubectl delete -n default secret elasticsearch-user-password
sudo kubectl delete storageclass local-storage
sudo kubectl delete -n default ingress kabina-ingress
sudo kubectl delete -n default secret $(sudo sudo kubectl get -n default secret |  awk '{ print $1 }' | grep fluentd-)

echo  "${green} \n \n Done! \n \n ${reset}"  
else
 exit 0
fi