#!/bin/bash
. lib/loader.bash

TMP_DIR=$(mktemp -d --suffix='.thoth')
cd $TMP_DIR
install_jcx_utils
cd /tmp
rm -Rf $TMP_DIR
