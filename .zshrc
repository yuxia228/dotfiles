#
# .zshrc
#

#################################
# include common config file
#################################
source ${HOME}/.commonrc

#################################
# oh-my-zsh install/include
#################################
export ZSH=$HOME/.oh-my-zsh
if [ ! -d $ZSH ];then
    git clone https://github.com/ohmyzsh/ohmyzsh $ZSH
fi
source $ZSH/oh-my-zsh.sh

################################
# oh-my-zsh plugins
################################
## Git ##
plugins=(git)
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
## completions ##
plugins=(... zsh-completions)
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # ignore lower/upper char in serarch

################################
# Function
################################
git_prompt_tag () {
    TAG=`command git tag --points-at HEAD 2> /dev/null |cat` || return 0
    if [ -n "$TAG" ]; then
        echo "%{$fg[red]%}[tag: ${TAG}]%{$fg[reset_color]%}"
    fi
}

###############################################
# Prompt settings
###############################################
# instead of candy theme
PROMPT=$'%{$fg_bold[green]%}%n@%m %{$fg[blue]%}%D{[%X]} %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info) $(git_prompt_tag) \
%{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} '


###############################################
# Other settings
###############################################
alias ohmyzsh="mate ~/.oh-my-zsh"

