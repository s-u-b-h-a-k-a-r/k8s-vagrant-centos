#!/bin/bash

figlet WORKER

#echo "[TASK 1] Create /mnt/fast-disks Directory For Local Volume Provisioning"
#mkdir /mnt/fast-disks
#chmod 777 -R /mnt/fast-disks
#for i in `seq 1 20`;
#	do
#		DIRNAME="vol$i"
#		mkdir -p /mnt/fast-disks/$DIRNAME 
#		chcon -Rt svirt_sandbox_file_t /mnt/fast-disks/$DIRNAME
#		chmod 777 /mnt/fast-disks/$DIRNAME
#       mount -t tmpfs -o size=10G $DIRNAME /mnt/fast-disks/$DIRNAME
#		echo "created directory $DIRNAME"
#done


#for i in `seq 21 40`;
#	do
#		DIRNAME="vol$i"
#		mkdir -p /mnt/fast-disks/$DIRNAME 
#		chcon -Rt svirt_sandbox_file_t /mnt/fast-disks/$DIRNAME
#		chmod 777 /mnt/fast-disks/$DIRNAME
 #       mount -t tmpfs -o size=5G $DIRNAME /mnt/fast-disks/$DIRNAME
#		echo "created directory $DIRNAME"
#done


# Join Worker Nodes To The Kubernetes Cluster
echo "[TASK 2] Join Node To Kubernetes Cluster"
yum install -q -y sshpass >/dev/null 2>&1
sshpass -p $1 scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $2:/join_worker_node.sh /join_worker_node.sh 2>/dev/null
bash /join_worker_node.sh >/dev/null 2>&1

echo "[TASK 3] Copy Kube Config To Vagrant User .kube Directory"
sshpass -p $1 scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $2:/etc/kubernetes/admin.conf /etc/kubernetes/admin.conf 2>/dev/null
mkdir /home/vagrant/.kube
cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube