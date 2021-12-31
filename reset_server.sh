#!/bin/bash

#server
#slurm-w01 has gpu prepended
array=('slurm-w02' 'slurm-w03' 'slurm-w04')

ansible -m shell -a "pkill -9 dask-scheduler" ansible; ansible -m shell -a "runuser -l python_user -c '/mnt/distvol/py39_jupyterlab/bin/dask-scheduler >out.log 2>err.log &'" ansible; 

#client

ansible -m shell -a "pkill -9 dask-worker" slurmw; 
for a in "slurm-w01"; do ssh $a "runuser -l python_user -c '/mnt/distvol/py39_jupyterlab/bin/dask-worker tcp://192.168.3.100:8786 --nprocs 4 --nthreads 1 --memory-limit=768MB >out.log 2>err.log &'"; done
for a in "${array[@]}"; do ssh $a "runuser -l python_user -c '/mnt/distvol/py39_jupyterlab/bin/dask-worker tcp://192.168.3.100:8786 --nprocs 4 --nthreads 1 --memory-limit=768MB >out.log 2>err.log &'"; done

for a in "${array[@]}"; do ssh $a "runuser -l python_user -c '/mnt/distvol/py39_jupyterlab/bin/dask-worker tcp://192.168.3.100:8786 --nprocs 4 --nthreads 1 --memory-limit=768MB >out.log 2>err.log &'"; done

#jupyter
#put in python_user's nanobash.rc
#export LD_LIBRARY_PATH="/mnt/distvol/R/4.1.2/lib64/R/lib/"
ansible -m shell -a "pkill -9 jupyter-lab" ansible; ssh ansible "runuser -l python_user -c '/mnt/distvol/py39_jupyterlab/bin/jupyter-lab >out.log 2>err.log &'"
