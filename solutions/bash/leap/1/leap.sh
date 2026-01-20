#!/usr/bin/env bash

main() {
    # Check if exactly one argument is provided
    if [[ $# -ne 1 ]]; then
        echo "Usage: leap.sh <year>"
        exit 1
    fi
    
    # Store the year
    year="$1"
    
    # Validate input is a positive integer
    if [[ ! "$year" =~ ^[0-9]+$ ]]; then
        echo "Usage: leap.sh <year>"
        exit 1
    fi
    
    # Leap year calculation
    if (( year % 400 == 0 )); then
        echo "true"
        exit 0
    elif (( year % 100 == 0 )); then
        echo "false"
        exit 0  # Changed from exit 1 to exit 0
    elif (( year % 4 == 0 )); then
        echo "true"
        exit 0
    else
        echo "false"
        exit 0  # Changed from exit 1 to exit 0
    fi
}

main "$@"