#!/bin/bash
TMP_DIR=$(mktemp -d --suffix='.thalhalla')

cd $TMP_DIR
sudo apt-get update
sudo apt-get install -y git build-essential curl aptitude \
python-pip python-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev libjpeg8-dev zlib1g-dev
git clone https://github.com/thalhalla/thalhalla-playbook.git
cd thalhalla-playbook
echo `whoami`>USERNAME
echo `whoami`>MYID
cp hosts.example hosts
echo `lsb_release -cs`
make `lsb_release -cs`
cd
sudo rm -Rf $TMP_DIR
