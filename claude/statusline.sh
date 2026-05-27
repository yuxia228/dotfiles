#!/bin/bash

input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')

CYAN='\033[36m'; GREEN='\033[32m'; YELLOW='\033[33m'; RED='\033[31m'; RESET='\033[0m'

# Pick bar color based on context usage
if [ "$PCT" -ge 90 ]; then BAR_COLOR="$RED"
elif [ "$PCT" -ge 70 ]; then BAR_COLOR="$YELLOW"
else BAR_COLOR="$GREEN"; fi

FILLED=$((PCT / 10)); EMPTY=$((10 - FILLED))
printf -v FILL "%${FILLED}s"; printf -v PAD "%${EMPTY}s"
BAR="${FILL// /█}${PAD// /░}"

MINS=$((DURATION_MS / 60000)); SECS=$(((DURATION_MS % 60000) / 1000))

COST_FMT=$(printf '$%.2f' "$COST")

FIVE_H=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
WEEK=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

LIMITS=""
[ -n "$FIVE_H" ] && LIMITS_5H="5h: $(printf '%.0f' "$FIVE_H")%"
[ -n "$WEEK" ] && LIMITS_1W="7d: $(printf '%.0f' "$WEEK")%"

FILLED=$((FIVE_H / 10)); EMPTY=$((10 - FILLED))
printf -v FILL "%${FILLED}s"; printf -v PAD "%${EMPTY}s"
LIMIT_5H_BAR="${FILL// /█}${PAD// /░}"
FILLED=$((WEEK / 10)); EMPTY=$((10 - FILLED))
printf -v FILL "%${FILLED}s"; printf -v PAD "%${EMPTY}s"
LIMIT_1W_BAR="${FILL// /█}${PAD// /░}"

echo -e "\
${CYAN}[$MODEL]${RESET} 📁 ${DIR##*/} ${BAR_COLOR}${BAR}${RESET} ${PCT}% | \
${YELLOW}${COST_FMT}${RESET} | ⏱️ ${MINS}m ${SECS}s | \
${LIMIT_5H_BAR} ${LIMITS_5H} | ${LIMIT_1W_BAR} ${LIMITS_1W} | \
"

