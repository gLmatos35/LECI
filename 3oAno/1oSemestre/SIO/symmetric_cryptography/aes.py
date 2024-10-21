from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.backends import default_backend
import os

def add_padding(plaintext: bytes, block_size: int = 16) -> bytes:
    padding_length = block_size - (len(plaintext) % block_size)
    padding = bytes([padding_length] * padding_length)
    return plaintext + padding

def remove_padding(padded_text: bytes) -> bytes:
    # Get the last byte which indicates the number of padding bytes
    padding_length = padded_text[-1]
    # Check if the padding length is valid
    if padding_length < 1 or padding_length > 16:   
        raise ValueError("Invalid padding length.")
    # Check if the padding is correct
    if padded_text[-padding_length:] != bytes([padding_length] * padding_length):
        raise ValueError("Invalid padding.")

    return padded_text[:-padding_length]

if __name__ == "__main__":
    plaintext_hex = "00"
    plaintext = bytes.fromhex(plaintext_hex)
    print("Before padding:\n", plaintext)

    padded_text = add_padding(plaintext)
    print("\nAfter padding:\n",padded_text)

    print("\nAfter removing padding:\n",remove_padding(padded_text))

