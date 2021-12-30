cp -f /mnt/distvol/python_user/python_user/*.ipynb /mnt/distvol/dev/code/py_sock_par/
cp /mnt/distvol/python_user/python_user/script.sh /mnt/distvol/dev/code/py_sock_par/

cd /mnt/distvol/dev/code/py_sock_par/
ssh -T git@github.com
#git remote set-url origin laferrierejc@gmail.com:github.com/thistleknot/py_sock_par
git add *
git commit -m "testing dask"
git push
