#!/bin/bash

cur=$(ls emoji_*.json | sort | tail -n1)
prev=$(ls emoji_*.json | sort | tail -n2 | head -n1)

keys() {
    jq -r '.emoji | keys | join("\n")' $1 | sed 's/.*/:&:/' | sort
}

printf "\e[41mCHANGED\e[m\n"
comm -23 <(keys $prev) <(keys $cur) | tr -d '\n' | sed 's/\(:[^:]*:\)\{1,23\}/&\n/g'
echo

printf "\e[42mADDED\e[m\n"
comm -13 <(keys $prev) <(keys $cur) | tr -d '\n' | sed 's/\(:[^:]*:\)\{1,23\}/&\n/g'
echo
