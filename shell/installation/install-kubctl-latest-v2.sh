#!/bin/bash

working_dir=$PWD
OSTYPE=`uname | tr [:upper:] [:lower:]`
ARCH=`uname -p`

if [[ "$ARCH" == "aarch64" ]]; then
    ARCH=arm64
fi

# test if kubectl not is installed.
if ! command -v kubectl &> /dev/null ; then
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/${OSTYPE}/${ARCH}/kubectl"
    chmod +x ./kubectl
    cat $HOME/.passwd | grep $USER | cut -d ':' -f2 | sudo -S mv kubectl /usr/local/bin/
fi

# test if minikube is not installed
if ! command -v minikube &> /dev/null ; then
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-${OSTYPE}-${ARCH}
    cat $HOME/.passwd | grep $USER | cut -d ':' -f2 | sudo -S install ${working_dir}/minikube-${OSTYPE}-${ARCH} /usr/local/bin/minikube
fi

