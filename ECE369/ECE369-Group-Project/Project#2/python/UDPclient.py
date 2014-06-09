# UDP Client (simple echo code in Python)

# Import socket module and system module
from socket import *
import sys

if len(sys.argv) <= 2:
	print 'Usage: "python UDPclient.py server_address server_port"'
	print 'server_address = Visible Inside: "eng-svr-1" or 2 or "localhost" or "127.0.0.1"'
	print '                 Visible Outside: IP address or fully qualified doman name'
	print 'server_port = server socket port: #80GX'
	sys.exit(2)

# Create a UDP client socket: (AF_INET for IPv4 protocols, SOCK_DGRAM for UDP)
clientSocket = socket(AF_INET, SOCK_DGRAM)

# Client takes message from user input, sends it to the server, and receives its echo
while True:
	message = raw_input ("Type a message: ")
	clientSocket.sendto(message, (sys.argv[1], int(sys.argv[2])))
	modifiedMessage, serverAddress = clientSocket.recvfrom(1024)
	print 'Received echo: ' , modifiedMessage
	if message == 'quit' or message == 'shutdown':
		print 'Client quits!'
		break

# Close the client socket
clientSocket.close()
sys.exit(0)
