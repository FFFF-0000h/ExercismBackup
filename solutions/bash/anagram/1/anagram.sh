#!/usr/bin/env bash

function sortString () {
  str=$1
  for (( i=0; i<${#str}; i++ )); do t=${str:i:1}; try[i]=${t,,}; done
  IFS=$'\n' trial=$( sort <<<${try[*]} )
  for i in ${trial[*]}; do tr+=$i; done
  echo $tr
}

wordchars=$(sortString $1)           # $1==target; wordchars==sorted,LC chars
wordlen=${#1}
wordlow=${1,,}

candidates=($2)                      # input candidates into array of strings
for str in "${candidates[@]}"; do
  (( wordlen == ${#str} )) || continue     
  strchars=$(sortString $str)        # get sorted string
  [[ $strchars == $wordchars ]] && [ ${str,,} != $wordlow  ]  && ana+=($str)
done

echo ${ana[@]}
