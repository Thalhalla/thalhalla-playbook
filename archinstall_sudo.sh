#!/bin/bash
pacman -Syu --noconfirm
pacman -S --noconfirm sudo reflector
#curl -o /etc/pacman.d/mirrorlist https://www.archlinux.org/mirrorlist/all/
reflector --verbose --country 'United States' -l 50 -p http --sort rate --save /etc/pacman.d/mirrorlist
