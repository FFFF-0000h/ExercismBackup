def encode(numbers):
    """
    Encode a list of unsigned 32-bit integers into a list of bytes
    using Variable Length Quantity (VLQ) encoding.
    """
    result = []
    for num in numbers:
        if num == 0:
            result.append(0)
            continue

        chunks = []
        while num > 0:
            chunks.append(num & 0x7F)   # lower 7 bits
            num >>= 7
        chunks.reverse()               # most significant chunk first

        # Set the high bit (0x80) on all chunks except the last
        for i in range(len(chunks) - 1):
            chunks[i] |= 0x80

        result.extend(chunks)
    return result


def decode(bytes_):
    """
    Decode a list of VLQ bytes back to a list of unsigned 32-bit integers.
    Raises ValueError if the sequence is incomplete.
    """
    numbers = []
    current = 0
    for b in bytes_:
        current = (current << 7) | (b & 0x7F)
        if (b & 0x80) == 0:
            numbers.append(current)
            current = 0

    if current != 0 or (bytes_ and (bytes_[-1] & 0x80)):
        raise ValueError("incomplete sequence")

    return numbers