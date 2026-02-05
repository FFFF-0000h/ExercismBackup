def is_paired(input_string):
    # Define matching pairs
    brackets = {'(': ')', '[': ']', '{': '}'}
    opening = set(brackets.keys())  # Opening brackets
    closing = set(brackets.values())  # Closing brackets
    
    stack = []
    
    for char in input_string:
        if char in opening:
            # Push opening bracket onto stack
            stack.append(char)
        elif char in closing:
            # Check if stack is empty (no matching opening bracket)
            if not stack:
                return False
            
            # Check if closing bracket matches the most recent opening bracket
            last_opening = stack.pop()
            if brackets[last_opening] != char:
                return False
    
    # If stack is empty, all brackets were properly matched
    return len(stack) == 0