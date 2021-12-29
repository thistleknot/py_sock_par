import numpy as np

import dask
from dask.distributed import Client, wait
client = Client('192.168.3.18:8786')

def square(x):
        return x ** 2

def neg(x):
        return -x

def inc(x):
        return x + 1

values = np.random.rand(10000,1)
#print(values)

wait(futures)

with dask.config.set(num_workers=6):
    A = client.map(square, values)
    wait(A)

    B = client.map(neg, A)
    wait(B)

#c = client.submit(inc, 10)
#total = client.map(inc, range(1000))
    total = client.submit(sum, B)
    print(total.result())
