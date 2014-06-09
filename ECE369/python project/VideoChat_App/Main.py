#cheep way to enter username till gui input is fixed
try:    name = raw_input("Enter a user name: ")
except: name =     input("Enter a user name: ")

import sys
import os
import user
import vlc
from PyQt4 import QtCore, QtGui, uic
import time

#Chat functions
from mastermind_import import *
from settings import *
import chat_server

#debug
from pprint import pprint

message = ""
to_send = [
    ["introduce",name]
]
already_printed_messages = [None]*scrollback

class Player(QtGui.QMainWindow):

    def __init__(self):
        QtGui.QMainWindow.__init__(self)
        self.setWindowTitle("Video Chat App")
        # creating a basic vlc instance
        self.Instance = vlc.Instance()
        self.MediaPlayer = self.Instance.media_player_new()
        #self.log = self.Instance.log_open()
        self.debug = True
        #self.connect = True
        self.username = name
        self.message = ""
        self.to_send = [
            ["introduce",name]
        ]

        self.createUI()
        self.ui.statusbar.showMessage("Demo Mode")
        self.isPaused = False
        if self.debug == True:
            pprint(vars(self))

    def createUI(self):
        """
                Setup the UI
        """
        self.ui = uic.loadUi("/home/okuu/Dropbox/UMD/Semester#6[Spring_2014]/ECE369/python/VideoChat_App/resources/mainWindow.ui")
        if self.debug == True:
            pprint(vars(self.ui))
        #self.show()
        

        #Set up the user interface, signals & slots
        
        self.Widget = QtGui.QWidget(self)
        self.setCentralWidget(self.Widget)

        # In this widget, the video will be drawn
        self.Palette = self.ui.VideoFrame.palette()
        self.Palette.setColor (QtGui.QPalette.Window, QtGui.QColor(0,0,0))
        self.ui.VideoFrame.setPalette(self.Palette)
        self.ui.VideoFrame.setAutoFillBackground(True)

        self.ui.PlayButton.clicked.connect(self.PlayPause)
        self.ui.StopButton.clicked.connect(self.Stop)
        self.ui.MuteButton.clicked.connect(self.Mute)
        self.ui.Send.clicked.connect(self.send)
        self.ui.actionQuit.triggered.connect(self.Quit)
        #self.connect(self.ui.Send, SIGNAL("clicked()"), self.send)
        #self.connect(self.ui.MuteButton, QtCore.SIGNAL("clicked()"),self.Mute)

        self.ui.VolumeSlider.setMaximum(100)
        self.ui.VolumeSlider.setValue(self.MediaPlayer.audio_get_volume())
        self.connect(self.ui.VolumeSlider,QtCore.SIGNAL("valueChanged(int)"),self.setVolume)
        """
        open = QtGui.QAction("&Open", self)
        self.connect(open, QtCore.SIGNAL("triggered()"), self.OpenFile)
        exit = QtGui.QAction("&Exit", self)
        self.connect(exit, QtCore.SIGNAL("triggered()"), sys.exit)
        menubar = self.menuBar()
        file = menubar.addMenu("&File")
        file.addAction(open)
        file.addSeparator()
        file.addAction(exit)
        
        self.Timer = QtCore.QTimer(self)
        self.Timer.setInterval(200)
        self.connect(self.Timer, QtCore.SIGNAL("timeout()"), self.updateUI)
        """
        

    def PlayPause(self):
        """Toggle play/pause status
        """
        if self.MediaPlayer.is_playing():
            self.MediaPlayer.pause()
            #self.PlayButton.setText("Play")
            if self.debug == True:
                print("Player: Play")
            self.isPaused = True
        else:
            if self.MediaPlayer.play() == -1:
                self.OpenFile()
                return
            self.MediaPlayer.play()
            #self.PlayButton.setText("Pause")
            if self.debug == True:
                print("Player: Pause")
            self.isPaused = False
        
    def Stop(self):
        """Stop player
        """
        self.MediaPlayer.stop()
        #self.ui.PlayButton.setText("Play")
        if self.debug == True:
            print("Player: Stop")

    def Mute(self):
        """Mute/Unmute player
        """
        if self.MediaPlayer.audio_get_mute():
            self.MediaPlayer.audio_set_mute(False)
            if self.debug == True:
                print("Player: UnMute")
        else:
            self.MediaPlayer.audio_set_mute(True)
            if self.debug == True:
                print("Player: Mute")

    def OpenFile(self):
        """Open a media file in a MediaPlayer
        """
        filename = QtGui.QFileDialog.getOpenFileName(self, "Open File", user.home)
        if not filename:
            return

        # create the media
        self.Media = self.Instance.media_new(unicode(filename))
        # put the media in the media player
        self.MediaPlayer.set_media(self.Media)

        # parse the metadata of the file
        self.Media.parse()
        # set the title of the track as window title
        #self.setWindowTitle(self.Media.get_meta(0))

        # the media player has to be 'connected' to the QFrame
        # (otherwise a video would be displayed in it's own window)
        # this is platform specific!
        # you have to give the id of the QFrame (or similar object) to
        # vlc, different platforms have different functions for this
        print('setting media player')
        if sys.platform == "linux2": # for Linux using the X Server
            self.MediaPlayer.set_xwindow(self.ui.VideoFrame.winId())
        elif sys.platform == "win32": # for Windows
            self.MediaPlayer.set_hwnd(self.ui.VideoFrame.winId())
        elif sys.platform == "darwin": # for MacOS
            self.MediaPlayer.set_agl(self.ui.VideoFrame.windId())
        print('enable play')
        self.PlayPause()

    def setVolume(self, Volume):
        """Set the volume
        """
        self.MediaPlayer.audio_set_mute(False)
        self.MediaPlayer.audio_set_volume(Volume)
        if self.debug == True:
            print("volume = ",Volume)

    def Quit(self):
        print('Exiting the demo')
        client.disconnect()
        if server != None:
            server.accepting_disallow()
            server.disconnect_clients()
            server.disconnect()
        sys.exit(app.exec_())

    def send(self):
        global message
        message = str(self.ui.MessageInput.text())
        print('user input ',message)
        #self.ui.ChatScreen.append(UserInput)
        if message != "":
            to_send.append(["add",""+name+": "+message])
            message = ""
            self.ui.MessageInput.clear()
        self.send_next_blocking()
        return True
        

    def send_next_blocking(self):
        global log, to_send, continuing, already_printed_messages
        try:
            if len(to_send) == 0:
                client.send(["update"],None)
            else:
                client.send(to_send[0],None)
                to_send = to_send[1:]

            reply = None
            while reply == None:
                reply = client.receive(False)
            log = reply

            for message in log:
                if message not in already_printed_messages:
                    print(message)
                    self.ui.ChatScreen.append(message)
                    already_printed_messages = already_printed_messages[1:] + [message]
        except MastermindError:
            print('MastermindError')
            continuing = False

    def Chat(self):
        global client, server, continuing

        client = MastermindClientTCP(client_timeout_connect,client_timeout_receive)
        try:
            self.ui.ChatScreen.append("Client connecting on \""+client_ip+"\", port "+str(port)+" . . .")
            client.connect(client_ip,port)
        except MastermindError:
            self.ui.ChatScreen.append("No server found; starting server!")
            server = chat_server.ServerChat()
            server.connect(server_ip,port)
            server.accepting_allow()

            self.ui.ChatScreen.append("Client connecting on \""+client_ip+"\", port "+str(port)+" . . .")
            client.connect(client_ip,port)
        self.ui.ChatScreen.append("Client connected!")
        #self.send_next_blocking()
            
        continuing = True
