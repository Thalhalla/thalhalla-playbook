#!/bin/bash
TMP_DIR=$(mktemp -d --suffix='.netselect')
cd $TMP_DIR

netselect-apt -ns -t 25 -o /etc/apt/sources.list jessie
apt-get -qq update

cd /tmp
rm -Rf $TMP_DIR
