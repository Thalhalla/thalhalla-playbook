#!/bin/bash
TMP=$(mktemp -d)
for i in $(cat bauerbill_list); do ./bauerbill_installer $i; done

rm -Rf $TMP
