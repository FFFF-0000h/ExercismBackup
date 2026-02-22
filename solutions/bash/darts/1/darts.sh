#!/usr/bin/env bash

main () {

    radius=( 1 5 10 )
    points=" "
    return=1

    is_numerical='^[+-]?[0-9]+([.][0-9]+)?$'
	if [[ $# -eq 2 ]] && [[ $1 =~ $is_numerical ]] && [[ $2 =~ $is_numerical ]]; then
        distance=$(echo "scale=2; calc=($1^2); calc+=($2^2); sqrt(calc)" | bc)
        if (( $(echo "$distance > ${radius[2]}" | bc -l) )); then
            points="0"
        elif (( $(echo "$distance > ${radius[1]}" | bc -l) )); then
            points="1"
        elif (( $(echo "$distance > ${radius[0]}" | bc -l) )); then
            points="5"
        else
            points="10"
        fi
        return=0
    fi

    echo "$points"
    return $return

}

main "$@"
