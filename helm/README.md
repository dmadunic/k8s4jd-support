# Geodata Helm chart

This chart offers two options for Postgres database:
- use host managed instance: in this scenario only postgres-service that points to an external postgres instance will be installed
- deploy postgres to kubernetes cluster: this will install postgres database, postgres-service, peristence-volume and persitence-claim

In addition, this chart will install the following:
- geodata namespace
- geodata-config config map
- geodata-secret secret map
- geodata-rest
- geodata-web
- ingress

All these resources (including postgres database) will be created in **geodata** namespace.

# Configuring postgres

The following value, by default, defines that postgres image should be installed in kubernetes cluster.

```yaml
postgres:
  deploy: true
```
This is the default behaviour of the chart. It will deploy postgres database to kubernetes cluster and initialize it geodata database in it, and add role *geodata* with *geodatapwd* credentials to it.


To deploy geodata application without postgres database, create custom **values.yml** file:

```yaml
postgres:
  deploy: true
  port: 5432
  host:
    address: address-of-your-host
  database:
    name: geodata (change it based on your settings)
    user: geodata (change it based on your settings)
    password: geodatapwd (change it based on your settings)
    schema: public (change it based on your settings)
```

Then run helm install with this custom values file:

```bash
helm install -f values.yaml geodata
```


# Testing chart

After cloning this repository, open the terminal and position yourself in the **helm** folder of this project, and execute:
```
helm install --debug --dry-run geodata ./geodata
```

(c) Domagoj Madunić 2022.