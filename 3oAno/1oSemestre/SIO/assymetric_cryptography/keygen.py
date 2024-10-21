# from cryptography.hazmat.backends import default_backend
# from cryptography.hazmat.primitives.asymmetric import rsa
# from cryptography.hazmat.primitives import serialization

# def keygen(keySize):  
#     private_key = rsa.generate_private_key(
#         public_exponent=65537,
#         key_size=keySize,
#         backend=default_backend()
#     )

#     with open("private_key.pem", "wb") as private_file:
#         private_file.write(
#             private_key.private_bytes(
#                 encoding=serialization.Encoding.PEM,
#                 format=serialization.PrivateFormat.TraditionalOpenSSL,
#                 encryption_algorithm=serialization.NoEncryption()
#             )
#         )

#     public_key = private_key.public_key()
#     with open("public_key.pem", "wb") as public_file:
#         public_file.write(
#             public_key.public_bytes(
#                 encoding=serialization.Encoding.PEM,
#                 format=serialization.PublicFormat.SubjectPublicKeyInfo
#             )
#         )

# if __name__ == "__main__":
#     keySizeOptions = {
#         1: 1024,
#         2: 2048,
#         3: 3072,
#         4: 4096
#     }

#     t = True
#     while t:
#         try:
#             print("Choose key size:")
#             for option, size in keySizeOptions.items():
#                 print(f"{option}. {size}")
            
#             choice = int(input(">> "))
            
#             if choice in keySizeOptions:
#                 keygen(keySizeOptions[choice])
#                 t = False
#             else:
#                 print("Invalid choice. Try again.")
#         except ValueError:
#             print("Invalid input. Please enter a valid number.")
    
#     print("Keys generated and saved to files!")

import argparse
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import rsa
from cryptography.hazmat.backends import default_backend

def keygen(public_key_path, private_key_path, key_size):  
    private_key = rsa.generate_private_key(
        public_exponent=65537,
        key_size=key_size,
        backend=default_backend()
    )

    with open(private_key_path, "wb") as private_file:
        private_file.write(
            private_key.private_bytes(
                encoding=serialization.Encoding.PEM,
                format=serialization.PrivateFormat.TraditionalOpenSSL,
                encryption_algorithm=serialization.NoEncryption()
            )
        )

    public_key = private_key.public_key()
    with open(public_key_path, "wb") as public_file:
        public_file.write(
            public_key.public_bytes(
                encoding=serialization.Encoding.PEM,
                format=serialization.PublicFormat.SubjectPublicKeyInfo
            )
        )

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate RSA public and private keys.")
    parser.add_argument("public_key_path", type=str, help="Path to save the public key.")
    parser.add_argument("private_key_path", type=str, help="Path to save the private key.")
    parser.add_argument("key_size", type=int, help="Size of the RSA key.")

    args = parser.parse_args()
    keygen(args.public_key_path, args.private_key_path, args.key_size)
    
# python keygen.py ./public_key.pem ./private_key.pem 4096
# no terminal para gerar as chaves