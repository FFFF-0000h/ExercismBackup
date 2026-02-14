#!/usr/bin/env bash

main() {
    # Get the message from arguments or stdin
    local message
    if [[ $# -eq 0 ]]; then
        read -r message
    else
        message="$*"
    fi
    
    # Remove leading/trailing whitespace
    message="${message#"${message%%[![:space:]]*}"}"
    message="${message%"${message##*[![:space:]]}"}"
    
    # Check for silence (empty after trimming)
    if [[ -z "$message" ]]; then
        echo "Fine. Be that way!"
        return 0
    fi
    
    # Check if it's a question (ends with ?)
    local is_question=false
    [[ "$message" == *"?" ]] && is_question=true
    
    # Check if it's yelling (has letters and all are uppercase)
    local has_letters=false
    local is_yelling=false
    
    # Extract only letters
    local letters="${message//[^[:alpha:]]/}"
    
    if [[ -n "$letters" ]]; then
        has_letters=true
        # Check if all letters are uppercase
        [[ "$letters" == "${letters^^}" ]] && is_yelling=true
    fi
    
    # Determine response
    if $is_yelling && $is_question; then
        echo "Calm down, I know what I'm doing!"
    elif $is_yelling; then
        echo "Whoa, chill out!"
    elif $is_question; then
        echo "Sure."
    else
        echo "Whatever."
    fi
}

main "$@"