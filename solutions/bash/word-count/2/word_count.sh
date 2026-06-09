#!/usr/bin/env bash

# Count occurrences of each word in the input string (case-insensitive)
declare -A counts

# Lowercase the whole input and replace non-word characters with spaces
cleaned=$(tr '[:upper:]' '[:lower:]' <<<"$1" | tr -c "a-z0-9'" ' ')

# Disable pathname expansion to safely handle * and ?
set -o noglob

# Process each space-separated token
for token in $cleaned; do
    # Remove leading and trailing apostrophes (e.g., 'word' -> word)
    token="${token#\'}"
    token="${token%\'}"
    # Skip empty tokens (possible after stripping)
    [[ -z "$token" ]] && continue
    ((counts["$token"]++))
done

set +o noglob

# Output results, sorted alphabetically
for word in $(printf '%s\n' "${!counts[@]}" | sort); do
    echo "$word: ${counts[$word]}"
done