#include "grade_school.h"
#include <string.h>

void init_roster(roster_t *roster) {
    roster->count = 0;
}

bool add_student(roster_t *roster, const char *name, uint8_t grade) {
    if (roster->count >= MAX_STUDENTS) {
        return false;
    }
    for (size_t i = 0; i < roster->count; i++) {
        if (strncmp(roster->students[i].name, name, MAX_NAME_LENGTH) == 0) {
            return false;
        }
    }
    for (size_t i = 0; i < roster->count; i++) {
        if (roster->students[i].grade > grade || (roster->students[i].grade == grade && strncmp(roster->students[i].name, name, MAX_NAME_LENGTH) > 0)) {
            for (size_t j = roster->count; j > i; j--) {
                roster->students[j] = roster->students[j - 1];
            }
            roster->students[i].grade = grade;
            strncpy(roster->students[i].name, name, MAX_NAME_LENGTH);
            roster->count++;
            return true;
        }
    }
    roster->students[roster->count].grade = grade;
    strncpy(roster->students[roster->count].name, name, MAX_NAME_LENGTH);
    roster->count++;
    return true;
}

roster_t get_grade(roster_t *roster, uint8_t grade) {
    roster_t result;
    init_roster(&result);       
    for (size_t i = 0; i < roster->count; i++) {
        if (roster->students[i].grade == grade) {
            result.students[result.count] = roster->students[i];
            result.count++;
        }
    }
    return result;
}