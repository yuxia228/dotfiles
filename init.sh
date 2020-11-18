#!/bin/bash

DRYRUN=""
SCRIPT_DIR=$(cd `dirname $0`; pwd)
cd ${SCRIPT_DIR}


Usage () {
    echo "Usage:"
    echo "    $0"
    echo "Options:"
    echo "  -h|--help : show this message"
    echo "  -d|--dry-run : Dry-run"
}

if [[ "$(echo $*|grep -e --help -e -h)" != "" ]]; then
    Usage; exit;
fi

if [[ "$(echo $*|grep -e --dry-run -e -d)" != "" ]]; then
    echo "This is dry-run"
    DRYRUN="echo"
fi

if [[ "$DRYRUN" != "" ]]; then echo dotfiles:; fi
DOTFILES="$(ls -dF .[^.]* | grep -v /)"
for i in $DOTFILES; do
    ${DRYRUN} ln -sf ${SCRIPT_DIR}/$i ${HOME}/$i
done

if [[ "$DRYRUN" != "" ]]; then echo dotdirs:; fi
DOTDIRS="$(ls -dF .[^.]* | grep /)"
for i in $DOTDIRS; do
    if [[ "$i" == ".git/" ]] ; then
        continue;
    fi
    ${DRYRUN} ln -sf ${SCRIPT_DIR}/$i ${HOME}/$i
done


