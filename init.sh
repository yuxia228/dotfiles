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

git_config () {
    git config --global core.hooksPath ${HOME}/.githooks
    git config --global core.editor vim
    git config --global commit.verbose true
    git config --global pull.ff only
    git config --global alias.tree "log --graph --all \
        --format='%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s'"
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
    if [[ "$i" == ".gitignore" ]] ; then
        continue;
    fi
    ${DRYRUN} ln -sf ${SCRIPT_DIR}/$i ${HOME}/$i
done

if [[ "$DRYRUN" != "" ]]; then echo dotdirs:; fi
DOTDIRS="$(ls -dF .[^.]* | grep /)"
for i in $DOTDIRS; do
    if [[ "$i" == ".git/" ]] || [[ "$i" == ".config/" ]]; then
        continue;
    fi
    ${DRYRUN} ln -sfd ${SCRIPT_DIR}/$i ${HOME}/
done

if [[ "$DRYRUN" != "" ]]; then echo dotconfigs:; fi
DOTCONFIGS="$( ls -dF .config/[^.]* | grep /)"
mkdir -p ${HOME}/.config
for i in $DOTCONFIGS; do
    ${DRYRUN} ln -sfd ${SCRIPT_DIR}/$i ${HOME}/.config/
done

git_config

echo "=> dotfiles are installed."

