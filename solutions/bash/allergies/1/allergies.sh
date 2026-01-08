#!/usr/bin/env bash

# Allergy values (powers of 2)
declare -A ALLERGIES=(
    [1]="eggs"
    [2]="peanuts"
    [4]="shellfish"
    [8]="strawberries"
    [16]="tomatoes"
    [32]="chocolate"
    [64]="pollen"
    [128]="cats"
)

# Function to check if allergic to a specific allergen
allergic_to() {
    local score="$1"
    local allergen="$2"
    
    # Check if allergen exists in our map
    for value in "${!ALLERGIES[@]}"; do
        if [[ "${ALLERGIES[$value]}" == "$allergen" ]]; then
            # Use bitwise AND to check if the bit is set
            if (( (score & value) != 0 )); then
                echo "true"
                return 0
            else
                echo "false"
                return 0
            fi
        fi
    done
    
    # Allergen not found in our list
    echo "false"
}

# Function to list all allergies from a score
list() {
    local score="$1"
    local allergies=()
    
    # Sort the keys (allergy values) numerically
    sorted_keys=$(for key in "${!ALLERGIES[@]}"; do echo "$key"; done | sort -n)
    
    # Check each allergy value (in order from smallest to largest)
    for value in $sorted_keys; do
        # Use bitwise AND to check if the bit is set
        if (( (score & value) != 0 )); then
            allergies+=("${ALLERGIES[$value]}")
        fi
    done
    
    # Output as space-separated list (as per test expectations)
    if [[ ${#allergies[@]} -gt 0 ]]; then
        echo "${allergies[*]}"
    fi
    # If no allergies, output nothing (empty line)
}

# Main - handle the format: ./script.sh <score> <command> [<allergen>]
case $# in
    1)
        # Just a score - invalid, need command
        echo "Error: missing command" >&2
        exit 1
        ;;
    2)
        # Format: ./script.sh <score> <command>
        score="$1"
        command="$2"
        
        if ! [[ "$score" =~ ^[0-9]+$ ]]; then
            echo "Error: Score must be a positive integer" >&2
            exit 1
        fi
        
        if [[ "$command" == "list" ]]; then
            list "$score"
        else
            echo "Error: Invalid command '$command'. Use 'list' or 'allergic_to'" >&2
            exit 1
        fi
        ;;
    3)
        # Format: ./script.sh <score> <command> <allergen>
        score="$1"
        command="$2"
        allergen="$3"
        
        if ! [[ "$score" =~ ^[0-9]+$ ]]; then
            echo "Error: Score must be a positive integer" >&2
            exit 1
        fi
        
        if [[ "$command" == "allergic_to" ]]; then
            allergic_to "$score" "$allergen"
        else
            echo "Error: Invalid command '$command'. Use 'allergic_to' with allergen" >&2
            exit 1
        fi
        ;;
    *)
        echo "Usage:" >&2
        echo "  $0 <score> list" >&2
        echo "  $0 <score> allergic_to <allergen>" >&2
        exit 1
        ;;
esac