#!/bin/bash

sudo systemctl status containerd kubelet kube-proxy

sleep 5

kubectl get nodes
