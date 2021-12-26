#!/usr/bin/env python3
import concurrent.futures
from concurrent.futures import ThreadPoolExecutor
from concurrent.futures import as_completed
import socket, os
import pandas as pd
import numpy as nd
import _pickle as cPickle
#socketserver.TCPServer.allow_reuse_address = True
#socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

cores = 4
pool2 = concurrent.futures.ProcessPoolExecutor(cores)

hostname = socket.gethostname()
print(hostname)
local_ip = socket.gethostbyname(hostname)

print(local_ip)

#HOST = local_ip  # Standard loopback interface address (localhost)
HOST = '127.0.0.1'  # Standard loopback interface address (localhost)
PORT = 65434        # Port to listen on (non-privileged ports are > 1023)

def square(n):
   return n[0] * n[1]

results_ = []

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((HOST, PORT))
    s.listen()
    conn, addr = s.accept()
    with conn:
        print('Connected by', addr)
        while True:
            data = conn.recv(1024)
            if not data:
                break
            #append
            together_t = cPickle.loads(data)
            with ThreadPoolExecutor(max_workers = 3) as executor:
                results = executor.map(square, together_t)
            for result in results:
                print(result)
                results_.append(result)
            conn.sendall(cPickle.dumps(results_))

