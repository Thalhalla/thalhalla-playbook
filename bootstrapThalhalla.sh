#!/bin/bash
TMP_DIR=$(mktemp -d --suffix='.bomsaway')

cd $TMP_DIR
git clone https://github.com/thalhalla/thalhalla-playbook.git
cd thalhalla-playbook
echo `whoami`>USERNAME
cp hosts.example hosts
make local
cd
rm -Rf $TMP_DIR
