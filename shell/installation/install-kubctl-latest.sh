#!/bin/bash

working_dir=$PWD

# test if kubectl not is installed.
if ! command -v kubectl &> /dev/null ; then
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl"
fi

# test if minikube is not installed
if ! command -v minikube &> /dev/null ; then
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
    echo $HOME/.passwd | sudo -S install ${working_dir}/minikube-darwin-amd64 /usr/local/bin/minikube
fi
