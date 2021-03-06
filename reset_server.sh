#!/bin/bash

#server
#slurm-w01 has gpu prepended
ansible -m shell -a "mount -t glusterfs pve0:/distvol /mnt/distvol/; ls /mnt/distvol/" slurmw

array=('slurm-w02' 'slurm-w03' 'slurm-w04')

#jupyter
#put in python_user's nanobash.rc
#export LD_LIBRARY_PATH="/mnt/distvol/R/4.1.2/lib64/R/lib/"
ansible -m shell -a "pkill -9 jupyter-lab" ansible; ssh ansible "runuser -l python_user -c '/mnt/distvol/py39_jupyterlab/bin/jupyter-lab >out.log 2>err.log &'"

ansible -m shell -a "pkill -9 dask-scheduler" ansible; ansible -m shell -a "runuser -l python_user -c '/mnt/distvol/py39_jupyterlab/bin/dask-scheduler >out.log 2>err.log &'" ansible; 

#client
#ansible -m shell -a "pkill -9 dask-worker; pkill -9 dask-cuda-worker" slurm-w01
ansible -m shell -a "pkill -9 dask-worker" slurmw; 
#1st one is cuda
#ssh slurm-w01 "runuser -l python_user -c 'CUDA_VISIBLE_DEVICES=0 /mnt/distvol/py39_jupyterlab/bin/dask-cuda-worker tcp://192.168.3.100:8786 --nprocs 1 --nthreads 1 --memory-limit=625MB >out.log 2>err.log &'";
ssh slurm-w01 "runuser -l python_user -c 'LD_PRELOAD=/usr/local/cuda-11.5/targets/x86_64-linux/lib/libnvblas.so /mnt/distvol/py39_jupyterlab/bin/dask-worker tcp://192.168.3.100:8786 --resources 'GPU=1' --name CUDA --nprocs 1 --nthreads 1 --memory-limit=1625MB >out.log 2>err.log &'";
ssh slurm-w01 "runuser -l python_user -c '/mnt/distvol/py39_jupyterlab/bin/dask-worker tcp://192.168.3.100:8786 --nprocs 1 --nthreads 1 --memory-limit=1625MB >out.log 2>err.log &'";
ssh slurm-w01 "runuser -l python_user -c '/mnt/distvol/py39_jupyterlab/bin/dask-worker tcp://192.168.3.100:8786 --nprocs 1 --nthreads 1 --memory-limit=1625MB >out.log 2>err.log &'";
ssh slurm-w01 "runuser -l python_user -c '/mnt/distvol/py39_jupyterlab/bin/dask-worker tcp://192.168.3.100:8786 --nprocs 1 --nthreads 1 --memory-limit=1625MB >out.log 2>err.log &'";
#ssh slurm-w01 "runuser -l python_user -c '/mnt/distvol/py39_jupyterlab/bin/dask-worker tcp://192.168.3.100:8786 --nprocs 1 --nthreads 1 --memory-limit=625MB >out.log 2>err.log &'";
#for a in "slurm-w01"; do ssh $a "runuser -l python_user -c 'CUDA_VISIBLE_DEVICES=0 /mnt/distvol/py39_jupyterlab/bin/dask-cuda-worker tcp://192.168.3.100:8786 --nprocs 1 --nthreads 1 --memory-limit=768MB >out.log 2>err.log &'"; done
#for a in "slurm-w01"; do ssh $a "runuser -l python_user -c '/mnt/distvol/py39_jupyterlab/bin/dask-worker tcp://192.168.3.100:8786 --nprocs 1 --nthreads 1 --memory-limit=768MB >out.log 2>err.log &'"; done
#for a in "slurm-w01"; do ssh $a "runuser -l python_user -c '/mnt/distvol/py39_jupyterlab/bin/dask-worker tcp://192.168.3.100:8786 --nprocs 1 --nthreads 1 --memory-limit=768MB >out.log 2>err.log &'"; done
#for a in "slurm-w01"; do ssh $a "runuser -l python_user -c '/mnt/distvol/py39_jupyterlab/bin/dask-worker tcp://192.168.3.100:8786 --nprocs 1 --nthreads 1 --memory-limit=768MB >out.log 2>err.log &'"; done
for a in "${array[@]}"; do ssh $a "runuser -l python_user -c '/mnt/distvol/py39_jupyterlab/bin/dask-worker tcp://192.168.3.100:8786 --nprocs 4 --nthreads 1 --memory-limit=1625MB >out.log 2>err.log &'"; done
