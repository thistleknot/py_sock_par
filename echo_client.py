#!/usr/bin/env python3

import socket
import pandas as pd
import numpy as np
import _pickle as cPickle

HOST = 'pve0.localdomain'
remote_ip = socket.gethostbyname(HOST)  # The server's hostname or IP address
remote_ip = '127.0.0.1'  # The server's hostname or IP address
PORT = 65434        # The port used by the server

values_0 = [2,3,4,5]
values_1 = [3,4,5,6]
together = np.array([values_0,values_1])

together_t = together.reshape(len(values_0),2)

print(together_t)

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect((remote_ip, PORT))
    #s.sendall(b'Hello, world')
    s.sendall(cPickle.dumps(together_t))
    data = cPickle.loads(s.recv(1024))

print('Received', repr(data))
