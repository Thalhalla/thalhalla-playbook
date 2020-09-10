#!/bin/bash

install_black_arch () {
  # Run https://blackarch.org/strap.sh as root and follow the instructions.
  curl -O https://blackarch.org/strap.sh

  # Verify the SHA1 sum
  echo 9c15f5d3d6f3f8ad63a6927ba78ed54f1a52176b strap.sh | sha1sum -c

  # Set execute bit
  chmod +x strap.sh

  # Run strap.sh
  sudo ./strap.sh

  # Enable multilib following https://wiki.archlinux.org/index.php/Official_repositories#Enabling_multilib and run:
  sudo powerpill -Syyu --needed blackarch --overwrite='*'
}

main () {
  TMP=$(mktemp -d)
  cd $TMP
  install_black_arch
  cd
  rm -Rf $TMP
}

main
