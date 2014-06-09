import os,sys
parentdir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0,parentdir) 
from Mastermind import *

import time

ip = "localhost"
port = 6317

demo = 0
if demo == 0:
    ClassClient = MastermindClientTCP
    ClassServer = MastermindServerTCP
else:
    ClassClient = MastermindClientUDP
    ClassServer = MastermindServerUDP
    
class Server(MastermindServerCallbacksEcho,MastermindServerCallbacksDebug,ClassServer):
    def __init__(self):
        ClassServer.__init__(self)
    #MastermindServerCallbacksEcho already does something like this, so it's not necessary
##    def callback_client_handle(self, connection_object, data):
##        print("Echo server got: \""+str(data)+"\"")
##        self.callback_client_send(connection_object, data)

if __name__ == "__main__":
    server = Server()
    server.connect(ip,port)
    server.accepting_allow()
##    server.accepting_allow_wait_forever()
    print()

    client = ClassClient(1.0,1.0)
    client.connect(ip,port)
    print()
    texts = [
        "Hello world!  How are you today?",
        "I see you're well",
        "Lovely weather, methinks."
    ]
    for text in texts:
        print("Client: sending \""+text+"\"")
        client.send(text,None) #None for no compression
        
        reply = client.receive(True) #True for blocking
        print("Client: got     \""+str(reply)+"\"")
        
        print()
    client.disconnect()
    print()

    server.accepting_disallow()
    server.disconnect_clients()
    server.disconnect()
    
