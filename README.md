# k8s4jd-support
Kubernetes for Java developers project support files.

## 1. Minikube setup

Start minikube.

On Linux

```sh
minikube start
```
On macosx

```sh
minikube start --vm=true
```

Find out IP address of your minikube cluster by running:

```sh
minikube ip
```

This address is referenced in the rest of this documents as MINIKUBE_IP.

### 1.1. Enable ingress addon

```sh
minikube addons enable ingress
```

### 1.2 Install Reloader

```sh
kubectl apply -f https://raw.githubusercontent.com/stakater/Reloader/master/deployments/kubernetes/reloader.yaml
```
### 1.2. Add entires to /etc/hosts

Add these entry to /etc/hosts file

```
MINIKUBE_IP    www.local-minikube.io
MINIKUBE_IP    geodata.local-minikube.io
```
Change the address above with the IP address of minikube on your machine.

## 2. (Quick) Deploy geodata application to minikube

Simply run the following script:

```bash
./geodata-create.sh
```

To cleanup minikube from all geodata related objects execute:

```bash
./geodata-delete.sh
```

**Test deployment**

To test if everything is working properly, expose geodata-app by using this command:

```bash
kubectl expose deployment geodata-app-deployment --name geodata-app-lb \
   --type LoadBalancer --port 80 --target-port 8000 -n geodata
```

**Expose geodata application with Ingress:**

```bash
kubectl apply -f default/ingress-ns-default.yml
```
## 3. Configuring minikube resources (CPU/memory)

If minikube is lacking resources to run the objects created by the script above, you need to give it more cpu and memory than granted by default cnfiguration.

On macosx run:

```sh
minikube start start --vm=true --cpus=2 --memory 6072
```
Note: vm option is requiered due to the bug in 1.14 version which prevents ingress from running. For more see [https://github.com/kubernetes/minikube/issues/7332](https://github.com/kubernetes/minikube/issues/7332)

On Linux run:

```sh
minikube start start --cpus=2 --memory 6072
```