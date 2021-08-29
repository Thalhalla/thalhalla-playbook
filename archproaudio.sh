#!/bin/bash

# echo 2048 > /sys/class/rtc/rtc0/max_user_freq
# echo 2048 > /proc/sys/dev/hpet/max-user-freq
echo 2048 |sudo tee /sys/class/rtc/rtc0/max_user_freq
echo 2048 |sudo tee /proc/sys/dev/hpet/max-user-freq

if [[ ! -f /etc/sysctl.d/90-swappiness.conf ]]; then
  echo 'vm.swappiness = 10' |sudo tee /etc/sysctl.d/90-swappiness.conf
fi
if [[ ! -f /etc/sysctl.d/90-max_user_watches.conf ]]; then
  echo 'fs.inotify.max_user_watches = 600000' |sudo tee /etc/sysctl.d/90-max_user_watches.conf
fi
