#
# .zshrc
#

#################################
# include common config file
#################################
source ${HOME}/.commonrc

#################################
# oh-my-zsh install
#################################
export ZSH=${HOME}/.oh-my-zsh
export ZSH_CUSTOM=${ZSH}/custom
if [ ! -d ${ZSH} ];then
    git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh $ZSH
fi
# include activate oh-my-zsh
source ${ZSH}/oh-my-zsh.sh

################################
# oh-my-zsh plugins settings
################################
## Git ##
plugins=(git)
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
## zsh-completions ##
if [ ! -d ${ZSH_CUSTOM}/plugins/zsh-completions ]; then
    git clone --depth 1 https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM}/plugins/zsh-completions
fi
plugins+=(zsh-completions)
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # ignore lower/upper char in serarch
## zsh-syntax-highlighting ##
if [ ! -d ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting ]; then
    git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
fi
plugins+=(zsh-syntax-highlighting)

################################
# Function
################################
git_prompt_tag () {
    TAG=`command git tag --points-at HEAD 2> /dev/null |cat` || return 0
    if [ -n "${TAG}" ]; then
        echo "%{$fg[red]%}[tag: ${TAG}]%{$fg[reset_color]%}"
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
# instead of candy theme
PROMPT_DEFAULT=$'%{$fg_bold[green]%}%n@%m %{$fg[blue]%}%D{[%X]} %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info) $(git_prompt_tag)\
%{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} '
PROMPT_SIMPLE=$'%{$fg_bold[green]%}%n@%m %{$fg[blue]%}[%*] %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info) $(git_prompt_tag)\
%{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} '
set_zsh_prompt ${PROMPT_SIMPLE}

###############################################
# Other settings
###############################################
alias ohmyzsh="mate ~/.oh-my-zsh"

