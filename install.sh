#!/bin/bash

ROOT="$(pwd)"
K8S_MANIFESTS="${ROOT}/resources/k8s-manifests"

# minkube commands
MINIK8S_START="minikube start"
MINIK8S_STOP="minikube stop"

sh $MINIK8S_START

kubectl create namespace jenkins-pipeline
kubectl apply -f "${K8S_MANIFESTS}/serviceAccount.yaml"
kubectl create -f "${K8S_MANIFESTS}/volume.yaml"

# install Jenkins on k8s
kubectl apply -f "${K8S_MANIFESTS}/deployment.yaml"

# double-check k8s deployment
kubectl get deployments -n jenkins-pipeline
kubectl describe deployments --namespace=jenkins-pipeline

kubectl apply -f "${K8S_MANIFESTS}/service.yaml"

