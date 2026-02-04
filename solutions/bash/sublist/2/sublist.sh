#!/usr/bin/env bash

main() {
    local A="$1"
    local B="$2"
    
    # Function to normalize input strings to arrays
    normalize() {
        echo "$1" | sed 's/\[//g; s/\]//g; s/,//g; s/  */ /g; s/^ *//; s/ *$//'
    }
    
    # Convert input strings to arrays
    local arrA=()
    local arrB=()
    
    # Read normalized strings into arrays
    IFS=' ' read -r -a arrA <<< "$(normalize "$A")"
    IFS=' ' read -r -a arrB <<< "$(normalize "$B")"
    
    local lenA=${#arrA[@]}
    local lenB=${#arrB[@]}
    
    # Handle edge cases with empty arrays
    if (( lenA == 0 && lenB == 0 )); then
        echo "equal"
        return
    elif (( lenA == 0 )); then
        echo "sublist"
        return
    elif (( lenB == 0 )); then
        echo "superlist"
        return
    fi
    
    # Check for equality (same length and all elements match)
    if (( lenA == lenB )); then
        local equal=true
        for ((i = 0; i < lenA; i++)); do
            if [[ "${arrA[i]}" != "${arrB[i]}" ]]; then
                equal=false
                break
            fi
        done
        if $equal; then
            echo "equal"
            return
        fi
    fi
    
    # Helper function to check if first array is a sublist of second
    is_sublist() {
        local -n small="$1"
        local -n big="$2"
        local len_small=${#small[@]}
        local len_big=${#big[@]}
        
        # If small array is empty, it's always a sublist
        if (( len_small == 0 )); then
            return 0
        fi
        
        # If small array is longer, it can't be a sublist
        if (( len_small > len_big )); then
            return 1
        fi
        
        # Check all possible starting positions
        for ((i = 0; i + len_small <= len_big; i++)); do
            local match=true
            for ((j = 0; j < len_small; j++)); do
                if [[ "${small[j]}" != "${big[i+j]}" ]]; then
                    match=false
                    break
                fi
            done
            if $match; then
                return 0
            fi
        done
        
        return 1
    }
    
    # Check relationships
    if is_sublist arrA arrB; then
        echo "sublist"
    elif is_sublist arrB arrA; then
        echo "superlist"
    else
        echo "unequal"
    fi
}

main "$@"