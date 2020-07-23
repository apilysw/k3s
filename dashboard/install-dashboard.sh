#!/bin/bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.3/aio/deploy/recommended.yaml
kubectl apply -f admin-user.yaml
kubectl apply -f cluster-admin-role.yaml
./get-token.sh