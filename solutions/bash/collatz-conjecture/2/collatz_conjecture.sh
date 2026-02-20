#!/usr/bin/env bash

main () {
  local colcon=$1
  (( colcon <= 0 )) && { echo "Error: Only positive numbers are allowed"; exit 1; }
  local steps=0
  while (( colcon != 1 )); do
    if (( colcon % 2 == 0 )); then 
      colcon=$(( colcon / 2 ))
    else 
      colcon=$(( 3 * colcon + 1 ))
    fi
      steps=$(( steps + 1 ))
  done
  echo "$steps"
}
main "$@"