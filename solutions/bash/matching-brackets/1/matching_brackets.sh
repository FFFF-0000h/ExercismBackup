#!/usr/bin/env bash
   main () {
     text=$1
     
     text=$(tr -dc '{}()[]' <<< "$text")
 
     while test ! -z "$text"
	 do
     if echo "$text" | grep "()" > /dev/null
	 then
	 text=$(sed 's/()//g' <<< "$text")
     elif echo "$text" | grep "\[\]" > /dev/null
     then
     text=$(sed 's/\[\]//g' <<< "$text")
     elif echo "$text" | grep "{}" > /dev/null
     then
     text=$(sed 's/{}//g' <<< "$text")
     else
     echo false
     exit 0
    fi

    done
    echo true
	exit 0

   }

   main "$@"

