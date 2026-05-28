#!/bin/bash

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
    if [ "$PCT" -ge 90 ]; then BAR_COLOR="$RED"
    elif [ "$PCT" -ge 70 ]; then BAR_COLOR="$YELLOW"
    else BAR_COLOR="$GREEN"; fi
    echo -e "${BAR_COLOR}$(print_bar $PCT)${RESET}"
}

input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
CTX_WND=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
MINS=$((DURATION_MS / 60000)); SECS=$(((DURATION_MS % 60000) / 1000))
COST_FMT=$(printf '$%.2f' "$COST")
FIVE_H=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
WEEK=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
[ -n "$FIVE_H" ] && LIMITS_5H="$(printf '%.0f' "$FIVE_H")"
[ -n "$WEEK" ] && LIMITS_1W="$(printf '%.0f' "$WEEK")"

echo -e "\
${CYAN}[$MODEL]${RESET} 📁 ${DIR##*/} $(print_bar_color ${CTX_WND}) ${CTX_WND}% | \
${YELLOW}${COST_FMT}${RESET} | ⏱️  ${MINS}m ${SECS}s | \
5h: $(print_bar_color ${LIMITS_5H}) ${LIMITS_5H}% | 7d: $(print_bar_color ${LIMITS_1W}) ${LIMITS_1W}% \
"

