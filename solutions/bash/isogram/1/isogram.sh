#!/usr/bin/env bash

string="${1,,}"
string="${string//[^a-z]/}"
for (( i = 1; i < ${#string}; i++ )); do
    [[ "${string:0:i}" =~ ${string:i:1} ]] && echo false && exit
done
echo true