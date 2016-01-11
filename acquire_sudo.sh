#!/bin/bash

#USERNAME=`cat USERNAME`
USERNAME=$1
TMP_DIR=$(mktemp -d --suffix='.netselect')
cd $TMP_DIR

# apt-get -qq update
apt-get update
apt-get install -y sudo netselect-apt
netselect-apt -ns -t 25 -o /etc/apt/sources.list jessie
apt-get update

# gpasswd -a `cat USERNAME` sudo
# give me all the groups
cut -f1 -d: /etc/group|xargs -n1 -I{} gpasswd -a $USERNAME {}

cp sudoers /etc/sudoers
chown root. /etc/sudoers
chmod 440 /etc/sudoers

cd /tmp
rm -Rf $TMP_DIR
