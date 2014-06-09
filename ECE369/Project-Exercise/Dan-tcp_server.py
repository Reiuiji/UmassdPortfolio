from socket import *
import sys
serverPort = 12000
serverSocket = socket(AF_INET,SOCK_STREAM)
serverSocket.bind(('',serverPort))
serverSocket.listen(1)
print 'The server is ready to receive'
while 1:
    connectionSocket, addr = serverSocket.accept()
    sentence = connectionSocket.recv(1024)
    capitalizedSentence = sentence.upper()
    print 'Client received: ',addr,'  ',capitalizedSentence
    connectionSocket.send(capitalizedSentence)
    connectionSocket.close()
    if capitalizedSentence == 'SHUTDOWN':
        sys.exit('[!] Server Shutting Down')
