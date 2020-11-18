export PATH=$PATH:${HOME}/bin

# Color List
BLACK="${ESC}[30m"
RED="${ESC}[31m"
GREEN="${ESC}[32m"
YELLOW="${ESC}[33m"
BLUE="${ESC}[34m"
MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m"
WHITE="${ESC}[37m"
RESET="${ESC}[m"

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    PS1='${GREEN}\u@\h ${BLUE}[$(date +"%H:%M:%S")]${RESET} ${MAGENTA}[\w]${RESET}\nbash \$ '
else
    PS1='\u@\h [$(date +"%H:%M:%S")] [\w]\nbash \$ '
fi
unset color_prompt force_color_prompt

# if path is existed, add it to PATH.
if [ -e /home/linuxbrew/.linuxbrew/bin ]; then
    export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin:
fi

alias ls="ls --auto-color"

# Functions
csv_viewer () {
    column -s, -t < $1 | less -#2 -N -S
}

peco-cd () {
    local sw="1"
    while [ "$sw" != "0" ]
    do
        if [ "$sw" = "1" ];then
            local list=$(echo -e "---$PWD\n../\n$( ls -F | grep / )\n---Show hidden directory\n---Show files, $(echo $(ls -F | grep -v / ))\n---HOME DIRECTORY")
        elif [ "$sw" = "2" ];then
            local list=$(echo -e "---$PWD\n$( ls -a -F | grep / | sed 1d )\n---Hide hidden directory\n---Show files, $(echo $(ls -F | grep -v / ))\n---HOME DIRECTORY")
        else
            local list=$(echo -e "---BACK\n$( ls -F | grep -v / )")
        fi

        local slct=$(echo -e "$list" | peco )
        if [ "$slct" = "---$PWD" ];then
            local sw="0"
        elif [ "$slct" = "---Hide hidden directory" ];then
            local sw="1"
        elif [ "$slct" = "---Show hidden directory" ];then
            local sw="2"
        elif [ "$slct" = "---Show files, $(echo $(ls -F | grep -v / ))" ];then
            local sw=$(($sw+2))
        elif [ "$slct" = "---HOME DIRECTORY" ];then
            cd "$HOME"
        elif [[ "$slct" =~ / ]];then
            cd "$slct"
        elif [ "$slct" = "" ];then
            :
        else
            local sw=$(($sw-2))
        fi
    done
}


source ${HOME}/.aliases
source ${HOME}/.variables

