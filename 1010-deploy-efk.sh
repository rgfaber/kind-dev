#! /bin/bash
green=`tput setaf 2`
reset=`tput sgr 0`
yellow=`tput setaf 3`

echo -e "${green} \nRunning EFK stack rollout with following steps: ${reset}"  
echo -e "${yellow} 1. Create elastic user password as a secret key ${reset}"  
echo -e "${yellow} 2. Apply all Elasticseach cluster setup ${reset}"  
echo -e "${yellow} 3. Apply all Fluentd Deamon Set files ${reset}"  
echo -e "${yellow} 4. Deploying Kibana service \n ${reset}"  

read -s -p "${yellow} Enter elastic user password: ${reset}" PASSWORD
echo -e "\n"  
read -s -p "${yellow} Confirm password: ${reset}" CONFIRM_PASSWORD

if [ "$CONFIRM_PASSWORD" == "$PASSWORD" ]; then

sudo kubectl create secret generic elasticsearch-user-password \
    -n default \
    --from-literal password="$PASSWORD"

echo -e "${yellow} \n Deploying Elasticsearch cluster setup\n ${reset}"  
sudo kubectl apply -f ../manifests/backend/elasticsearch/state/
sleep 8

echo -e "${yellow} \n Deploying Fluentd Deamon Set \n ${reset}"  
sudo kubectl apply -f ../manifests/backend/fluentd/state/
sleep 2

echo -e "${yellow} \n Deploying Kibana service \n ${reset}"  
sudo kubectl apply -f ../manifests/backend/kibana/state/
sleep 2

echo  -e "${green} \n Checkout EFK stack status \n ${reset}"  
sudo kubectl get svc | grep -i svc
echo  -e "${green} \n Done! \n \n${reset}"  

else
  echo  "${yellow} Password do not match! ${reset}"  
fi
