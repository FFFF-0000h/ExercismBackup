#!/usr/bin/env bash

main()
{
    hour="$1"
    min="$2"
    
    if [[ "$#" -ne "2" && "$#" -ne "4"  ]]; then
        echo "invalid arguments"
        exit 1
    fi

    if ! [[ -z "$4" ]] && ! [[ "$4" =~ ^[-]|[0-9]+$ ]]; then
        echo "invalid arguments"
        exit 1
    fi
    
    if ! [[ -z "$3" ]] && ! [[ "$3" =~ ^[+-]+$ ]]; then
        echo "invalid arguments"
        exit 1
    elif [[ "$1" =~ ^[-]|[0-9]+$ && "$3" == "+" && "$4" =~ ^[-]|[0-9]+$ ]]; then
        min=$(($2+$4))
    elif [[ "$1" =~ ^[-]|[0-9]+$ &&  "$2" =~ ^[-]|[0-9]+$ && "$3" == "-" && "$4" =~ ^[-]|[0-9]+$ ]]; then
        min=$(($2-$4))
    elif [[ "$1" =~ ^[-]|[0-9]+$ && "$2" =~ ^[-]|[0-9]+$ ]]; then
        hour="$1"
        min="$2"
    else
        echo "invalid arguments"
        exit 1
    fi

    horas=$((($hour%24)+(($min/60)%24)))
    minutos=$(($min%60))

    if [[ "$horas" -eq 0 ]]; then
        horas=24
    fi

    if [[ "$horas" -lt 0 && "$minutos" -lt 0 ]]; then
        optHour=$((24+$horas-1))
        optMin=$((60+$minutos))
    elif [[ "$horas" -ge 0 && "$minutos" -ge 0 ]]; then
        optHour=$horas
        optMin=$minutos
    elif [[ "$horas" -ge 0 && "$minutos" -lt 0 ]]; then
        optHour=$(($horas-1))
        if [[ "$minutos" -eq 60 ]]; then
            optMin=0
        else
            optMin=$((60+$minutos))
        fi
    elif [[ "$horas" -lt 0 && "$minutos" -ge 0 ]]; then
        optHour=$((24+$horas))
        optMin=$minutos
    fi
 
    if [[ "$optHour" -eq 24 ]]; then
        optHour="0"
    fi
    if [[ "$optHour" -lt 10 ]]; then
        optHour="0$optHour"
    fi
    if [[ "$optMin" -lt 10 ]]; then
        optMin="0$optMin"
    fi
    
    echo "$optHour:$optMin"
}

main "$@"

