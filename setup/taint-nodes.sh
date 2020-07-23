#!/bin/bash

for node in "$@"
do
    cmd="sudo kubectl taint nodes $node node-role.kubernetes.io/master=effect:NoSchedule"
    ssh -t $node $cmd
done