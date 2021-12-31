#!/bin/bash

#server

ansible -m shell -a "pkill -9 dask-scheduler" ansible; ansible -m shell -a "runuser -l python_user -c '/mnt/distvol/py39_jupyterlab/bin/dask-scheduler >out.log 2>err.log &'" ansible; ansible -m shell -a "pkill -9 dask-worker" slurmw; for a in "${array[@]}"; do ssh $a "runuser -l python_user -c '/mnt/distvol/py39_jupyterlab/bin/dask-worker tcp://192.168.3.100:8786 --nprocs 4 --nthreads 1 --memory-limit=3GB >out.log 2>err.log &'"; done

#client

ansible -m shell -a "pkill -9 dask-worker" slurmw; for a in "${array[@]}"; do ssh $a "runuser -l python_user -c '/mnt/distvol/py39_jupyterlab/bin/dask-worker tcp://192.168.3.100:8786 --nprocs 4 --nthreads 1 --memory-limit=768MB >out.log 2>err.log &'"; done
