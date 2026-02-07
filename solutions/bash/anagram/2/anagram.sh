#!/usr/bin/env bash
function order {
    echo $(echo ${1,,} | grep -o . | sort | tr -d "\n")
}

word=$(order $1)
list=""
for w in $2; do
    if [[ $word = $(order $w) && ${1,,} != ${w,,} ]]; then
        list=$list" $w"
    fi
done

echo $list