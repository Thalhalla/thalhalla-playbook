#!/bin/bash

if [[ $USE_POWERPILL == 'true' ]]; then
  PACMAN=powerpill
else
  PACMAN=pacman
fi

install_jcx_utils () {
  curl -sL https://raw.githubusercontent.com/joshuacox/jcs/refs/heads/main/bootstrap.sh | bash
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
    check_hooks
    #sudo powerpill -S --noconfirm $TARGET
    sudo $PACMAN -S --noconfirm $TARGET
    if [[ $? -eq 0 ]]; then 
      export PAC_DID_SOMETHING=1
    elif [[ ! $? -eq 0 ]]; then 
      aur_adder $TARGET
    fi
    check_outhooks
    check_pull
    if [[ $PAC_DID_SOMETHING == 1 ]]; then
      echo "$TARGET" >> ./pacman_list
      sort_push
    fi
  fi
}

aur_adder () {
  set -x
  TARGET=$1
  cd $THIS_CWD
  PWD=$(pwd)
  if [[ $(grep -P "^${TARGET}$" aur_list) == "$TARGET" ]]; then
    echo 'Already added'
  else
    check_hooks
    cd $THIS_CWD
    aur_installer $TARGET | tee ${THIS_AUR_TMP}
    grep -P "No AUR package found for ${TARGET}" ${THIS_AUR_TMP} 
    if [[ $? -eq 0 ]]; then
      echo 'error: target not found'
      exit 1
    else
      export AUR_DID_SOMETHING=1
    fi
    cd $THIS_CWD
    check_outhooks
    cd $PWD
    check_pull
    if [[ $AUR_DID_SOMETHING == 1 ]]; then
      echo "$TARGET" >> ./aur_list
      sort_push
    fi
  fi
}

sort_push () {
  ./sorter
  git commit -s -S -am "$TARGET"
  git push
}

aur_installer () {
  TARGET=$1
  TMP=$(mktemp -d)
  set -eux
  cd $TMP
  yay -S \
    --answerclean All \
    --answerdiff All \
    --answeredit All \
    --answerupgrade Repo \
    --noconfirm \
    $TARGET 
}
