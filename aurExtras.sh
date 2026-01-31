#!/bin/bash
TMP=$(mktemp -d)
for i in $(cat aur_list); do ./aur_installer $i; done

rm -Rf ${TMP}
