#!/bin/bash
yum -y update
yum -y install epel-release
yum -y install figlet

figlet PRE-REQISITES

echo "[TASK 1] Update /etc/hosts"
cat >>/etc/hosts<<EOF
100.10.10.100  kmaster kmaster.example.com
100.10.10.101  kworker1  kworker1.example.com
100.10.10.102  kworker2  kworker2.example.com
EOF

echo "[TASK 2] Install Docker Container Engine"
yum install -y -q yum-utils curl unzip git nano wget device-mapper-persistent-data lvm2 > /dev/null 2>&1
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo > /dev/null 2>&1
yum install -y -q docker-ce >/dev/null 2>&1

echo "[TASK 3] Enable and Start Docker Service"
systemctl enable docker >/dev/null 2>&1
systemctl start docker

echo "[TASK 4] Disable SELinux"
setenforce 0
sed -i --follow-symlinks 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux

echo "[TASK 5] Stop and Disable Firewalld"
systemctl disable firewalld >/dev/null 2>&1
systemctl stop firewalld

echo "[TASK 6] Add Sysctl Settings"
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system >/dev/null 2>&1

echo "[TASK 7] Disable and Turn Off SWAP"
sed -i '/swap/d' /etc/fstab
swapoff -a

echo "[TASK 8] Add YUM Repo File For Kubernetes"
cat >>/etc/yum.repos.d/kubernetes.repo<<EOF
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
        https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

echo "[TASK 9] Install kubeadm, kubelet and kubectl"
yum install -y -q kubeadm-1.15.3 kubelet-1.15.3 kubectl-1.15.3 >/dev/null 2>&1

echo "[TASK 10] Enable and Start Kubelet Service"
systemctl enable kubelet >/dev/null 2>&1
systemctl start kubelet >/dev/null 2>&1

echo "[TASK 11] Enable SSH Password Authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd

echo "[TASK 12] Setting Root Password"
echo ${1} | passwd --stdin root >/dev/null 2>&1
echo "export TERM=xterm" >> /etc/bashrc


echo "[TASK 13] Install nfs"
yum -y install nfs-utils
systemctl enable nfs-server.service
systemctl start nfs-server.service
mkdir /mnt/storage
chmod 777 -R /mnt
cat >>/etc/exports<<EOF
/mnt/storage *(rw,sync,no_root_squash,no_subtree_check)
EOF
exportfs -a

