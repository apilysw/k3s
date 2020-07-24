#!/bin/bash

$namespace=$1
$replicase=$2||0

kubectl create namespace $namespace
helm repo add elastic https://helm.elastic.co
helm repo update

if [ $replicas -gt 0]; then 
    helm install elasticsearch elastic/elasticsearch -n $namespace --replicas $replicas
else
    helm install elasticsearch elastic/elasticsearch -n $namespace
fi