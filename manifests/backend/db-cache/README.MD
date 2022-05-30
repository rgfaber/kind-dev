# Set up CouchDB on Minikube

## How to

### Step 1 - Start the minikube

```bash
minikube start
```

### Step 2 - ssh into the minikube

```bash
ssh minikube
```

### Step 3 - make directories for data storage and logs for couchdb

```bash
sudo mkdir -p /volume/couchdb/data
sudo mkdir -p /volume/couchdb/logs
```

### Step 4 - deploy couchdb on your minikube

run following command from the "couchdb" folder

```bash
kubectl apply -f manifests/backend/couchdb/state/
```

### Step 5 - Contact CouchDB Admin App

The Ingress you created expects requests from a host named **db.local**

In order to be know where the entry point of your minikube is, type:

```bash
minikube status
```

You will get a response like this:

```bash
host: Running
kubelet: Running
apiserver: Running
kubectl: Correctly Configured: pointing to minikube-vm at 192.168.99.100
```

This tells you that the minikube is accepting requests at **192.168.99.100**
now, type

```bash
sudo nano /etc/hosts
```

add the next line to hosts:

```bash
192.168.99.100      db.local
```

and save the file.
next, open your browser and go to: <http://db.local/_utils>

## Reference

<https://medium.com/faun/deploying-a-couchdb-cluster-on-kubernetes-d4eb50a08b34>

<https://github.com/6fusion/couch-kubernetes>

<https://github.com/joeblackwaslike/docker-couchdb>
