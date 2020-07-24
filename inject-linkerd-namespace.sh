#!/bin/bash
kubectl annotate namespace $1 linkerd.io/inject=enabled
