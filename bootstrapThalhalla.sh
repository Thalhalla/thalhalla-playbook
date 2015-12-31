#!/bin/bash
TMP_DIR=$(mktemp -d --suffix='.bomsaway')

cd $TMP_DIR
#sudo apt-get update 
sudo apt-get install -y git sudo build-essential
git clone https://github.com/thalhalla/thalhalla-playbook.git
cd thalhalla-playbook
echo `whoami`>USERNAME
cp hosts.example hosts
make local
cd
sudo rm -Rf $TMP_DIR