#        sleep(4)
#        while continuing:
#            nop
            #if not self.connect:
            #    to_send.append(["leave",name])
            #    send_next_blocking()
            #    break
            #self.send_next_blocking()
            #
"""
        client.disconnect()

        if server != None:
            server.accepting_disallow()
            server.disconnect_clients()
            server.disconnect()
"""
"""
    #def Chat(self):
class UserName(QtGui.QDialog):
    def __init__(self):
        self = uic.loadUi("/home/okuu/Dropbox/UMD/Semester#6[Spring_2014]/ECE369/python/VideoChat_App/resources/UserNameWindow.ui")
        self.show()
    def accept(self):
        self = self.userField.text()


#class Chat(QtGui.QMainWindow):
    def __init__(self):
        self.ui = QtGui.QMainWindow
        pprint(vars(QtGui.QMainWindow))
        




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

            self.client = None
            self.server = None
            self.log = [None]*scrollback

            self.message = ""
            self.to_send = [
                ["introduce",name]
            ]

        QtGui.QMainWindow.Send.clicked.connect(self.get_input)
        QtGui.QMainWindow.connect(QtGui.QMainWindow.MessageInput, QtCore.SIGNAL("returnPressed()"),self.get_input)


    def get_input():
        if self.debug == True:
        user_input = pygame.key.get_pressed()
            print('Debug: user input : ',user_input)
        
        for event in pygame.event.get():
            if   event.type == QUIT: return False
            elif event.type == KEYDOWN:
                if   event.key == K_ESCAPE: return False
                elif event.key == K_RETURN:
                    if message != "":
                        to_send.append(["add",""+name+": "+message])
                        message = ""
                elif event.key == K_BACKSPACE:
                    if len(message) > 0:
                        message = message[:-1]
                else:
                    try: message += str(event.unicode)
                    except: pass
            elif event.type == VIDEORESIZE:
                surface = pygame.display.set_mode(event.size,RESIZABLE)
                screen_size = event.size
        return True
"""


if __name__ == "__main__":
    app = QtGui.QApplication(sys.argv)
    MediaPlayer = Player()
    print('media player info')
    pprint(vars(MediaPlayer))
    MediaPlayer.ui.show()
    MediaPlayer.ui.resize(640, 480)
    MediaPlayer.Chat()
    sys.exit(app.exec_())
