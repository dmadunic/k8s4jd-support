# K8s for Java Developers workshop (step by step)

## Prerequisites

### Installed tools
- docker
- minikube

## Setup minikub
See the **"Minikube setup"** section in README.md


## 1. Deploy postgres

```bash
kubectl create -f postgres/postgres-sv.yml
kubectl create -f postgres/postgres-pvc.yml
```

Check if all went well by issueing:

```bash
kubectl get pvc
```
You should see the similar output:

```bash
NAME                STATUS   VOLUME        CAPACITY   ACCESS MODES   STORAGECLASS   AGE
postgres-pv-claim   Bound    postgres-pv   5Gi        RWX            manual         35s
```

Now lets deploy postgres to kubernetes

```bash
kubectl apply -f postgres/postgres-deployment.yml
```

We need to expose database to others as service, so execue the following command:

```bash
kubectl apply -f postgres/postgres-service.yaml
```

To chek if all is working well, execute:

```bash
kubectl get service postgres-service
```

You shoud see something like:

```
NAME               TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
postgres-service   ClusterIP   10.106.77.188   <none>        5432/TCP   7m25s
```

We can expose this service, to the outside world by using port forwarding:

```bash
kubectl port-forward service/postgres-service 5435:5432
```

**Now starup dbeaver and connect to databse on localhost:5435**

Once all is working as expected kill port-forwar by pressing ^C inside the terminal.

# 2. Create geodata namespace

Position yourself in terminal in the root folder of this repository.

```bash
kubectl create -f geodata/namespace.yml
```

## Deploy geodata-rest application

```bash
kubectl apply -f geodata/geodata-config.yml
kubectl apply -f geodata/geodata-secret.yml
```
Now it is time to create geodata-rest deployment and service:

```bash
kubectl apply -f geodata/rest/geodata-rest-deployment.yml
kubectl apply -f geodata/rest/geodata-rest-service.yml
```

## Deploy geodata-web application

```bash
kubectl apply -f geodata/web/geodata-web-deployment.yml
kubectl apply -f geodata/web/geodata-web-service.yml
```

## Create ingress and exposose geodata app

```bash
kubectl apply -f geodata/ingress.yml
```
Executing the command above will creat, in geodata namespace, an ingress service that exposes geodata-web application on url: `geodata.local-minikube.io` on port 80.

## Single ingress in the default namespace

TODO:
- Remove ingress service created in geodata namespace
- Create external service for geodata-web-service
- Create ingress in default namespace


