#
# .bashrc
#

source .commonrc

# Color List
ESC=`printf "\033"`
BLACK="${ESC}[30m"
RED="${ESC}[31m"
GREEN="${ESC}[32m"
YELLOW="${ESC}[33m"
BLUE="${ESC}[34m"
MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m"
WHITE="${ESC}[37m"
RESET="${ESC}[m"

if [ "$color_prompt" = yes ]; then
    PS1='${GREEN}\u@\h ${BLUE}[$(date +"%H:%M:%S")]${RESET} ${MAGENTA}[\w]${RESET}\nbash \$ '
else
    PS1='\u@\h [$(date +"%H:%M:%S")] [\w]\nbash \$ '
fi
unset color_prompt force_color_prompt


