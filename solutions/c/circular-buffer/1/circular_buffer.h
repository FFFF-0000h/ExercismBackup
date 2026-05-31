#ifndef CIRCULAR_BUFFER_H
#define CIRCULAR_BUFFER_H

#include <stdlib.h>
#include <stdint.h>
#include <string.h>

typedef int buffer_value_t;

typedef struct{
    buffer_value_t *buff;
    size_t read_index;
    size_t write_index;
    size_t size, capacity;
}circular_buffer_t;

circular_buffer_t *new_circular_buffer(size_t capacity);
int16_t read(circular_buffer_t *buffer, buffer_value_t *read_value);
int16_t write(circular_buffer_t *buffer, buffer_value_t write_value);
int16_t overwrite(circular_buffer_t *buffer, buffer_value_t write_value);
void clear_buffer(circular_buffer_t *buffer);
void delete_buffer(circular_buffer_t *buffer);

#endif