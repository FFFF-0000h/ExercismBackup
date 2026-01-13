#!/usr/bin/env bash

main () {
    # Check that exactly 2 arguments are provided
    if [ $# -ne 2 ]; then
        echo "Usage: hamming.sh <string1> <string2>"
        exit 1
    fi
    
    local str1="$1"
    local str2="$2"
    local len1=${#str1}
    local len2=${#str2}
    
    # Check if strings are of equal length
    if [ $len1 -ne $len2 ]; then
        echo "strands must be of equal length"
        exit 1
    fi
    
    # Calculate Hamming distance
    local distance=0
    for (( i=0; i<$len1; i++ )); do
        local char1="${str1:$i:1}"
        local char2="${str2:$i:1}"
        
        if [ "$char1" != "$char2" ]; then
            ((distance++))
        fi
    done
    
    echo "$distance"
}

main "$@"