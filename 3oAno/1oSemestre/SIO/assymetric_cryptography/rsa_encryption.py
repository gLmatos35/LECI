import sys
from cryptography.hazmat.primitives.asymmetric import padding
from cryptography.hazmat.primitives import serialization

message = b"o boia esta a dar em louco"

with open("public_key.pem", "rb") as key_file:
    public_key = serialization.load_pem_public_key(
        key_file.read()
    )

ciphertext = public_key.encrypt(
    message,
    padding.PKCS1v15()
)

with open("encryptedFile.txt", "wb") as encryptedFile:
    encryptedFile.write(ciphertext)

# if __name__ == "__main__":
    