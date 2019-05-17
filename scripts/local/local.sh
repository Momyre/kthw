#!/bin/bash

cd ~/kthw

sudo kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=/home/moma/kthw/ca.pem \
  --embed-certs=true \
  --server=https://localhost:6443

sudo kubectl config set-credentials admin \
  --client-certificate=/home/moma/kthw/admin.pem \
  --client-key=/home/moma/kthw/admin-key.pem

sudo kubectl config set-context kubernetes-the-hard-way \
  --cluster=kubernetes-the-hard-way \
  --user=admin

sudo kubectl config use-context kubernetes-the-hard-way


