#!/usr/bin/env bash

# Translate a word to Pig Latin
translate_word() {
    local word="$1"
    
    # Rule 1: starts with vowel, "xr", or "yt"
    if [[ "${word:0:1}" =~ [aeiou] ]] || 
       [[ "${word:0:2}" == "xr" ]] || 
       [[ "${word:0:2}" == "yt" ]]; then
        echo "${word}ay"
        return
    fi
    
    # Rule 3: starts with zero or more consonants + "qu"
    if [[ "$word" =~ ^([^aeiou]*qu)(.*) ]]; then
        local before_qu="${BASH_REMATCH[1]}"
        local after_qu="${BASH_REMATCH[2]}"
        echo "${after_qu}${before_qu}ay"
        return
    fi
    
    # Rule 4: starts with consonants + "y"
    if [[ "$word" =~ ^([^aeiou]+)(y.*) ]]; then
        local consonants="${BASH_REMATCH[1]}"
        local rest="${BASH_REMATCH[2]}"
        echo "${rest}${consonants}ay"
        return
    fi
    
    # Rule 2: starts with one or more consonants
    if [[ "$word" =~ ^([^aeiou]+)(.*) ]]; then
        local consonants="${BASH_REMATCH[1]}"
        local rest="${BASH_REMATCH[2]}"
        echo "${rest}${consonants}ay"
        return
    fi
    
    # Fallback (shouldn't reach here for valid input)
    echo "${word}ay"
}

# Main function to process the entire phrase
main() {
    local phrase="$*"
    local result=""
    local word
    
    # Disable glob expansion for the input processing
    set -f
    
    # Process each word in the phrase
    for word in $phrase; do
        if [[ -n "$result" ]]; then
            result+=" "
        fi
        result+=$(translate_word "$word")
    done
    
    # Re-enable glob expansion
    set +f
    
    echo "$result"
}

# Call main with all positional arguments
main "$@"