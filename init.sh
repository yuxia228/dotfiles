#!/bin/bash

DRYRUN=""
SCRIPT_DIR=$(cd `dirname $0`; pwd)
cd ${SCRIPT_DIR}
LN_DIR_OPT=${LN_DIR_OPT:-"-sf"}

####################################################
# functions                                        #
####################################################
Usage () {
    echo "Usage:"
    echo "    $0"
    echo "Options:"
    echo "  -h|--help : show this message"
    echo "  -d|--dry-run : Dry-run"
}

git_config () {
    # basic config
    git config --global color.ui true
    git config --global color.diff auto
    git config --global color.status auto
    git config --global color.branch auto
    git config --global core.hooksPath ${HOME}/.githooks
    git config --global core.editor vim
    git config --global commit.verbose true
    git config --global pull.ff only
    git config --global diff.algorithm histogram
    git config --global push.default simple
    # aliases
    git config --global alias.tree "log --graph --all --format='%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s'"
    git config --global alias.squash "merge --squash --ff"
    git config --global alias.difff "diff --word-diff"
    git config --global alias.mkpatch "format-patch --subject-prefix=PATCH -o ./"
    git config --global alias.mkpatches "mkpatch --cover-letter"
    # Global ignore
    GLOBAL_IGNORE=${HOME}/.config/git/ignore
    mkdir -p $( dirname ${GLOBAL_IGNORE} )
    targets=("/.serena" "/.tokensave")
    for target in ${targets[@]}; do
        if [[ "$(grep ${target} ${GLOBAL_IGNORE})" == "" ]]; then
            echo "${target}" >> ${GLOBAL_IGNORE}
        fi
    done
}

####################################################
# main process                                     #
####################################################

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
    ${DRYRUN} ln ${LN_DIR_OPT} ${SCRIPT_DIR}/$i ${HOME}/
done

if [[ "$DRYRUN" != "" ]]; then echo dotconfigs:; fi
DOTCONFIGS="$( ls -dF .config/[^.]* | grep /)"
mkdir -p ${HOME}/.config
for i in $DOTCONFIGS; do
    ${DRYRUN} ln ${LN_DIR_OPT} ${SCRIPT_DIR}/$i ${HOME}/.config/
done

if [[ "$DRYRUN" != "" ]]; then echo claude code setting:; fi
mkdir -p ${HOME}/.claude
mkdir -p ${HOME}/.claude-personal
mkdir -p ${HOME}/.claude-work
CONFIGS="$( ls -dF claude/* | grep -v plugins)"
for i in $CONFIGS; do
    ${DRYRUN} ln -sf ${SCRIPT_DIR}/$i ${HOME}/.claude
    ${DRYRUN} ln -sf ${SCRIPT_DIR}/$i ${HOME}/.claude-personal/
    ${DRYRUN} ln -sf ${SCRIPT_DIR}/$i ${HOME}/.claude-work/
done

${DRYRUN} mkdir -p ${SCRIPT_DIR}/claude/plugins/
git clone https://github.com/InterfaceX-co-jp/genshijin ${SCRIPT_DIR}/claude/plugins/genshijin >/dev/null 2>&1
git -C ${SCRIPT_DIR}/claude/plugins/genshijin pull
for path in "${HOME}/.claude-personal" "${HOME}/.claude-work" "${HOME}/.claude"; do
    # installing skills
    ${DRYRUN} mkdir -p $path/skills
    ${DRYRUN} rm -rf $path/skills/genshijin*
    for skill in $(ls ${SCRIPT_DIR}/claude/plugins/genshijin/skills/); do
        ${DRYRUN} ln -sf ${SCRIPT_DIR}/claude/plugins/genshijin/skills/$skill $path/skills/$skill
    done
    # installing hooks
    CLAUDE_CONFIG_DIR=$path ${DRYRUN} ${SCRIPT_DIR}/claude/plugins/genshijin/hooks/install.sh --force

    # installing hooks for RTK(installed with Headroom)
    if [[ "$path" != "${HOME}/.claude" ]]; then
        ln -sf ${HOME}/.claude/RTK.md $path/RTK.md
        ln -sf ${HOME}/.claude/hooks/rtk-rewrite.sh $path/rtk-rewrite.sh
    fi
done
# Fix settings.sh uses "${HOME}" instead of direct path
sed -i ${SCRIPT_DIR}/claude/settings.json -e "s|${HOME}|\${HOME}|"

git_config

echo "=> dotfiles are installed."

