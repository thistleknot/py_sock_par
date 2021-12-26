#!/usr/bin/env python3

import socket
import concurrent.futures
import os, time
executor = ThreadPoolExecutor(max_workers=2)

HOST = 'pve0.localdomain'
remote_ip = '192.168.3.18'
#socket.gethostbyname(HOST)  # The server's hostname or IP address
PORT = 9001        # The port used by the server

with ThreadPoolExecutor(max_workers=1) as executor:
    future = executor.submit(pow, 323, 1235)
    print(future.result())

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect((remote_ip, PORT))
    s.sendall(executor.submit(pow, 5, 2))
    #s.sendall(b'Hello, world')
    data = s.recv(1024)

print('Received', repr(data))
