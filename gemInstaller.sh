#!/bin/bash
TMP_DIR=$(mktemp -d --suffix='.thoth')
cd $TMP_DIR
wget https://raw.githubusercontent.com/Thalhalla/thalhalla-playbook/master/Gemfile
gem install bundler
bundle
rm -Rf $TMP_DIR
