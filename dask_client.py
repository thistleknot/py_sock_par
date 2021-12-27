from dask.distributed import Client, progress
#client = Client(threads_per_worker=4, n_workers=1)

client = Client('192.168.3.100:8786')

df.x.sum().compute()

#client = Client(processes=False)
#client
