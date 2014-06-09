# UDP Server (simple echo code in Python)
# run on "eng-svr-1" x-term ssh at 127.0.0.1 (localhost)
#     or "eng-svr-2" x-term ssh at 134.88.53.55

# Import socket module and system module
import socket
import sys

running = 1
if len(sys.argv) <= 1:
	print 'Usage: "python UDPserver.py server_port"\nserver_port = socket: #80GX'
	sys.exit(2) 

# Create a UDP server socket: (AF_INET for IPv4 protocols, SOCK_DGRAM for UDP)
serverSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
host = socket.gethostname()
print 'Server runs on ', host, 'at ', socket.gethostbyname(host)

# Bind the socket to server address = '' any address the machine has & port = 80GX
serverSocket.bind((host, int(sys.argv[1])))

# Wait for client(s) to initiate communication
while running:
	print 'UDP Server is waiting on port ', sys.argv[1], '...'

	# Do something with the client via serverSocket	
	# Receive a message from the client
	message, clientAddress =  serverSocket.recvfrom(1024)
	print 'Received message: ', message

	# Echo the message in uppercase
	serverSocket.sendto(message.upper(), clientAddress)
		
	# Shut down upon client request
	if message == 'shutdown':
		running = 0

print "UDP Server shuts down!"
# Close serverSocket
serverSocket.close()
sys.exit(0)

