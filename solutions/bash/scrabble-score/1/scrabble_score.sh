#!/usr/bin/env bash

main() {
    local word="$1"
    local score=0
    
    # Convert to uppercase for consistent matching
    word=${word^^}
    
    # Process each character
    for (( i=0; i<${#word}; i++ )); do
        local char="${word:$i:1}"
        
        case "$char" in
            A|E|I|O|U|L|N|R|S|T)
                ((score += 1))
                ;;
            D|G)
                ((score += 2))
                ;;
            B|C|M|P)
                ((score += 3))
                ;;
            F|H|V|W|Y)
                ((score += 4))
                ;;
            K)
                ((score += 5))
                ;;
            J|X)
                ((score += 8))
                ;;
            Q|Z)
                ((score += 10))
                ;;
            # Ignore non-letter characters (or you could handle them as 0)
            *)
                # Non-letter characters contribute 0 points
                ;;
        esac
    done
    
    echo "$score"
}

main "$@"