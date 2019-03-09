# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.require_version ">= 2.2.0"
ENV['VAGRANT_NO_PARALLEL'] = 'yes'

require File.dirname(__FILE__)+"/dependency_manager"
# Automatically install required vagrant plugins
check_plugins ["vagrant-reload", "vagrant-vbguest", "vagrant-timezone", "vagrant-disksize"]

Vagrant.configure(2) do |config|
  config.vm.provision "shell", path: "vm-prerequisites/install.sh",:args => ["kubeadmin"]
  # Kubernetes Master Node
  config.vm.define "kmaster" do |kmaster|
    kmaster.vm.box = "centos/7"
    kmaster.disksize.size = '200GB'
    kmaster.vm.hostname = "kmaster.example.com"
    kmaster.vm.network "private_network", ip: "100.10.10.100"
    kmaster.vm.provider "virtualbox" do |v|
      v.name = "kmaster"
      v.memory = 2048
      v.cpus = 2
    end
    kmaster.vm.provision "shell", path: "vm-master/install.sh",:args => ["100.10.10.100"]
    kmaster.vm.provision "shell", path: "helm/install.sh"
    kmaster.vm.provision "shell", path: "helm/install_tiller.sh"  
  end

  NodeCount = 1
  # Kubernetes Worker Nodes
  (1..NodeCount).each do |i|
    config.vm.define "kworker#{i}" do |workernode|
      workernode.vm.box = "centos/7"
      workernode.vm.hostname = "kworker#{i}.example.com"
      workernode.vm.network "private_network", ip: "100.10.10.10#{i}"
      workernode.vm.provider "virtualbox" do |v|
        v.name = "kworker#{i}"
        v.memory = 16384
        v.cpus = 3
      end
      workernode.vm.provision "shell", path: "vm-worker/install.sh",:args => ["kubeadmin","kmaster.example.com"]
      workernode.vm.provision "shell", path: "helm/install.sh"
      workernode.vm.provision "shell", path: "addons/install.sh",:args => ["100.10.10.100"]
    end
  end
end