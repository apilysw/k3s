#!/bin/bash

for node in "$@"
do
    cmd="sudo shutdown now"
    ssh -t $node $cmd
done
