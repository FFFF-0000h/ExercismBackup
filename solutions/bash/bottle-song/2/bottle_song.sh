#!/usr/bin/env bash

main() {
    local bottle=$1
    local iteration=$2
    local number=(1 2 3 4 5 6 7 8 9 10)
    local word=("One" "Two" "Three" "Four" "Five" "Six" "Seven" "Eight" "Nine" "Ten")
    
    # Input validation
    if [[ $# -ne 2 ]]; then
        echo "Usage: $0 <starting_bottles> <number_of_verses>"
        echo "2 arguments expected"
        exit 1
    fi

    if ! [[ "$bottle" =~ ^[0-9]+$ ]] || ! [[ "$iteration" =~ ^[0-9]+$ ]]; then
        echo "Both arguments must be positive integers"
        exit 1
    fi

    if (( bottle < 1 || bottle > 10 )); then
        echo "Starting bottles must be between 1 and 10"
        exit 1
    fi

    if (( iteration > bottle )); then
        echo "cannot generate more verses than bottles"
        exit 1
    fi

    if (( iteration < 1 )); then
        echo "Number of verses must be at least 1"
        exit 1
    fi

    # Generate verses
    for (( i = 0; i < iteration; i++ )); do
        local current=$((bottle - i))
        local next=$((current - 1))
        
        # Find word for current count
        local current_word=""
        local next_word=""
        
        for (( j = 0; j < 10; j++ )); do
            if [[ $current -eq ${number[$j]} ]]; then
                current_word="${word[$j]}"
            fi
            if [[ $next -eq ${number[$j]} ]]; then
                next_word="${word[$j]}"
            fi
        done
        
        # Handle "no" for 0
        if [[ $next -eq 0 ]]; then
            next_word="no"
        fi
        
        # Handle plurals
        local current_plural="bottles"
        local next_plural="bottles"
        
        if [[ $current -eq 1 ]]; then
            current_plural="bottle"
        fi
        
        if [[ $next -eq 1 ]]; then
            next_plural="bottle"
        fi
        
        # Convert next word to lowercase (except for "no")
        local next_word_lower="${next_word,,}"
        if [[ $next_word == "no" ]]; then
            next_word_lower="no"
        fi
        
        # Print the verse
        printf "%s\n" \
            "$current_word green $current_plural hanging on the wall," \
            "$current_word green $current_plural hanging on the wall," \
            "And if one green bottle should accidentally fall," \
            "There'll be $next_word_lower green $next_plural hanging on the wall."
        
        # Add empty line between verses (except after last)
        if (( i < iteration - 1 )); then
            printf "\n"
        fi
    done
}

main "$@"