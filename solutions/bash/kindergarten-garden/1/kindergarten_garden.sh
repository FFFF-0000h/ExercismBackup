#!/usr/bin/env bash

students=(
    "Alice" "Bob" "Charlie" "David" "Eve" "Fred" "Ginny"
    "Harriet" "Ileana" "Joseph" "Kincaid" "Larry"
)

declare -A plants=(
    ["G"]="grass"
    ["C"]="clover"
    ["R"]="radishes"
    ["V"]="violets"
)

main() {
    local diagram="$1"
    local student="$2"

    # Find student index
    local index=-1
    for i in "${!students[@]}"; do
        if [[ "${students[$i]}" == "$student" ]]; then
            index=$i
            break
        fi
    done

    if [[ $index -eq -1 ]]; then
        echo "Unknown student: $student" >&2
        exit 1
    fi

    local start=$((index * 2))

    # Split diagram into two rows
    local row1="${diagram%%$'\n'*}"
    local row2="${diagram#*$'\n'}"

    local p1="${row1:$start:1}"
    local p2="${row1:$((start + 1)):1}"
    local p3="${row2:$start:1}"
    local p4="${row2:$((start + 1)):1}"

    echo "${plants[$p1]} ${plants[$p2]} ${plants[$p3]} ${plants[$p4]}"
}

main "$@"