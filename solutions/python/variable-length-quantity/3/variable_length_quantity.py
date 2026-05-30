"""Module for Variable Length Quantity (VLQ) encoding and decoding of integers."""

def encode(numbers):
    """
    Encode a list of unsigned 32‑bit integers into VLQ bytes.

    Each integer is represented as a sequence of 7‑bit groups, with
    the high bit (0x80) set on all groups except the last one.
    """
    encoded_bytes = []
    for number in numbers:
        if number == 0:
            encoded_bytes.append(0)
            continue

        # Copy the number so we don't reuse the loop variable
        remaining_value = number
        groups = []
        while remaining_value > 0:
            groups.append(remaining_value & 0x7F)
            remaining_value >>= 7

        # Most significant group first
        groups.reverse()

        # Set the continuation bit on all groups except the final one
        for index in range(len(groups) - 1):
            groups[index] |= 0x80

        encoded_bytes.extend(groups)

    return encoded_bytes


def decode(byte_sequence):
    """
    Decode a list of VLQ bytes back to the original integers.

    Raises ValueError if the input sequence is incomplete.
    """
    numbers = []
    current_value = 0

    for byte in byte_sequence:
        current_value = (current_value << 7) | (byte & 0x7F)
        if (byte & 0x80) == 0:
            numbers.append(current_value)
            current_value = 0

    if current_value != 0 or (byte_sequence and (byte_sequence[-1] & 0x80)):
        raise ValueError("incomplete sequence")

    return numbers