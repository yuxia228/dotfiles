#
# .zshrc
#
#################################
# misc config
#################################
LOW_SPEC_DEVICES="raspberrypizero|kobo"

#################################
# zprof
#################################
if [[ "${ZPROF}" == "True" ]]; then
    zmodload zsh/zprof && zprof
    unset ZPROF
fi

#################################
# include common config file
#################################
source ${HOME}/.commonrc

#################################
# zinit
#################################
ZINIT_HOME="${HOME}/.zinit"
if [[ ! -d ${ZINIT_HOME} ]]; then
    git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

###########
# plugin
###########
zinit load zsh-users/zsh-completions
zinit load zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-syntax-highlighting
# avoid heavy plugins for low-spec devices
if [[ "$(uname -a | grep -E ${LOW_SPEC_DEVICES})" == "" ]]; then
    zinit load zdharma-continuum/fast-syntax-highlighting
    {
        zinit load zsh-users/zsh-history-substring-search
        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down
        bindkey "$terminfo[kcuu1]" history-substring-search-up
        bindkey "$terminfo[kcud1]" history-substring-search-down
    }
    {
        export NVM_LAZY_LOAD=true
        zinit load lukechilds/zsh-nvm
    }
fi
################################
# Function
################################
git_prompt_tag () {
    TAG=`command git tag --points-at HEAD 2> /dev/null |cat` || return 0
    if [ -n "${TAG}" ]; then
        echo "%{$fg[red]%}[tag: ${TAG}]%{$fg[reset_color]%}"
    fi
}
git_prompt_status() {
    GIT_STATUS=$(git status 2>/dev/null)
    if [[ "${GIT_STATUS}" != "" ]];then
        STATUS="%{$fg[green]%}["
        BRANCH=$(echo -e "$GIT_STATUS"| head -1 | awk '{print $NF}')
        STATUS+=${BRANCH}
        UPDATE=$(echo -e "$GIT_STATUS"| grep 'nothing to commit')
        if [[ "${UPDATE}" == "" ]];then
            STATUS+="%{$fg[red]%} *"
        fi
        STATUS+="%{$fg[green]%}]%{$fg[reset_color]%} "
        echo "$STATUS"
    fi
}

set_zsh_prompt () {
    if [ $# -eq 1 ]; then
        PROMPT="${1}"
    else
        echo "ex.) ${0} \$PROMPT_DEFAULT"
    fi
}

###############################################
# Prompt settings
###############################################
## autoload ##
autoload -Uz colors; colors
autoload -Uz compinit: compinit
## zstyle
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # ignore lower/upper char in serarch
zstyle ':completion:*' list-colors "${LS_COLORS}"
## setopt ##
setopt prompt_subst
## PROMPT ##
PROMPT_DEFAULT=\
$'%{$fg_bold[green]%}%n@%m %{$fg[blue]%}%D{[%X]} %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info) $(git_prompt_status) $(git_prompt_tag)
%{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} '
PROMPT_SIMPLE=\
$'%{${fg_bold[green]}%}%n@%m %{${fg[blue]}%}[%*] %{${reset_color}%}%{${fg[white]}%}[%~]%{${reset_color}%} $(git_prompt_status) $(git_prompt_tag)
%{${fg[blue]}%}->%{${fg_bold[blue]}%} %#%{${reset_color}%} '
PROMPT_SIMPLE_NO_GIT=\
$'%{${fg_bold[green]}%}%n@%m %{${fg[blue]}%}[%*] %{${reset_color}%}%{${fg[white]}%}[%~]%{${reset_color}%}
%{${fg[blue]}%}->%{${fg_bold[blue]}%} %#%{${reset_color}%} '
# avoid heavy prompt for low-spec devices
if [[ "$(uname -a | grep -E ${LOW_SPEC_DEVICES})" == "" ]]; then
    set_zsh_prompt ${PROMPT_SIMPLE}
else
    set_zsh_prompt ${PROMPT_SIMPLE_NO_GIT}
fi

###############################################
# Other settings
###############################################
## history settings ##
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt append_history
setopt share_history
setopt hist_ignore_all_dups

#################################
# Other config
#################################
# pyenv
PYENV_ROOT="$HOME/.local_pyenv"
if [ ! -e ${PYENV_ROOT} ]; then
    git clone https://github.com/yyuu/pyenv.git ${PYENV_ROOT}
    git clone https://github.com/yyuu/pyenv-virtualenv.git ${PYENV_ROOT}/plugins/pyenv-virtualenv
fi
if [ -e ${PYENV_ROOT} ]; then
    export PYENV_ROOT="$HOME/.local_pyenv"
    export PATH="${PYENV_ROOT}/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# rbenv
RBENV_ROOT="$HOME/.rbenv"
if [ ! -e ${RBENV_ROOT} ]; then
    git clone --depth 1 https://github.com/rbenv/rbenv.git ${RBENV_ROOT}
    cd ${RBENV_ROOT} && src/configure && make -C src
    git clone --depth 1 https://github.com/rbenv/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build
fi
if [ -e ${RBENV_ROOT} ]; then
    export PATH="${RBENV_ROOT}/bin:$PATH"
    autoload -Uz compinit && compinit
    autoload -U +X bashcompinit && bashcompinit
    eval "$(rbenv init - bash)"
fi

#################################
# zprof
#################################
if (which zprof > /dev/null 2>&1) ;then
    zprof
fi

