#!/usr/bin/env bash

main() {
    local rna="$1"
    local -a proteins=()
    local codon
    local i

    for (( i=0; i<${#rna}; i+=3 )); do
        codon="${rna:i:3}"
        
        # Incomplete codon (less than 3 characters)
        if (( ${#codon} < 3 )); then
            echo "Invalid codon" >&2
            exit 1
        fi

        case "$codon" in
            AUG)               proteins+=("Methionine") ;;
            UUU|UUC)           proteins+=("Phenylalanine") ;;
            UUA|UUG)           proteins+=("Leucine") ;;
            UCU|UCC|UCA|UCG)   proteins+=("Serine") ;;
            UAU|UAC)           proteins+=("Tyrosine") ;;
            UGU|UGC)           proteins+=("Cysteine") ;;
            UGG)               proteins+=("Tryptophan") ;;
            UAA|UAG|UGA)       break ;;
            *)                 echo "Invalid codon" >&2; exit 1 ;;
        esac
    done

    echo "${proteins[*]}"
}

main "$@"