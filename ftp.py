from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.handlers import FTPHandler
from pyftpdlib.servers import FTPServer

def main():
    # Instantiate a dummy authorizer for managing 'virtual' users
    authorizer = DummyAuthorizer()

    # Define a user with username, password, home directory, and permissions
    authorizer.add_user("user", "12345", "/home/krypto/ftp", perm="elradfmw")
    # 'elradfmw' grants all permissions: list, enable, retrieve, append, delete, create, modify, write

    # Instantiate FTP handler class
    handler = FTPHandler
    handler.authorizer = authorizer

    # Define the server address and port
    address = ("192.168.29.207", 2121)  # Listen on localhost, port 2121
    server = FTPServer(address, handler)

    # Set a maximum number of simultaneous connections
    server.max_cons = 256
    server.max_cons_per_ip = 5

    # Start the FTP server
    print(f"Starting FTP server on {address[0]}:{address[1]}...")
    server.serve_forever()

if __name__ == "__main__":
    main()
