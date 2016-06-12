#!/bin/bash
# apt-get -qq update
apt-get update
apt-get install -y sudo netselect-apt aptitude
netselect-apt -ns -t 25 -o /etc/apt/sources.list testing
apt-get update
