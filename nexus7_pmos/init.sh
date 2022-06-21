#!/bin/bash

SCRIPT_DIR=$(cd `dirname $0` && pwd)
export LN_DIR_OPT="-sf" # ln of busybox doesn't support -d option

${SCRIPT_DIR}/../init.sh

