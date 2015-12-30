#!/bin/bash
TMP_DIR=$(mktemp -d --suffix='.bomsaway')

echo thalhalla
cd $TMP_DIR
git clone https://github.com/thalhalla/thalhalla-playbook.git
cd thalhalla-playbook
make full
cd
rm -Rf $TMP_DIR
