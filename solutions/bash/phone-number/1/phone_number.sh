#!/usr/bin/env bash

main () {
	local number="$1"
	local format='^\+?1?[^0-9]*([2-9][0-9]{2})[^0-9]*([2-9][0-9]{2})[^0-9]*([0-9]{4})[^0-9]*$'
	if [[ $number =~ $format ]]; then
		echo "${BASH_REMATCH[1]}${BASH_REMATCH[2]}${BASH_REMATCH[3]}"
	else
		echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9"
        return 1
	fi
}

main "$@"