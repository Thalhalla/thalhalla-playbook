#!/bin/bash
TMP_DIR=$(mktemp -d --suffix='.thoth')
cd $TMP_DIR

# VV
curl https://raw.githubusercontent.com/joshuacox/vv/master/bootstrapvv.sh|bash
# Roustabout
curl https://raw.githubusercontent.com/joshuacox/roustabout/master/bootstraproustabout.sh|bash
# bomsaway
curl https://raw.githubusercontent.com/joshuacox/bomsaway/master/bootstrapbomsaway.sh|bash
# Docker
curl https://raw.githubusercontent.com/joshuacox/roustabout/master/DebianInstall|bash

git clone https://github.com/joshuacox/freezing-cyril.git
cd freezing-cyril/src
./freeze
cd $TMP_DIR

cd
sudo gem install bundler
bundle install


rm -Rf $TMP_DIR
