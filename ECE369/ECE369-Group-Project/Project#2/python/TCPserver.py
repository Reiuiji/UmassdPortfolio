# TCP Server (simple echo code in Python)
# run on "eng-svr-1" x-term ssh at 127.0.0.1 (localhost)
#     or "eng-svr-2" x-term ssh at 134.88.53.55

# Import socket module and system module
from socket import *
import sys

running = 1
if len(sys.argv) <= 1:
	print 'Usage: "python TCPserver.py server_port"\nserver_port = welcome socket: #80GX'
	sys.exit(2) 

# Create a TCP server welcome socket: (AF_INET for IPv4 protocols, SOCK_STREAM for TCP)
serverSocket = socket(AF_INET, SOCK_STREAM)
# Bind the welcome socket to server address = '' any address the machine has & port = 80GX
serverSocket.bind(('', int(sys.argv[1])))
# Become a server socket by listening to at most 1 connection at a time
serverSocket.listen(1)

# Listen to the connection requests for communication
while running:
	print 'TCP Server is listening on port ', sys.argv[1], '...'
	
	# Accept a new connection from the client
	connectionSocket, address = serverSocket.accept()
	print 'Accepted a connection from ', address

	# Do something with the client via connectionSocket	
	connecting = 1
	while connecting:
		# Receive a message from the client
		message =  connectionSocket.recv(1024)
		print 'Received message: ', message

		# Echo the message in uppercase
		connectionSocket.send(message.upper())
		
		# Close the server connectionSocket upon client request
		if message == 'shutdown':
			running = 0
		if message == 'quit' or message == 'shutdown':
			connectionSocket.close()
			connecting = 0

print "TCP Server shuts down!"
# Close the server welcome socket: before close, shutdown advisory to the socket at the other end
serverSocket.shutdown(0)
serverSocket.close()
sys.exit(0)

