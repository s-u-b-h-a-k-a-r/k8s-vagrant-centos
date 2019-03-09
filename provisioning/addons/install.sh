#!/bin/bash

figlet ADDONS

#figlet LOCALVOLUMES
#su - vagrant -c "kubectl create -f /vagrant/local-volume/default_service.yaml"
#su - vagrant -c "kubectl create -f /vagrant/local-volume/default_storageclass.yaml"
#su - vagrant -c "kubectl create -f /vagrant/local-volume/default_provisioner_generated.yaml"

#figlet METRICSSERVER
#su - vagrant -c "helm install stable/metrics-server --name metrics-server"

figlet NFS-CLIENT
su - vagrant -c "helm install stable/nfs-client-provisioner --name nfs-client-provisioner --set nfs.server=$1 --set nfs.path=/mnt/storage --set storageClass.defaultClass=true"