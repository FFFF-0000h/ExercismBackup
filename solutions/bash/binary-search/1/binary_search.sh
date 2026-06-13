#!/usr/bin/env bash

binary_search() {
    local target=$1
    shift                     # remaining arguments are the array elements
    local array=("$@")
    local left=0
    local right=$((${#array[@]} - 1))

    while (( left <= right )); do
        local mid=$(( (left + right) / 2 ))
        if (( array[mid] == target )); then
            echo "$mid"
            return
        elif (( array[mid] < target )); then
            left=$((mid + 1))
        else
            right=$((mid - 1))
        fi
    done
    echo "-1"
}

binary_search "$@"