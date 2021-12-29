cp /mnt/distvol/python_user/python_user/testing\ dask.ipynb /mnt/distvol/dev/code/socket/
cp /mnt/distvol/python_user/python_user/script.sh /mnt/distvol/dev/code/socket/

cd /mnt/distvol/dev/code/socket
ssh -T git@github.com
git remote set-url origin laferrierejc@gmail.com:github.com/thistleknot/py_sock_par
git add *
git commit -m "testing dask"
git push
