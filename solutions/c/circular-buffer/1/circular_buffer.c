#include "circular_buffer.h"

#include <errno.h>

circular_buffer_t *new_circular_buffer(size_t capacity)
{
    circular_buffer_t *buffer = malloc(sizeof(circular_buffer_t));

    buffer->buff = calloc(capacity, sizeof(buffer_value_t));
    buffer->read_index = 0;
    buffer->write_index = 0;

    buffer->size = 0;
    buffer->capacity = capacity;
    
    return buffer;
}

int16_t read(circular_buffer_t *buffer, buffer_value_t *read_value)
{
    // first check if the buffer is not empty
    if( buffer->size == 0 )
    {
        errno = ENODATA;
        return EXIT_FAILURE;
    }

    *read_value = buffer->buff[buffer->read_index];
    buffer->read_index = (buffer->read_index+1) % buffer->capacity;
    buffer->size--;

    return EXIT_SUCCESS;
}

int16_t write(circular_buffer_t *buffer, buffer_value_t write_value)
{
    // the indexes can be equal even if the buffer is full,
    // proper check case is using the size and capacity
    if( buffer->size == buffer->capacity)
    {
        errno = ENOBUFS;
        return EXIT_FAILURE;
    }

    buffer->buff[buffer->write_index] = write_value;
    buffer->write_index = (buffer->write_index+1) % buffer->capacity;
    buffer->size++;
    
    return EXIT_SUCCESS;
}
int16_t overwrite(circular_buffer_t *buffer, buffer_value_t write_value)
{
    if(buffer->size == buffer->capacity)
    {
        buffer->read_index = (buffer->read_index+1) % buffer->capacity;
        buffer->size--;
    }

    buffer->buff[buffer->write_index] = write_value;
    buffer->write_index = (buffer->write_index+1) % buffer->capacity;
    buffer->size++;
    
    return EXIT_SUCCESS;
}

void clear_buffer(circular_buffer_t *buffer)
{
    buffer->read_index = 0;
    buffer->write_index = 0;
    buffer->size = 0;
    memset(buffer->buff, 0, buffer->capacity*sizeof(buffer_value_t));
}

void delete_buffer(circular_buffer_t *buffer)
{
    free(buffer->buff);
    free(buffer);
}