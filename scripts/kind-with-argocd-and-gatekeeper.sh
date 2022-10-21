#!/bin/bash

# Create Kind cluster with ArgoCD and GateKeeper

set -eu

kind create cluster --name kind-argocd-gatekeeper

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts
helm install gatekeeper/gatekeeper --name-template=gatekeeper --namespace gatekeeper-system --create-namespace --set replicas=1 --set psp.enabled=false --timeout 10m