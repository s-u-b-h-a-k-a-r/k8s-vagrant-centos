#!/bin/bash

figlet HELM

export PATH=/bin:/usr/bin:/usr/local/bin
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
chmod +x get_helm.sh
./get_helm.sh
su - vagrant -c "helm init"


