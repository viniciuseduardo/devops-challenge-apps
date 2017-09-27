# DevOps Challenge

This repo contains code for a multi-tier application.

The application overview is as follows: `web <=> api <=> db`

The folders `web` and `api` respectively describe how to install and run each app.

# DevOps Challenge

Create the a Terraform script to deploy the multi-tier application with source code hosted at https://github.com/guarilha/devops-challenge-apps

## Instructions

1. Web and api tiers must have multiple container instances.
2. API needs one database (PostgreSQL) and this service needs be in a container.
3. Solution should support docker image versioning
4. Solution should write all the logs an ELK stack (on a different docker container)
5. Solution must handle instance and container failures
6. Result of running the scripts should be two publicly available tiers: web and api
7. We should be able to run the script against our own AWS infrastructure and be able to launch the same tiers with minimal custom configuration or install steps. Please specify the command to execute and any setup required to ensure a successful run. Again, please specify how you would expect we can access each service via curl

The scripts should be delivered as a public repo on Github or a pull-request made against the <https://github.com/guarilha/devops-challenge-apps> repo

