#
# .zshrc
#

#################################
# include common config file
#################################
source ${HOME}/.commonrc

################################
# Function
################################
git_prompt_tag () {
    TAG=`command git tag --points-at HEAD 2> /dev/null |cat` || return 0
    if [ -n "${TAG}" ]; then
        echo "%{$fg[red]%}[tag: ${TAG}]%{$fg[reset_color]%}"
    fi
}
git_prompt_info () {
    BRANCH=`command git branch | grep '*' | awk '{print $2}'`
    if [ $(git status --short | wc -l) -ne 0 ]; then
        UPDATE="%{$fg[red]%} *"
    fi
    echo "%{$fg[green]%}[${BRANCH}${UPDATE}%{$fg[green]%}]%{$fg[reset_color]%}"
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
PROMPT_DEFAULT=$'
%{$fg_bold[green]%}%n@%m %{$fg[blue]%}%D{[%X]} %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info) $(git_prompt_tag)
%{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} '
PROMPT_SIMPLE=$'
%{${fg_bold[green]}%}%n@%m %{${fg[blue]}%}[%*] %{${reset_color}%}%{${fg[white]}%}[%~]%{${reset_color}%} $(git_prompt_info) $(git_prompt_tag)
%{${fg[blue]}%}->%{${fg_bold[blue]}%} %#%{${reset_color}%} '
set_zsh_prompt ${PROMPT_SIMPLE}

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


