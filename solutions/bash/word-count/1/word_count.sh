#!/usr/bin/env bash

# Count occurrences of each word in the input string (case-insensitive)
# Words consist of letters, digits, and apostrophes.
# All other characters are treated as separators.
declare -A counts

# Replace every character that is not a letter, digit, or apostrophe with a space
cleaned=$(echo "$1" | sed "s/[^a-zA-Z0-9']/ /g")

# Loop over each whitespace-separated token
for token in $cleaned; do
    # Strip leading/trailing apostrophes (quotes that may have been left)
    token="${token#\'}"
    token="${token%\'}"
    # Skip empty tokens
    [[ -z "$token" ]] && continue
    # Lowercase
    word=$(echo "$token" | tr '[:upper:]' '[:lower:]')
    ((counts["$word"]++))
done

# Output each unique word and its count, sorted alphabetically
for word in $(printf '%s\n' "${!counts[@]}" | sort); do
    echo "$word: ${counts[$word]}"
done