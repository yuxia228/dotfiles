#!/bin/bash

SCRIPT_DIR=$(cd `dirname $0` && pwd)
AUTO_COMPACT_SIZE=$(cat ${SCRIPT_DIR}/settings.json| jq '.env["CLAUDE_CODE_AUTO_COMPACT_WINDOW"]' | bc | xargs -i echo "{}/1000" | bc)

CYAN='\033[36m'; GREEN='\033[32m'; YELLOW='\033[33m'; RED='\033[31m'; RESET='\033[0m'
print_bar () {
    PCT=$1
    FILLED=$((PCT / 10)); EMPTY=$((10 - FILLED))
    printf -v FILL "%${FILLED}s"; printf -v PAD "%${EMPTY}s"
    BAR="${FILL// /█}${PAD// /░}"
    echo -e "${BAR}"
}
print_bar_color () {
    PCT=$1
    if [ "$PCT" -ge 80 ]; then BAR_COLOR="$RED"
    elif [ "$PCT" -ge 50 ]; then BAR_COLOR="$YELLOW"
    else BAR_COLOR="$GREEN"; fi
    echo -e "${BAR_COLOR}$(print_bar $PCT)${RESET}"
}

input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
CTX_WND_USED=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
MINS=$((DURATION_MS / 60000)); SECS=$(((DURATION_MS % 60000) / 1000))
COST_FMT=$(printf '$%.2f' "$COST")
LIMITS_5H=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // 0' | cut -d. -f1)
LIMITS_1W=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // 0' | cut -d. -f1)
CTX_WND=$(( $CTX_WND_USED * 1000 / $AUTO_COMPACT_SIZE ))

GENSHIJIN=""
if [[ -e "${CLAUDE_CONFIG_DIR}/hooks/genshijin-statusline.sh" ]]; then
    GENSHIJIN=$( ${CLAUDE_CONFIG_DIR}/hooks/genshijin-statusline.sh )
fi

echo -e "\
${CYAN}[$MODEL]${RESET} ${GENSHIJIN} 📁 ${DIR##*/} | ${YELLOW}${COST_FMT}${RESET} | ⏱️  ${MINS}m ${SECS}s \
"
echo -e "\
ctx: $(print_bar_color ${CTX_WND}) ${CTX_WND}% | 5h: $(print_bar_color ${LIMITS_5H}) ${LIMITS_5H}% | 7d: $(print_bar_color ${LIMITS_1W}) ${LIMITS_1W}% \
"

echo ${input} > ${CLAUDE_CONFIG_DIR}/claude-status.json

