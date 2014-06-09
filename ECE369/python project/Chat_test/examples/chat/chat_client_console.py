try:
    name = raw_input("Enter a screen name: ")
    func_inp = raw_input
except:
    name =     input("Enter a screen name: ")
    func_inp = input

print("Mastermind console-based chat example")
print("Ian Mallett - 2013")
print()
print("Commands:")
print("/exit - exits")
print("/update - updates the screen")
print("<anything else> - adds as a message and updates the screen")
print()

import traceback

from mastermind_import import *
from settings import *
import chat_server

client = None
server = None

already_printed_messages = [None]*scrollback

def blocking_receive():
    global to_send, continuing, already_printed_messages
    try:
        reply = None
        while reply == None:
            reply = client.receive(False)
        chat_history = reply #The entire history of the chat
        
        #Only prints the messages we haven't seen before.  Uses a crude method
        #based on checking equality (messages are timestamped, so even if they
        #have the same content, they'll be "different"), but a more refined
        #approach is necessary for production projects.
        for message in chat_history:
            if message not in already_printed_messages:
                print(message)
                already_printed_messages = already_printed_messages[1:] + [message]
    except MastermindError:
        continuing = False
def main():
    global client, server, continuing

    client = MastermindClientTCP(client_timeout_connect,client_timeout_receive)
    try:
        print("Client connecting on \""+client_ip+"\", port "+str(port)+" . . .")
        client.connect(client_ip,port)
    except MastermindError:
        print("No server found; starting server!")
        server = chat_server.ServerChat()
        server.connect(server_ip,port)
        server.accepting_allow()

        print("Client connecting on \""+client_ip+"\", port "+str(port)+" . . .")
        client.connect(client_ip,port)
    print("Client connected!")

    continuing = True
    while continuing:
        message = func_inp(">>> ")
        if message == "/exit":
            client.send(["leave",name],None)
            blocking_receive()
            break
        elif message == "/update":
            client.send(["update"],None)
            blocking_receive()
        else:
            client.send(["add",""+name+": "+message],None)
            blocking_receive()

    client.disconnect()

    if server != None:
        server.accepting_disallow()
        server.disconnect_clients()
        server.disconnect()
if __name__ == "__main__":
    try:
        main()
    except:
        traceback.print_exc()
        input()

