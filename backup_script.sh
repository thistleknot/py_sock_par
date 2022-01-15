yes | cp -r /mnt/distvol/python_user/python_user/*.ipynb /mnt/distvol/dev/code/py_sock_par/
yes | cp -r /mnt/distvol/python_user/python_user/*.txt /mnt/distvol/dev/code/py_sock_par/
yes | cp -r /mnt/distvol/python_user/python_user/*.sh /mnt/distvol/dev/code/py_sock_par/

cd /mnt/distvol/dev/code/py_sock_par/
ssh -T git@github.com
git add * .
git commit -m "updating"
git push
