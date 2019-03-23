# k8s-vagrant-centos
![enter image description here](https://lh3.googleusercontent.com/u-UVCZJHQiRnsgebzsHX6igGyEBSrwCCqwM9wSgchqnygIIJRtwkYFMaVmWVJdQ4kHKDWMLnQ0QkiQ)

# About...

This setup is used to create ***kubernetes*** cluster on  ***local laptop / desktop*** using vagrant - with this we can create a ***two node cluster setup*** which contains ***one master*** and ***one worker node*** with one single command.


# Table of Contents

* [What are the prerequisites ?](#prerequisites)
* [How to deploy kubernetes cluster ?](#deploy)
* [What are the addons provided ?](#addons)
* [What are the VM's configured ?](#configuration)
* [How to access Kubernetes Dashboard ?](#dashboard)
* [How to access Vagrant VM's ?](#access)
* [How to stop Vagrant VM's ?](#stop)
* [How to restart Vagrant VM's ?](#restart)
* [How to destroy Vagrant VM's ?](#destroy)


<a id="prerequisites"></a>
# What are the prerequisites ?
* [Git](https://git-scm.com/downloads "Git")
* [Vagrant](https://www.vagrantup.com/downloads.html "Vagrant")
* [Oracle Virtual Manger](https://www.oracle.com/technetwork/server-storage/virtualbox/downloads/index.html "Oracle Virtual Manger")
* `Virtualization needes to be enabled in System BIOS`
* `Minimum laptop/desktop configuration  - 32GB RAM / 8CPU (not to worry base OS will balance the cpu need on time sharing model), 80GB hdd disk space`




<a id="deploy"></a>
# How to deploy kubernetes cluster ?
* Open `bash` terminal 
* Checkout the code  (git clone https://github.com/SubhakarKotta/k8s-vagrant-centos.git) 
* `$ cd k8s-vagrant-centos/provisioning` 

Default settings:`Vagrantfile`
```yaml
VM:
  password: kubeadmin
  master:
    ip: 100.10.10.100
    cpus: 2
    memory: 2048
    vmname: kmaster
    hostname: kmaster.example.com
  worker1:
    ip: 100.10.10.101
    cpus: 3
    memory: 16384
    vmname: kworker1
    hostname: kworker1.example.com
```
    
    
By running the below command kubernetes cluster will be created with 2 Centos VM's installed.
	
* `vagrant up`



<a id="addons"></a>
# What are the addons provided ?
[***helm***](https://helm.sh/docs/install/) /  [***kubernetes-dashboard***](https://github.com/helm/charts/tree/master/stable/kubernetes-dashboard) / [***nfs-volume-provisioner***](https://github.com/helm/charts/tree/master/stable/nfs-client-provisioner)

<a id="configuration"></a>
# What are the VM's configured ?
By default below are the IP Addresses that will be configured for the VM's

Name|IP|OS|RAM|CPU|
|----|----|----|----|----|
kmaster  |100.10.10.100|CentOS7|2 GB|2|
kworker1 |100.10.10.101|CentOS7|16GB|3|


<a id="dashboard"></a>
# How to access Kubernetes Dashboard ?
The ***Kubernetes Dashboard*** can be accessed via the below ***URL*** without any changes from your host machine

[http://100.10.10.100:30070/#!/overview?namespace=_all](http://100.10.10.100:30070/#!/overview?namespace=_all)


<a id="access"></a>
# How to access Vagrant VM's ?

The Vagrant VM can be accessed in two ways

1) ***Login*** through ***vagrant ssh***
* `$ cd k8s-vagrant-centos/provisioning`
* `$ vagrant ssh kmaster`
* `$ vagrant ssh kworker1`

2) ***Login*** through ***putty***
* `100.10.10.100 / 100.10.10.101` [Username/Password:***vagrant/vagrant (OR) root/kubeadmin***]


<a id="stop"></a>
# How to stop Vagrant VM's ?
* `$ cd k8s-vagrant-centos/provisioning`
* `$ vagrant halt`

<a id="restart"></a>
# How to restart Vagrant VM's ?
* `$ cd k8s-vagrant-centos/provisioning`
* `$ vagrant up`

<a id="destroy"></a>
# How to destroy Vagrant VM's ?
* `$ cd k8s-vagrant-centos/provisioning`
* `$ vagrant destroy`
