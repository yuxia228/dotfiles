#!/bin/bash

# Enable aliases in shell script
shopt -s expand_aliases
source ~/.bashrc

cc-personal --model haiku --effort low -p "おはよう！今日も一日頑張りましょう" && echo "Reset claude code"

