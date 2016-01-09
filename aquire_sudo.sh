#!/bin/bash

USERNAME=`cat USERNAME`

apt-get update
apt-get install -y sudo

# gpasswd -a `cat USERNAME` sudo
# give me all the groups
cut -f1 -d: /etc/group|xargs -n1 -I{} gpasswd -a $USERNAME {}

cp sudoers /etc/sudoers
chown root. /etc/sudoers
chmod 440 /etc/sudoers
