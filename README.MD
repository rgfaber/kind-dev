# Your Local AgriKult Cluster 

## Table of Contents
- [Your Local AgriKult Cluster](#your-local-agrikult-cluster)
  - [Table of Contents](#table-of-contents)
  - [Before we start...](#before-we-start)
  - [Let's go!](#lets-go)
    - [Step 1 - Installing Prerequisites](#step-1---installing-prerequisites)
    - [Step 2 - Creating your Development Logatron Cluster](#step-2---creating-your-development-logatron-cluster)
    - [Step 3 - The Kubernetes Dashboard (optional)](#step-3---the-kubernetes-dashboard-optional)
  - [External References](#external-references)


## Before we start...

```mono
We strongly recommend to spin up an Ubuntu Box to run this stack.
```
- Though Docker and Kubernetes do have Windows variants, we opt for Linux to run the ecosystem. 
All code and scripts in this repository are developed and tested on Ubuntu 18.6 LTS. 
- Optionally, you could also install some multi-screen terminal tool like  **terminator**. See: https://blog.arturofm.com/install-terminator-terminal-emulator-in-ubuntu/. It will help you keep your workspace tidy.


## Let's go!

### Step 1 - Installing Prerequisites

- In order to have all tools available for running your local cluster, please first execute 

```bash
$ . 005-inst-prereq.sh
```
- This script will install **xclip**, **curl**, **docker**, **kind** and **kubectl**
- After completion, your screen should look something like this:

```bash
====================
INSTALLATION SUMMARY
====================

   curl
**********
curl 7.58.0 (x86_64-pc-linux-gnu) libcurl/7.58.0 OpenSSL/1.1.1 zlib/1.2.11 libidn2/2.0.4 libpsl/0.19.1 (+libidn2/2.0.4) nghttp2/1.30.0 librtmp/2.3
Release-Date: 2018-01-24
Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 pop3s rtmp rtsp smb smbs smtp smtps telnet tftp 
Features: AsynchDNS IDN IPv6 Largefile GSS-API Kerberos SPNEGO NTLM NTLM_WB SSL libz TLS-SRP HTTP2 UnixSockets HTTPS-proxy PSL 

   docker  
**********
Docker version 19.03.13, build 4484c46d9d

   kind  
**********
kind version 0.9.0

  kubectl  
***********
Client Version: v1.19.2
Server Version: v1.19.1

====================
```
```mono
Don't worry if kubectl reports a 'could not reach cluster' error. 
This occurs when there is no cluster running in the current context.
```
### Step 2 - Creating your Development Logatron Cluster

- We use **kind** to set up a kubernetes cluster that consists of 1 master- (control-plane) and 5 worker nodes. 
- Each of these nodes run inside a dedicated docker container, so a total of 4 containers will be running on your host.
- Before creating your Local Kind Cluster, please open a new terminal and type:
```bash
$ watch kubectl get pods --all-namespaces
``` 
This will monitor the provisioning of your Local AgriKult Cluster. Let us call this screen the **Cluster Monitor**
- Optionally, you can also open a second terminal and there you can type:
```bash
$ watch docker container list --all
```
This will monitor the creation of the docker containers that represent the nodes in your cluster. We call this the **Nodes Monitor**
- Next,In order to create the initial cluster, please run 
```bash
$ . 010-create-cluster.sh
```
- This should result in the following report:
```bash
Deleting cluster "AgriKult.local" ...
Creating cluster "AgriKult.local" ...
 ✓ Ensuring node image (kindest/node:v1.19.1) 🖼
 ✓ Preparing nodes 📦 📦 📦 📦  
 ✓ Writing configuration 📜 
 ✓ Starting control-plane 🕹️ 
 ✓ Installing CNI 🔌 
 ✓ Installing StorageClass 💾 
 ✓ Joining worker nodes 🚜 
Set kubectl context to "kind-AgriKult.local"
You can now use your cluster with:

kubectl cluster-info --context kind-AgriKult.local

Thanks for using kind! 😊
Kubernetes master is running at https://127.0.0.1:40015
KubeDNS is running at https://127.0.0.1:40015/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
namespace/kubernetes-dashboard created
serviceaccount/kubernetes-dashboard created
service/kubernetes-dashboard created
secret/kubernetes-dashboard-certs created
secret/kubernetes-dashboard-csrf created
secret/kubernetes-dashboard-key-holder created
configmap/kubernetes-dashboard-settings created
role.rbac.authorization.k8s.io/kubernetes-dashboard created
clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard created
rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
deployment.apps/kubernetes-dashboard created
service/dashboard-metrics-scraper created
deployment.apps/dashboard-metrics-scraper created
serviceaccount/admin-user created
clusterrolebinding.rbac.authorization.k8s.io/admin-user created
```
After some time, your **Cluster Monitor** should look like this:
```bash
NAMESPACE              NAME                                                  READY   STATUS    RESTARTS   AGE
kube-system            coredns-f9fd979d6-62x54                               1/1     Running   0          51m
kube-system            coredns-f9fd979d6-7r97r                               1/1     Running   0          51m
kube-system            etcd-AgriKult.local-control-plane                      1/1     Running   0          51m
kube-system            kindnet-blpww                                         1/1     Running   0          51m
kube-system            kindnet-drbtl                                         1/1     Running   0          51m
kube-system            kindnet-dtbwd                                         1/1     Running   0          51m
kube-system            kindnet-kqq9c                                         1/1     Running   0          51m
kube-system            kube-apiserver-AgriKult.local-control-plane            1/1     Running   0          51m
kube-system            kube-controller-manager-AgriKult.local-control-plane   1/1     Running   0          51m
kube-system            kube-proxy-mdzpc                                      1/1     Running   0          51m
kube-system            kube-proxy-nrmv8                                      1/1     Running   0          51m
kube-system            kube-proxy-s45tr                                      1/1     Running   0          51m
kube-system            kube-proxy-t767f                                      1/1     Running   0          51m
kube-system            kube-scheduler-AgriKult.local-control-plane            1/1     Running   0          51m
kubernetes-dashboard   dashboard-metrics-scraper-7b59f7d4df-rlpz9            1/1     Running   0          50m
kubernetes-dashboard   kubernetes-dashboard-74d688b6bc-hbxkv                 1/1     Running   0          50m
local-path-storage     local-path-provisioner-78776bfc44-4drqh               1/1     Running   0          51m

```
and your **Nodes Monitor** should look something like this:
```bash
CONTAINER ID        IMAGE                  COMMAND                  CREATED             STATUS              PORTS                       NAMES
f04709444028        kindest/node:v1.19.1   "/usr/local/bin/entr…"   54 minutes ago      Up 54 minutes                                   AgriKult.local-worker3
a858a4a71508        kindest/node:v1.19.1   "/usr/local/bin/entr…"   54 minutes ago      Up 54 minutes       127.0.0.1:40015->6443/tcp   AgriKult.local-control-plane
15a2bc846c2a        kindest/node:v1.19.1   "/usr/local/bin/entr…"   54 minutes ago      Up 54 minutes                                   AgriKult.local-worker
faadf7135b64        kindest/node:v1.19.1   "/usr/local/bin/entr…"   54 minutes ago      Up 54 minutes                                   AgriKult.local-worker2

```
Is this the case? **Well Done!** Your Local AgriKult Cluster is now up and running and ready to be populated with apps and services.


### Step 3 - The Kubernetes Dashboard (optional) 
The script that created your cluster has also installed an extra tool: the Kubernetes Dashboard. This is a Web UI that allows you to inspect and manage your cluster in a user-friendly manner. However, with great power comes great responsibility, so this UI requires credentials before you can use it. These credentials are available in the **AgriKult.local.secret** file that was created during the creation process of your cluster. You can copy it straight to the clipboard by typing:
```bash
$ cat AgriKult.local.secret | xclip
```
Next, you can can start the kubernetes dashboard with:
```bash
$ kubectl proxy
```
- This will make the K8S Dashboard available at: <http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/>
- The dashboard will request credentials in the form of a token. This token is available in the clipboard, so go ahead and paste it in the input field of the authentication screen.
- **Have fun exploring your cluster via the Kubernetes Dashboard!**



## External References

- <https://kind.sigs.k8s.io/docs/user/quick-start/>
- <https://kubernetes.io>
- [Anais Ulrich](https://www.youtube.com/watch?v=c4v7wGqKcEY)


