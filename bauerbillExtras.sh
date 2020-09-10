#!/bin/bash
TMP=$(mktemp -d)
#yaourt -S \
#    glipper \
#    dissenter-browser
#    byobu \
#    autokey-py3 \
#    cmst \
for i in $(cat bauerbill_list); do ./bauerbill_installer $i; done

rm -Rf $TMP
