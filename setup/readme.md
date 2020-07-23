# Kubernetes Cluster Setup

This document details the steps required to build a cluster. 
The cluster uses [K3s](https://k3s.io) to provide a simple stripped down cluster
suited for low memory requirements.

You will need a bash shell to run the setup scripts, this does not have to be a node in the cluster.

To simplify setup there are some scripts to complete the steps.

## Setup the machines

* Optionally with 2 network cards 
	
	* main access to the network 
	* private cluster only network

* Setup machines to use as nodes
	
	* update OS
	* setup networking
		* /etc/hosts
		* static ip addresses
	* turn off swap `sudo swapoff -a`
	* install curl
	* install openssh-server
	* optionally add authorised ssh keys

## Install

### Master Nodes

#### Create Initial Master

Initialise a new cluster, token is a value shared between nodes

```bash
$ bootstrap-node master token server
```

#### Join Master Node

Add a master node to the cluster

```bash
$ bootstrap-node join token server master_ip
```

#### Taint nodes

In order to restrict pods scheduling on the master nodes you can 
taint the nodes using the `taint-nodes node-a [other_node another_node]` script.

### Join Worker Node

Add a worker node to the cluster

```bash
$ bootstrap-node worker token server master_ip
```

### Configuration

In order to access the cluster using `kubectl` then you will need a copy of the 
cluster configuration file.

This can be retrieved using

```bash
$ ssh -t server sudo k3s kubectl config view --raw=true
```

Replace the value of **127.0.0.1** in the key **clusters.cluster.server**  with the IP address of a master node.

Obtain a copy of `kubectl` for working with the cluster.

```bash
$ curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
```
