# How to use local postgres instance

This file explains how to use Postgres instance installed on host machine as database for geodata application.
It assumes that postgres is installed and is running on 5432 port.

## 1. Database setup 
(copy from geodata README.md)

If you already do not have it create database named: **geodata**. 
Connect to database with user that has sufficient privileges and execute:

```sql
CREATE DATABASE geodata;
```

The next step is to create **geodata** user and his corresponding schema.
To do so execute the following sql commands:

```sql
CREATE ROLE geodata NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN PASSWORD 'geodatapwd';
GRANT ALL PRIVILEGES ON DATABASE geodata TO geodata;
CREATE SCHEMA IF NOT EXISTS AUTHORIZATION "geodata";
```

## 2. Allow connections to local Postgres from minikube 

Find out location of postgres.conf, to do so execute:

```bash
sudo -u postgres psql -c 'SHOW config_file'
```
Edit postgres.conf and pg_hba.conf files: 

* add the line `listen_addresses = '*'` to postgres.conf
* add the line `host all all MINIKUBE_IP/24 md5` to pg_hba.conf
* restart the postgres service

On Ubuntu issue:
```bash
sudo service postgresql restart
```

## 3. Create ExternalName service for access to host postgres instance

For this, we need to create **ExternalName** type service that points to host Postgres instance.

Execute the following:
```bash
kubectl apply -f default/postgres-host-svc.yml
```

Now host database can be used by deployed apps through `postgres-db-svc.default.svc.cluster.local`.
