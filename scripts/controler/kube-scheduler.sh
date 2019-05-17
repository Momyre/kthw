#!/bin/bash

sudo cp /home/cloud_user/kube-scheduler.kubeconfig /var/lib/kubernetes/

# Generating kube-scheduler yaml config file

cat << EOF | sudo tee /etc/kubernetes/config/kube-scheduler.yaml
apiVersion: componentconfig/v1alpha1
kind: KubeSchedulerConfiguration
clientConnection:
  kubeconfig: "/var/lib/kubernetes/kube-scheduler.kubeconfig"
leaderElection:
  leaderElect: true
EOF

# Creating the kube-scheduler systemd unit file

cat << EOF | sudo tee /etc/systemd/system/kube-scheduler.service
[Unit]
Description=Kubernetes Scheduler
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-scheduler \\
  --config=/etc/kubernetes/config/kube-scheduler.yaml \\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

# Enabling the full control plane service

sudo systemctl daemon-reload
sudo systemctl enable kube-apiserver kube-controller-manager kube-scheduler
sudo systemctl start kube-apiserver kube-controller-manager kube-scheduler

# Verification that everything is ok

sudo systemctl status kube-apiserver kube-controller-manager kube-scheduler

# Kubectl component status check

kubectl get componentstatuses --kubeconfig /home/cloud_user/admin.kubeconfig
