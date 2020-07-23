#!/bin/bash

token=$(echo $2 | base64)
node=$3

if [ "$1" == "master" ]
then
  echo "creating master node"
  cmd="curl -sfL https://get.k3s.io | K3S_TOKEN=$token K3S_NODE_NAME=$node sh -s - server --disable traefik --disable servicelb --cluster-init"  
  ssh -t $node $cmd
elif [ "$1" == "join" ]
then
  echo "join as master node"
  cmd="curl -sfL https://get.k3s.io | K3S_TOKEN=$token K3S_NODE_NAME=$node sh -s - server --disable traefik --disable servicelb --server https://$4:6443"
  ssh -t $node $cmd
elif [ "$1" == "worker" ] 
then
  echo "creating worker node"
  cmd="curl -sfL https://get.k3s.io | K3S_TOKEN=$token K3S_NODE_NAME=$node K3S_URL=https://$4:6443 sh -s -"
  ssh -t $node $cmd
else 
  echo "invalid option: master, join or slave"
  echo "bootstrap-node master token node"
  echo "bootstrap-node join token node server"
  echo "bootstrap-node worker token node server"
fi
