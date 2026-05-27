#!/usr/bin/env bash

main() {
    local type="$1"
    local a="$2"
    local b="$3"
    local c="$4"

    # Valid triangle: all sides > 0 and strict triangle inequality
    local valid=1
    if (( $(echo "$a <= 0" | bc -l) )) || \
       (( $(echo "$b <= 0" | bc -l) )) || \
       (( $(echo "$c <= 0" | bc -l) )); then
        valid=0
    elif (( $(echo "$a + $b <= $c" | bc -l) )) || \
         (( $(echo "$a + $c <= $b" | bc -l) )) || \
         (( $(echo "$b + $c <= $a" | bc -l) )); then
        valid=0
    fi

    if [ $valid -eq 0 ]; then
        echo "false"
        exit 0
    fi

    case "$type" in
        equilateral)
            if (( $(echo "$a == $b && $b == $c" | bc -l) )); then
                echo "true"
            else
                echo "false"
            fi
            ;;
        isosceles)
            if (( $(echo "$a == $b || $b == $c || $a == $c" | bc -l) )); then
                echo "true"
            else
                echo "false"
            fi
            ;;
        scalene)
            if (( $(echo "$a != $b && $b != $c && $a != $c" | bc -l) )); then
                echo "true"
            else
                echo "false"
            fi
            ;;
        *)
            echo "false"
            ;;
    esac
}

main "$@"