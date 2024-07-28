#!/bin/bash

install_jcx_utils () {
  # VV
  curl https://raw.githubusercontent.com/joshuacox/vv/master/bootstrapvv.sh |sudo bash
  # Roustabout
  curl https://raw.githubusercontent.com/joshuacox/roustabout/master/bootstraproustabout.sh |sudo bash
  # bomsaway
  curl https://raw.githubusercontent.com/joshuacox/bomsaway/master/bootstrapbomsaway.sh |sudo bash
  # SSShutdown
  curl -sL https://git.io/ssshutdown | bash
  # Swappy
  curl https://raw.githubusercontent.com/joshuacox/swappy/master/bootstrap | bash
  # Passgen
  curl https://raw.githubusercontent.com/joshuacox/passgen/master/bootstrappassgen.sh | sh
  # wg-init
  curl https://raw.githubusercontent.com/joshuacox/wg-init/main/bootstrap | sh
  # Clip
  curl -sL https://git.io/clipinstall | bash
}

puller () {
  git pull
  date -I > /tmp/thalhalla-playbook-pulled-today
}

check_pull () {
  if [[ ! -f /tmp/thalhalla-playbook-pulled-today ]]; then
    puller
  elif [[ ! "$(date -I)" == "$(cat /tmp/thalhalla-playbook-pulled-today)" ]]; then
    puller
  else
    echo 'skip pull'
  fi
}

check_hooks () {
  if [[ -f /etc/ssshutdown/hooks/in ]]; then
    echo 'Found in hook'
    sudo bash /etc/ssshutdown/hooks/in
  fi
}

check_outhooks () {
  if [[ -f /etc/ssshutdown/hooks/out ]]; then
    echo 'Found out hook'
    sudo bash /etc/ssshutdown/hooks/out
  fi
}

adder () {
  TARGET=$1
  if [[ $(grep -P "^${TARGET}$" pacman_list) == "$TARGET" ]]; then
    echo 'Already added'
  else
    export DID_SOMETHING=1
    check_hooks
    sudo powerpill -S --noconfirm $TARGET
    check_outhooks
    check_pull
    echo "$TARGET" >> ./pacman_list
  fi
}

bauer_adder () {
  TARGET=$1
  if [[ $(grep -P "^${TARGET}$" bauerbill_list) == "$TARGET" ]]; then
    echo 'Already added'
  else
    export DID_SOMETHING=1
    check_hooks
    bauerbill_installer $TARGET
    check_outhooks
    check_pull
    echo "$TARGET" >> ./bauerbill_list
  fi
}

bauerbill_installer () {
  TARGET=$1
  TMP=$(mktemp -d)
  set -eux
  cd $TMP
  bauerbill -S --aur $TARGET
  cd build
  if [[ -f ./download.sh ]]; then 
    yes M | ./download.sh
  fi
  if [[ -f ./build.sh ]]; then 
    yes y | ./build.sh
  fi
  if [[ -f ./clean.sh ]]; then 
    ./clean.sh
  fi
}
