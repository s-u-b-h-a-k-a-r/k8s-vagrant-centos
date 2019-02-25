#!/bin/bash

figlet TILLER

su - vagrant -c "kubectl --namespace kube-system create serviceaccount tiller"
su - vagrant -c "kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller"
su - vagrant -c "helm init --service-account tiller --upgrade"