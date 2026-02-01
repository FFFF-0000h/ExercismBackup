#!/usr/bin/env bash


function log_output {
  local log=""
  for el in "${output[@]}"; do
    if [[ $toRev == true ]]; then
      (("${#log}" == 0)) && log="${el}${log}" || log="${el},${log}"
    else
      (("${#log}" == 0)) && log="${log}${el}" || log="${log},${el}"
    fi
  done
  echo "$log"
}

input=$1
if [[ -z $input ]] && ((input < 1 || input > 31)); then 
  echo "problem"
  exit 1
fi

binary_num=$(echo "obase=2; ${input}" | bc)
actions=("rev" "jump" "close your eyes" "double blink" "wink")
output=()
toRev=false
for ((i=${#binary_num}-1; i>=0; i--)); do
  subnum=${binary_num:i:1}
  action_num=$((5 - ${#binary_num} + i))
  if [[ $subnum == "1" && "${actions[action_num]}" != "rev" ]]; then
    output+=("${actions[action_num]}")
  elif [[ $subnum == "1" && "${actions[action_num]}" == "rev" ]]; then
    toRev=true
  fi
done

log_output