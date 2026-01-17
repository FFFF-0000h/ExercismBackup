#!/usr/bin/env bash

main() {
    local verses=(
        "house that Jack built."
        "malt"
        "rat"
        "cat"
        "dog"
        "cow with the crumpled horn"
        "maiden all forlorn"
        "man all tattered and torn"
        "priest all shaven and shorn"
        "rooster that crowed in the morn"
        "farmer sowing his corn"
        "horse and the hound and the horn"
    )
    
    local actions=(
        "lay in"
        "ate"
        "killed"
        "worried"
        "tossed"
        "milked"
        "kissed"
        "married"
        "woke"
        "kept"
        "belonged to"
    )
    
    # Validate input: exactly 2 arguments, both integers between 1-12
    if [[ $# -ne 2 ]]; then
        echo "invalid arguments" >&2
        exit 1
    fi
    
    local start=$1
    local end=$2
    
    # Validate range
    if [[ ! $start =~ ^[0-9]+$ ]] || [[ ! $end =~ ^[0-9]+$ ]] || \
       [[ $start -lt 1 ]] || [[ $start -gt 12 ]] || \
       [[ $end -lt 1 ]] || [[ $end -gt 12 ]] || \
       [[ $start -gt $end ]]; then
        echo "invalid arguments" >&2
        exit 1
    fi
    
    # Generate requested verses
    for (( i = start - 1; i < end; i++ )); do
        echo "This is the ${verses[i]}"
        
        # Add recursive "that" clauses for previous verses
        for (( j = i - 1; j >= 0; j-- )); do
            echo "that ${actions[j]} the ${verses[j]}"
        done
        
        # Add blank line between verses (but not after the last one)
        if [[ $i -lt $((end - 1)) ]]; then
            echo ""
        fi
    done
}

main "$@"