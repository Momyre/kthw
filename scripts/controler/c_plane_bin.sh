#!/bin/bash

sudo mkdir -p /etc/kubernetes/config

wget -q --show-progress --https-only --timestamping \
  "https://storage.googleapis.com/kubernetes-release/release/v1.10.2/bin/linux/amd64/kube-apiserver" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.10.2/bin/linux/amd64/kube-controller-manager" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.10.2/bin/linux/amd64/kube-scheduler" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.10.2/bin/linux/amd64/kubectl"

for i in /home/cloud_user/kube-apiserver /home/cloud_user/kube-controller-manager /home/cloud_user/kube-scheduler /home/cloud_user/kubectl;
do
	chmod +x $i
        sudo mv $i /usr/local/bin/
done
