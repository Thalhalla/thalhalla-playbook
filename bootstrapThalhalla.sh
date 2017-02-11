#!/bin/bash
TMP_DIR=$(mktemp -d --suffix='.thalhalla')

cd $TMP_DIR
#sudo apt-get update 
sudo apt-get install -y git build-essential curl
git clone https://github.com/thalhalla/thalhalla-playbook.git
cd thalhalla-playbook
echo `whoami`>USERNAME
cp hosts.example hosts
make `lsb_release -cs`
cd
sudo rm -Rf $TMP_DIR
