import socket
from multiprocessing import Process
from threading import Thread


class MyTcpServer:
  def __init__(self, ip, port):
    self.ip = ip
    self.port = port
    self.server = socket.socket()
    self.server.bind((self.ip, self.port))
    self.server.listen(5)

  def wait_accept(self):
    conn, addr = self.server.accept()
    return conn, addr

  def handle_request(self, conn):
    while 1:
      try:
        data = conn.recv(1024)
        if not data: break
        conn.send(data.upper())
      except Exception as e:
        print(e)
        break
    conn.close()


if __name__ == '__main__':
  server = MyTcpServer('127.0.0.1', 8888)
  while 1:
    conn, addr = server.wait_accept()
    p = Process(target=server.handle_request, args=(conn, ))	#  Create 1 Processes 
    p.start()	#  Tell the operation to provide and start the process 
