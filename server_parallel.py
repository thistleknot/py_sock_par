import concurrent.futures
import socket, os

HOST = ''
PORT = 9001

def request_handler(conn, addr):
    pid = os.getpid()
    print('PID', pid, 'handling connection from', addr)
    while True:
        data = conn.recv(1024)
        if not data:
            print('PID', pid, 'end connection')
            break
        print('PID', pid, 'received:', bytes.decode(data))
        conn.send(data)
    conn.close()

def main():
    with concurrent.futures.ProcessPoolExecutor(max_workers=4) as executor:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
            sock.bind((HOST, PORT))
            sock.listen(10)
            print("Server listening on port", PORT)
            while True:
                conn, addr = sock.accept()
                with conn:
                    executor.submit(request_handler, conn, addr)
                    conn.close()
            print("Server shutting down")


if __name__ == '__main__':
    main()
