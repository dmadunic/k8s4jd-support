#!/bin/bash

usage(){
 cat << EOF
 Usage: $0 -d
 Description: Create geodata namespace, geodata-rest, geodata-web and postgres instance
[OR]
 Usage: $0 -g
 Description: Create only geodata namespace, geodata-rest, geodata-web but no database
[OR]
 Usage: $0 -p
 Description: Create only postgres database
[OR]
 Usage: $0 -a
 Description: Create geodata namespace, geodata-app (monolith) and postgres instance
EOF
exit 0
}

kubectl create -f postgres/postgres-sv.yml
kubectl create -f postgres/postgres-pvc.yml
kubectl apply -f postgres/postgres-deployment.yml

kubectl create -f geodata/namespace.yml

kubectl apply -f geodata/geodata-config.yml
kubectl apply -f geodata/geodata-secret.yml
kubectl apply -f geodata/rest/geodata-service.yml
kubectl apply -f geodata/geodata-app-deployment.yml

kubectl apply -f default/geodata-service-svc.yml

#kubectl apply -f default/ingress-ns-default.yml

[[ "$@" =~ ^-[dneb]{1}$ ]]  || usage;

while getopts ":dneb" opt; do
    case ${opt} in
    d ) echo "Createing erpy namespace and all objects"; default ;;
    g ) echo "Createing only erpy namespace and default objects"; namespace ;;
    p ) echo "Creating only erpy-web objects"; erpy ;;
    a ) echo "Creating only batchui objects:"; batchui ;;
    \? | * ) usage ;;
    esac
done
