#!/usr/bin/env bash

# Ordinal names for days
days=("first" "second" "third" "fourth" "fifth" "sixth" "seventh" "eighth" "ninth" "tenth" "eleventh" "twelfth")

# Gifts corresponding to each day (index 0 = first day)
gifts=(
    "a Partridge in a Pear Tree"
    "two Turtle Doves"
    "three French Hens"
    "four Calling Birds"
    "five Gold Rings"
    "six Geese-a-Laying"
    "seven Swans-a-Swimming"
    "eight Maids-a-Milking"
    "nine Ladies Dancing"
    "ten Lords-a-Leaping"
    "eleven Pipers Piping"
    "twelve Drummers Drumming"
)

start=$1
end=$2

for (( day=start; day<=end; day++ )); do
    # Build the opening line
    line="On the ${days[day-1]} day of Christmas my true love gave to me: "

    if (( day == 1 )); then
        # Day 1 ends simply with the first gift
        line+="${gifts[0]}."
    else
        # List gifts from current day down to day 2, then "and" + first gift
        for (( j=day-1; j>=1; j-- )); do
            line+="${gifts[j]}, "
        done
        line+="and ${gifts[0]}."
    fi

    echo "$line"
done