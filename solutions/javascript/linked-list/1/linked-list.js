export class LinkedList {
  constructor() {
    this.head = null;
    this.tail = null;
    this._count = 0;
  }

  // Add element to the end
  push(value) {
    const newNode = new Node(value);
    
    if (this.tail === null) {
      // Empty list
      this.head = newNode;
      this.tail = newNode;
    } else {
      // Add to the end
      this.tail.next = newNode;
      newNode.prev = this.tail;
      this.tail = newNode;
    }
    
    this._count++;
  }

  // Remove and return element from the end
  pop() {
    if (this.tail === null) {
      return undefined; // or throw error
    }
    
    const value = this.tail.value;
    
    if (this.head === this.tail) {
      // Only one element
      this.head = null;
      this.tail = null;
    } else {
      // Remove last element
      this.tail = this.tail.prev;
      this.tail.next = null;
    }
    
    this._count--;
    return value;
  }

  // Remove and return element from the beginning
  shift() {
    if (this.head === null) {
      return undefined; // or throw error
    }
    
    const value = this.head.value;
    
    if (this.head === this.tail) {
      // Only one element
      this.head = null;
      this.tail = null;
    } else {
      // Remove first element
      this.head = this.head.next;
      this.head.prev = null;
    }
    
    this._count--;
    return value;
  }

  // Add element to the beginning
  unshift(value) {
    const newNode = new Node(value);
    
    if (this.head === null) {
      // Empty list
      this.head = newNode;
      this.tail = newNode;
    } else {
      // Add to the beginning
      newNode.next = this.head;
      this.head.prev = newNode;
      this.head = newNode;
    }
    
    this._count++;
  }

  // Delete first occurrence of a value
  delete(value) {
    let current = this.head;
    
    while (current !== null) {
      if (current.value === value) {
        // Found the node to delete
        
        if (current === this.head && current === this.tail) {
          // Only node in the list
          this.head = null;
          this.tail = null;
        } else if (current === this.head) {
          // Deleting head
          this.head = current.next;
          this.head.prev = null;
        } else if (current === this.tail) {
          // Deleting tail
          this.tail = current.prev;
          this.tail.next = null;
        } else {
          // Deleting middle node
          current.prev.next = current.next;
          current.next.prev = current.prev;
        }
        
        this._count--;
        return; // Delete only first occurrence
      }
      
      current = current.next;
    }
  }

  // Count elements in the list
  count() {
    return this._count;
  }
}

// Node class for doubly linked list
class Node {
  constructor(value) {
    this.value = value;
    this.next = null;
    this.prev = null;
  }
}