#!/bin/sh
sudo apt-get update
sudo apt-get install -y build-essential libssl-dev libffi-dev python2.7 python-virtualenv python2.7-dev
sudo apt-get install -y python python-pip curl wget git python-dev ruby-dev build-essential
sudo pip install docker-py pyyaml jinja2 paramiko
