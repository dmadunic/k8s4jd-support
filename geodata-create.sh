#!/bin/bash

usage(){
 cat << EOF
 Usage: $0 -a
 Description: Create geodata namespace, geodata-rest, geodata-web and postgres instance
[OR]
 Usage: $0 -g
 Description: Create only geodata namespace, geodata-rest, geodata-web but no database
[OR]
 Usage: $0 -p
 Description: Create only postgres database

EOF
exit 0
}

default() {
    postgres;
    geodata;
}

postgres() {
    kubectl create -f postgres/postgres-sv.yml
    kubectl create -f postgres/postgres-pvc.yml
    kubectl apply -f postgres/postgres-deployment.yml
    kubectl apply -f postgres/postgres-service.yml
}

geodata() {
    kubectl create -f geodata/namespace.yml
    kubectl apply -f geodata/geodata-config.yml
    kubectl apply -f geodata/geodata-secret.yml
    kubectl apply -f geodata/rest/geodata-rest-service.yml
    kubectl apply -f geodata/rest/geodata-rest-deployment.yml
    kubectl apply -f geodata/web/geodata-web-service.yml
    kubectl apply -f geodata/web/geodata-web-deployment.yml
    kubectl apply -f default/geodata-service-svc.yml
}

#kubectl apply -f default/ingress-ns-default.yml

[[ "$@" =~ ^-[agp]{1}$ ]]  || usage;

while getopts ":agp" opt; do
    case ${opt} in
    a ) echo "Createing geodata namespace and all objects (rest-api, web and database)"; default ;;
    g ) echo "Createing only geodata namespace objects (rest-api, web)"; geodata ;;
    p ) echo "Creating only postgres"; postgres ;;
    \? | * ) usage ;;
    esac
done
