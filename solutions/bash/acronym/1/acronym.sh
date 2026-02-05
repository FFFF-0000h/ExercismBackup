#!/usr/bin/env bash

main() {
    # Get the input phrase from command line arguments
    local input="$*"
    
    # If no input provided, exit
    if [[ -z "$input" ]]; then
        echo ""
        return 0
    fi
    
    # Replace hyphens with spaces (treat hyphens as word separators)
    input="${input//-/ }"
    
    # Remove all punctuation except apostrophes in words (like "It's")
    # We'll keep apostrophes for now, then extract first letters
    input=$(echo "$input" | tr -d '[:punct:]' | sed "s/'//g")
    
    # Convert to uppercase and split into words
    local acronym=""
    
    # Read each word
    read -ra words <<< "$input"
    
    for word in "${words[@]}"; do
        # Skip empty words (could result from multiple spaces)
        if [[ -n "$word" ]]; then
            # Take first character and convert to uppercase
            first_char="${word:0:1}"
            acronym+="${first_char^^}"
        fi
    done
    
    echo "$acronym"
}

main "$@"