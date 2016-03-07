#!/bin/bash

# libvirt
sudo cp -i 49-org.libvirt.unix.manager.rules /etc/polkit-1/rules.d/


TMP_DIR=$(mktemp -d --suffix='.thoth')
cd $TMP_DIR

# enable tmpfs for tmp
sudo systemctl enable tmp.mount
# VV
curl https://raw.githubusercontent.com/joshuacox/vv/master/bootstrapvv.sh |sudo bash
# Roustabout
curl https://raw.githubusercontent.com/joshuacox/roustabout/master/bootstraproustabout.sh |sudo bash
# bomsaway
curl https://raw.githubusercontent.com/joshuacox/bomsaway/master/bootstrapbomsaway.sh |sudo bash
# local-base
curl https://raw.githubusercontent.com/joshuacox/local-base/master/bootstrapbase.sh |sudo bash

# Freezing Cyril
mkdir -p ~/git
cd ~/git
git clone https://github.com/joshuacox/freezing-cyril.git
cd freezing-cyril
git pull
cd src
./freeze

sudo gpasswd -a $USER docker

# dotfiles
cd ~/git
git clone https://github.com/joshuacox/dotfiles.git
cd dotfiles
git pull
make

cd $TMP_DIR

LINE_TO_ADD='eval `keychain --eval id_rsa id_dsa id_ecdsa`'
ZSHRC_LOCATION=~/.zshrc
BASH_PROFILE_LOCATION=~/.bash_profile

check_if_line_exists_zshrc()
{
    # grep wont care if one or both files dont exist.
    grep -qsFx "$LINE_TO_ADD" $ZSHRC_LOCATION
}

add_line_to_zshrc()
{
  TARGET_FILE=$ZSHRC_LOCATION
    [ -w "$TARGET_FILE" ] || TARGET_FILE=$ZSHRC_LOCATION
    printf "%s\n" "$LINE_TO_ADD" >> "$TARGET_FILE"
}

check_if_line_exists_bash_profile()
{
    # grep wont care if one or both files dont exist.
    grep -qsFx "$LINE_TO_ADD" $BASH_PROFILE_LOCATION
}

add_line_to_bash_profile()
{
  TARGET_FILE=$BASH_PROFILE_LOCATION
    [ -w "$TARGET_FILE" ] || TARGET_FILE=$BASH_PROFILE_LOCATION
    printf "%s\n" "$LINE_TO_ADD" >> "$TARGET_FILE"
}

check_if_line_exists_zshrc || add_line_to_zshrc
check_if_line_exists_bash_profile || add_line_to_bash_profile

cd /tmp
rm -Rf $TMP_DIR
