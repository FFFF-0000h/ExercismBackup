#!/usr/bin/env bash

validate_anagram(){
    declare -a arr1=() arr2=()

    input1=${1,,}
    input2=${2,,}

    for ((count=0; count<${#1}; count++))
    do
        arr1+=( "${input1:$count:1}" )
        arr2+=( "${input2:$count:1}" )
    done

    for ((count=0; count<${#1}; count++))
    do
        for ((cnt=0; cnt<${#1}-count; cnt++))
        do
            if [[ ${arr1[cnt]} > ${arr1[cnt+1]} ]]
            then
                temp=${arr1[cnt]}
                arr1[cnt]=${arr1[cnt+1]}
                arr1[cnt+1]=$temp
            fi

            if [[ ${arr2[cnt]} > ${arr2[cnt+1]} ]]
            then
                temp=${arr2[cnt]}
                arr2[cnt]=${arr2[cnt+1]}
                arr2[cnt+1]=$temp
            fi
        done   
    done

    if [[ ${arr1[*]} == "${arr2[*]}"  ]]
    then
        anagrams+=( "${2}" )
    fi
}

precheck_for_anagram(){
    declare -a  anagrams=()
    for word in ${2/ / }
    do
        if [[ "${#1}" == "${#word}"  ]] && ! [[ ${1,,} == "${word,,}" ]]
        then
            validate_anagram "${1}" "${word}"
        fi    
    done
    echo "${anagrams[*]}"
}

main(){
    if [[ $# -ne 2 ]] || [ "$(echo "${1}"|wc -w)" -gt 1 ]
    then
        echo "Usage: sh anagram.sh <word> <words>"
        exit 1
    else
        precheck_for_anagram "${1}" "${2}"
    fi
}

main "$@"