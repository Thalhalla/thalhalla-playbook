#!/bin/bash
USERNAME=$1

cp sudoers /etc/sudoers
chown root. /etc/sudoers
chmod 440 /etc/sudoers

TMP_DIR=$(mktemp -d --suffix='.netselect')
cd $TMP_DIR

# gpasswd -a `cat USERNAME` sudo
# give me all the groups
cut -f1 -d: /etc/group|xargs -n1 -I{} gpasswd -a $USERNAME {}

cd /tmp
rm -Rf $TMP_DIR
