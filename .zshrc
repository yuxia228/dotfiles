#
# .zshrc
#

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

source .commonrc

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

plugins=(git)

source $ZSH/oh-my-zsh.sh

git_prompt_tag () {
    TAG=`command git tag --points-at HEAD 2> /dev/null |cat` || return 0
    if [ -n "$TAG" ]; then
        echo "%{$fg[red]%}[tag: ${TAG}]%{$fg[reset_color]%}"
    fi
}

# instead of candy theme
PROMPT=$'%{$fg_bold[green]%}%n@%m %{$fg[blue]%}%D{[%X]} %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info) \
%{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} '

PROMPT=$'%{$fg_bold[green]%}%n@%m %{$fg[blue]%}%D{[%X]} %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info) $(git_prompt_tag) \
%{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

alias ohmyzsh="mate ~/.oh-my-zsh"
plugins=(... zsh-completions)
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

