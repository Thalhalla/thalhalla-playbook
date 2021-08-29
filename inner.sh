#!/bin/bash
if [ -f /usr/local/SSShutdown/lib/util.bash ]; then
. /usr/local/SSShutdown/lib/util.bash
check_hooks
fi
