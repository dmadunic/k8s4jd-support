#!/bin/bash
kubectl delete -n geodata deployment geodata-rest-deployment
kubectl delete -n geodata deployment geodata-web-deployment
kubectl delete -n geodata service geodata-rest-service
kubectl delete -n geodata service geodata-web-service
kubectl delete -n geodata configmap geodata-config
kubectl delete -n geodata secret geodata-secret

kubectl delete ns geodata

kubectl delete -n default service geodata-service-svc

kubectl delete service postgres-service
kubectl delete deployment postgres
kubectl delete pvc postgres-pv-claim
kubectl delete pv postgres-pv