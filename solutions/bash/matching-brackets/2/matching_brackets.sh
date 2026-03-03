#!/usr/bin/env bash

main () {
    # We make a stack each time we open a bracket.
    # When there is a close bracket, we make sure it corresponds to the last opened, if not -> false
    # at the end if stack empty -> True ; else False
    WAITING_LIST=()

    for (( i=0 ; i<${#1}; i++ )); do

        [[ "${1:i:1}" == '(' ]] && WAITING_LIST=("${WAITING_LIST[@]}" ')')
        [[ "${1:i:1}" == '[' ]] && WAITING_LIST=("${WAITING_LIST[@]}" ']')
        [[ "${1:i:1}" == '{' ]] && WAITING_LIST=("${WAITING_LIST[@]}" '}')

        if [[ "${1:i:1}" == ')' || "${1:i:1}" == ']' || "${1:i:1}" == '}' ]]; then
            if [[ (( ${#WAITING_LIST} != 0 )) && "${1:i:1}" == "${WAITING_LIST[-1]}" ]]; then
                unset 'WAITING_LIST[${#WAITING_LIST[@]}-1]'
            else
                echo "false"
                exit 0
            fi
        fi

    done

    (( ${#WAITING_LIST[@]} == 0 )) && echo "true" || echo "false"
}

main "$@"