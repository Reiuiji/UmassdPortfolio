# TCP Server Multithread (simple echo multithread code in Python)
# run on "eng-svr-2" x-term ssh at 134.88.53.55

# Import socket, system, & thread modules
import socket
import sys
import thread

global running

# Function: communicate with the client connected
def connectCommunicate(connectionSocket, (socket, address)):
	global running  # Rebind to global running flag
	print 'Accepted a connection from ', address

	# Do something with the client via connectionSocket
	connecting = 1
	while connecting:
		# Receive a message from the client
		message = connectionSocket.recv(1024)
		print 'Received message: ', message

		# Echo the message in uppercase
		connectionSocket.send(message.upper())		
		
		# Close the server connectionSocket upon client request
		if message == 'shutdown':
			running = 0
		if message == 'quit' or message == 'shutdown':
			connectionSocket.close()
			connecting = 0
# End of Function


# Start of Main
running = 1
if len(sys.argv) <= 1:
	print 'Usage: "python TCPserverMultithread.py server_port"\nserver_port: welcome socket #80GX'
	sys.exit(2) 

# Open a server welcome socket with error handling: try...except
try:
	# Create a TCP server welcome socket: (AF_INET for IPv4 protocols, SOCK_STREAM for TCP)
	serverSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	host = socket.gethostname()
	print 'Server runs on ', host, 'at ', socket.gethostbyname(host)
	# Bind the welcome socket to public host visible outside = gethostname() & port = #80GX
	serverSocket.bind((host, int(sys.argv[1])))
	# Become a server socket by queuing upto 5 connect requests (the normal max) before refusing
	serverSocket.listen(5)
except IOError: # Changed in v2.6: socket.error is now a child class of IOError
	if serverSocket:
		serverSocket.close()
	print 'Oops! Could not open socket.'
	sys.exit(1)

# Listen to the connection requests for communication
while running:
	print 'Threaded TCP Server is listening on port ', sys.argv[1], '...'
	thread.start_new_thread( connectCommunicate, (serverSocket.accept()) )
	# tid = thread.start_new_thread(f, (a) [,kwa]) exits the thread silently when function f returns

print "Server shuts down!"
# Close the server welcome socket: before close, shutdown advisory to the socket at the other end
serverSocket.shutdown(0)
serverSocket.close()
sys.exit(0)
# End of Main