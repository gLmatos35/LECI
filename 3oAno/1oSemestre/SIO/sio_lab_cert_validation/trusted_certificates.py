import os
from validity_check import valid
from cryptography import x509


def trusted(dir_name: str) -> dict:
    """This function reads all the certificates saved in the given directory, returning them in a dictionary
    
    Args:
        dir_name (str): directory name where the certificates are saved

    Returns:
        dict: dictionary with keys as the certificates subjects and as values the corresponding certificates
    """
    result = {}
    
                
    # Code with the necessary logic

    return result

def main():
    trust_certs = trusted("/etc/ssl/certs")
    print(f"{len(trust_certs)} valid trusted certificates found")
            

if __name__ == "__main__":
    main()
