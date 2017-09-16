#!/bin/sh
sudo apt-get update
sudo apt-get install -y python python-pip curl wget git python-dev ruby-dev build-essential aptitude
sudo -H pip install docker pyyaml jinja2 paramiko
