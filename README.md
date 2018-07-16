# Global Microservices using K8s and Federation

This is an application that can be used to demonstrate the capabilities of K8s to control multiple clusters and create an ingress object that will perform as the Global L7 (http/s) load balancer to route traffic to the most geographically appropriate instance.

## How do I run this?

The Makefile is your friend. 

This repo was created as part of a presentation to demonstrate Multi-cluster Ingress (kubemci is still a long way off, which gives you easy multi-cluster capability)

## Makefile contents

**create-allclusters** is the starting point. 

Once all clusters have been created, you would need to prepare/cleanup the context environment as laid out in the k8s documentation [here](https://kubernetes.io/docs/tasks/federation/set-up-cluster-federation-kubefed/)

This is achieved by **prepare-contexts**

**Questions, reach out to me!**