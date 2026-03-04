#include "beer_song.h"

#include <stdio.h>
#include <stdint.h>

void recite(uint8_t start_bottles, uint8_t take_down, char **song)
{
   int line = 0;

    for (int verse = 0; verse < take_down; verse++)
    {
        uint8_t bottles = start_bottles - verse;

        // Primeira linha
        if (bottles > 1) {
            snprintf(song[line++], MAX_LINE_LENGTH,
                     "%u bottles of beer on the wall, %u bottles of beer.",
                     bottles, bottles);
        }
        else if (bottles == 1)
        {
            snprintf(song[line++], MAX_LINE_LENGTH,
                     "1 bottle of beer on the wall, 1 bottle of beer.");
        }
        else
        {
            snprintf(song[line++], MAX_LINE_LENGTH,
                     "No more bottles of beer on the wall, no more bottles of beer.");
        }

        // Segunda linha do verso
        if (bottles > 2)
        {
            snprintf(song[line++], MAX_LINE_LENGTH,
                     "Take one down and pass it around, %u bottles of beer on the wall.",
                     bottles - 1);
        }
        else if (bottles == 2)
        {
            snprintf(song[line++], MAX_LINE_LENGTH,
                     "Take one down and pass it around, 1 bottle of beer on the wall.");
        }
        else if (bottles == 1)
        {
            snprintf(song[line++], MAX_LINE_LENGTH,
                     "Take it down and pass it around, no more bottles of beer on the wall.");
        }
        else
        {
            snprintf(song[line++], MAX_LINE_LENGTH,
                     "Go to the store and buy some more, 99 bottles of beer on the wall.");
        }

        if (verse < take_down - 1) 
        {
            song[line++][0] = '\0'; // string vazia
        }
    }
}