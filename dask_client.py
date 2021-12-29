from dask.distributed import Client, progress
import numpy as np
#client = Client(threads_per_worker=4, n_workers=1)

client = Client('192.168.3.100:8786')

def sqr(x):
    return x * x

values = np.array(range(0,100))

a = client.submit(sqr, values)

#df.x.sum().compute()
print(a.results())
#client = Client(processes=False)
#client
