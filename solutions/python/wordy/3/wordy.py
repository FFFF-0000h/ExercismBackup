"""Module for solving simple math word problems.

This module provides a function `answer` that parses and evaluates
questions like "What is 5 plus 3?" returning the integer result.
"""

import operator


def answer(question: str) -> int:
    """Parse and evaluate a simple math word problem.

    The question must be of the form "What is ...?" where ... is a
    sequence of numbers and operations: 'plus', 'minus', 'multiplied by',
    'divided by'. Operations are evaluated left to right, ignoring normal
    operator precedence.

    Parameters
    ----------
    question : str
        The word problem to evaluate.

    Returns
    -------
    int
        The result of the calculation.

    Raises
    ------
    ValueError
        If the question is malformed (message "syntax error") or contains
        an unknown operation (message "unknown operation").
    """
    # Basic format validation
    if not question.startswith("What is ") or not question.endswith("?"):
        raise ValueError("syntax error")

    # Extract the inner part between "What is " and the final "?"
    inner = question[8:-1].strip()
    if not inner:
        raise ValueError("syntax error")

    # Combine multi-word operations into single tokens
    inner = (inner.replace("multiplied by", "multiplied_by")
                  .replace("divided by", "divided_by"))
    tokens = inner.split()

    # First token must be a number
    try:
        result = int(tokens[0])
    except ValueError as exc:
        raise ValueError("syntax error") from exc

    # Map operation words to functions
    operations = {
        "plus": operator.add,
        "minus": operator.sub,
        "multiplied_by": operator.mul,
        "divided_by": operator.floordiv,
    }

    token_index = 1
    while token_index < len(tokens):
        # Must have an operator at this position
        operation = tokens[token_index]

        # Check if it's a valid operation
        if operation not in operations:
            # If it looks like a number, it's misplaced → syntax error
            if operation.lstrip("-").isdigit():
                raise ValueError("syntax error")
            raise ValueError("unknown operation")

        # Must have a right‑hand side number
        if token_index + 1 >= len(tokens):
            raise ValueError("syntax error")
        try:
            rhs = int(tokens[token_index + 1])
        except ValueError as exc:
            raise ValueError("syntax error") from exc

        # Apply the operation
        result = operations[operation](result, rhs)

        token_index += 2

    return result