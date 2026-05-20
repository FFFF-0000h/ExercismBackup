#!/usr/bin/env bash

usage() {
    echo "Usage: $0 -w <row>,<col> -b <row>,<col>" >&2
    exit 1
}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -w) shift; white="$1" ;;
        -b) shift; black="$1" ;;
        *) usage ;;
    esac
    shift
done

# Validate that both positions were provided
[[ -z "$white" || -z "$black" ]] && usage

# Split position into row and column
IFS=',' read -r w_row w_col <<< "$white"
IFS=',' read -r b_row b_col <<< "$black"

# Check that row/col are integers
is_int() {
    [[ "$1" =~ ^-?[0-9]+$ ]]
}

if ! is_int "$w_row" || ! is_int "$w_col" || ! is_int "$b_row" || ! is_int "$b_col"; then
    usage
fi

# Validate white queen
if (( w_row < 0 )); then
    echo "row not positive"
    exit 1
elif (( w_row > 7 )); then
    echo "row not on board"
    exit 1
fi

if (( w_col < 0 )); then
    echo "column not positive"
    exit 1
elif (( w_col > 7 )); then
    echo "column not on board"
    exit 1
fi

# Validate black queen
if (( b_row < 0 )); then
    echo "row not positive"
    exit 1
elif (( b_row > 7 )); then
    echo "row not on board"
    exit 1
fi

if (( b_col < 0 )); then
    echo "column not positive"
    exit 1
elif (( b_col > 7 )); then
    echo "column not on board"
    exit 1
fi

# Check same position
if (( w_row == b_row && w_col == b_col )); then
    echo "same position"
    exit 1
fi

# Determine attack
if (( w_row == b_row || w_col == b_col )); then
    echo "true"
else
    row_diff=$((w_row - b_row))
    col_diff=$((w_col - b_col))
    # absolute value
    row_diff=${row_diff#-}
    col_diff=${col_diff#-}
    if (( row_diff == col_diff )); then
        echo "true"
    else
        echo "false"
    fi
fi