#!/bin/bash
. lib/loader.bash

# libvirt
#sudo cp -i 49-org.libvirt.unix.manager.rules /etc/polkit-1/rules.d/


mkdir -p ~/git
TMP_DIR=$(mktemp -d --suffix='.thoth')
cd $TMP_DIR

# enable tmpfs for tmp
#sudo systemctl enable tmp.mount

install_jcx_utils

# Freezing Cyril
#cd ~/git
#git clone https://github.com/joshuacox/freezing-cyril.git
#cd freezing-cyril
#git pull
#cd src
#./freeze

sudo gpasswd -a $USER docker

# dotfiles
#cd ~/git
#git clone https://github.com/joshuacox/dotfiles.git
#cd dotfiles
#git pull
#make

cd $TMP_DIR

LINE_TO_ADD='eval `keychain --eval id_rsa id_dsa id_ecdsa`'
ZSHRC_LOCATION=~/.zshrc
BASH_PROFILE_LOCATION=~/.bash_profile
liner

cd /tmp
rm -Rf $TMP_DIR
