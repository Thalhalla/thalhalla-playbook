#!/bin/bash
TMP_DIR=$(mktemp -d --suffix='.smxi')
cd $TMP_DIR

wget -Nc smxi.org/smxi.zip
unzip smxi.zip
rm smxi.zip
mv * /usr/local/bin/

cd /tmp
rm -Rf $TMP_DIR
