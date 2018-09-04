# DevOps Challenge

This repo contains code for a multi-tier application.

The application overview is as follows:
```
                    +------------+                         +------------+
                <=> | (web tier) | <=>                 <=> | (api tier) | <=>
(load balancer) <=> | (web tier) | <=> (load balancer) <=> | (api tier) | <=> (db)
                <=> | (web tier) | <=>                 <=> | (api tier) | <=>
                    +------------+                         +------------+
```

The folders `web` and `api` respectively describe how to install and run each app.

## Deliverables

This challenge is divided in multiples parts(deliverables). You don't need to finish all. Show us what do you finished.

### Deliverable 1 - Docker

1. Create [web](./web) `Dockerfile`
1. Create [api](./api) `Dockerfile`
1. Define a `docker-compose.yml` in the project root that run the `web` and `api` with a simple `docker-compose up`
1. Publish the image in a public registry with the command `docker-compose push web api`


### Deliverable 2 - Kubernetes cluster and PostgreSQL

1. Using IAC(infrastructure as code) create a Kubernetes cluster
1. Using IAC(infrastructure as code) create a PostgreSQL database

### Deliverable 3 - api and database tiers terraform script

1. Deploy [api](./api) service on cluster
1. Configure the database credentials in a security way

### Deliverable 4 - web tier terraform script

1. Deploy [web](./web) service on cluster
1. Create a Load Balancer pointing to **web application**

### PLUS

1. Solution must handle instance container failures
1. WEB and API tiers must have multiple instances
1. Deploy of new version without downtime
1. WEB should access API using a Internal Load Balancer

## Observation

Please specify all steps needed to execute and see the application working.

The scripts should be delivered as a public repo on Github or a pull-request made against the <https://github.com/robsonpeixoto/devops-challenge-apps> repo

