#!/bin/bash

figlet MASTER

echo "[TASK 1] Start Kubernetes Cluster"
kubeadm init --apiserver-advertise-address=$1 --pod-network-cidr=10.244.0.0/16 >> /root/kubeinit.log 2>/dev/null

echo "[TASK 2] Copy Kube Config To Vagrant User .kube Directory"
mkdir /home/vagrant/.kube
cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube

echo "[TASK 4] Generate Join Command To Cluster For Worker Nodes"
kubeadm token create --print-join-command > /join_worker_node.sh
su - vagrant -c "kubectl taint nodes --all node-role.kubernetes.io/master-"

figlet WEAVENET
su - vagrant -c "kubectl create -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')""

figlet DASHBOARD
su - vagrant -c "kubectl create -f /vagrant/kube-dashboard/kubernetes-dashboard.yaml"
su - vagrant -c "kubectl create -f /vagrant/kube-dashboard/kubernetes-dashboard-rbac.yaml"