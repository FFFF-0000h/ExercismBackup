#!/usr/bin/env bash


   main ()
   {
       bottle=$1
       iteration=$2
       number=(1 2 3 4 5 6 7 8 9 10)
       word=("One" "Two" "Three" "Four" "Five" "Six" "Seven" "Eight" "Nine" "Ten")
       plu_sing="bottles"
       plural="bottles"
       last=1

       if [[ $# -eq 0 ]]; then

           echo "2 arguments expected"
           exit 1
       fi

       if (( $# > 2 )); then

           echo "2 arguments expected"
           exit 1
       
       fi

       if (( iteration > bottle )); then

           echo "cannot generate more verses than bottles"
           exit 1
       
       fi

       for (( i=0; i<$iteration; i++ )); do
            
            for (( j=0; j<10; j++ ));do

                if [[ $bottle -eq ${number[$j]} ]]; then
                
                    string="${word[$j]}"
                    if [[ $string == "One" ]]; then
                        
                        remaining="no"
                        plural="bottle"
                        
                        
                        continue

                    fi
                    ((last=$j - 1 ))
                    remaining="${word[$last]}"
                    #echo "$remaining"

                fi
            
            done

            if [[ ${number[$last]} -eq 1 ]]; then
               # echo "True"
                plu_sing="bottle"

            fi

            if [[ $remaining == "no" ]]; then
            
                plu_sing="bottles"

            fi
            printf "%s\n" \
    "$string green $plural hanging on the wall," \
    "$string green $plural hanging on the wall," \
    "And if one green bottle should accidentally fall," \
    "There'll be ${remaining,} green $plu_sing hanging on the wall."
    if (( i < iteration - 1 )); then
        printf "\n"
    fi

            ((bottle = bottle - 1))
       done

exit 0
   }

   main "$@"

