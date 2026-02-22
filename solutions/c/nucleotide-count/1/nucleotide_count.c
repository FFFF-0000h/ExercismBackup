#include "nucleotide_count.h"

char *count(const char *dna_strand) {
    size_t length = strlen(dna_strand);

    int nucleotides[4] = {0};
    char *answer = malloc(STRING_LEN);
    if (!answer)
        return NULL;
    for (size_t i = 0; i < length; i++)
    {
        switch (dna_strand[i])
        {
        case 'A':
            nucleotides[0]++;
            break;

        case 'C':
            nucleotides[1]++;
            break;

        case 'G':
            nucleotides[2]++;
            break;

        case 'T':
            nucleotides[3]++;
            break;
        
        default:
            strcpy(answer, "");
            return answer;
            break;
        }
    }
    sprintf(answer, "A:%d C:%d G:%d T:%d", nucleotides[0], nucleotides[1], nucleotides[2], nucleotides[3]);
    return answer;
}