#include "simple_linked_list.h"

#include <stdexcept>

namespace simple_linked_list {

std::size_t List::size() const {
    return current_size;
}

void List::push(int entry) {
    // Create new element with the given data
    Element* new_element = new Element(entry);
    
    // Make the new element point to the current head
    new_element->next = head;
    
    // Update head to point to the new element
    head = new_element;
    
    // Increase the size counter
    current_size++;
}

int List::pop() {
    // Check if list is empty
    if (head == nullptr) {
        throw std::runtime_error("Cannot pop from empty list");
    }
    
    // Get the data from the first element
    int data = head->data;
    
    // Store a pointer to the element to be deleted
    Element* element_to_delete = head;
    
    // Update head to point to the next element
    head = head->next;
    
    // Delete the old head element
    delete element_to_delete;
    
    // Decrease the size counter
    current_size--;
    
    return data;
}

void List::reverse() {
    Element* prev = nullptr;
    Element* current = head;
    Element* next = nullptr;
    
    // Traverse the list and reverse the links
    while (current != nullptr) {
        // Store next node
        next = current->next;
        
        // Reverse current node's pointer
        current->next = prev;
        
        // Move pointers one position ahead
        prev = current;
        current = next;
    }
    
    // Update head to point to the new first element
    head = prev;
}

List::~List() {
    // Traverse the list and delete all elements
    Element* current = head;
    while (current != nullptr) {
        Element* next = current->next;
        delete current;
        current = next;
    }
    
    // Set head to nullptr for safety
    head = nullptr;
    current_size = 0;
}

}  // namespace simple_linked_list