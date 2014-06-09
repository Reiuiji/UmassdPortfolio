/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//package udp_p2p;



import java.net.*;
import java.io.*;
import java.util.Arrays;
/**
 *
 * @author Luis
 */
public class UDP_P2P {

	//UDPServer.java
	public static void main(String argv[]) throws Exception
	{
		byte[] receive_data = new byte[1024];
		byte[] sendData = new byte[1024];
		int recv_port;
		int port = 9092;
                String ip ;                
                String choice;

		while(true){
                System.out.println("Do you want to send a message (y/n)");
                
                BufferedReader infromuser = new BufferedReader(new InputStreamReader(System.in));
                choice = infromuser.readLine();
                System.out.println(choice);
                DatagramSocket p2p = new DatagramSocket(port);  
                
                
                if(choice.equals("y")||choice.equals("Y")){
                        System.out.println("Enter IP Address: "); 
                        ip = infromuser.readLine();
                        InetAddress IPAddress =  InetAddress.getByName(ip);
                        System.out.println("Enter Port Number: "); 
                        port = infromuser.read();
                        System.out.println("Enter message: ");
                        sendData = infromuser.readLine().getBytes();
                        
                        
                        DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length, IPAddress, port);
			p2p.send(sendPacket);                          
                }
                else if(choice != "n" || choice != "N"){
                    System.out.println("USEAGE: Please entr 'y' for yes or 'n' for no "); 
                }
                
                
                DatagramPacket receive_packet = new DatagramPacket(receive_data, receive_data.length);
			p2p.receive(receive_packet);

			InetAddress IPAddress = receive_packet.getAddress();

			recv_port = receive_packet.getPort();

			String sentence = new String(receive_packet.getData() );

			System.out.println("( " + IPAddress + " , " + recv_port + " ) said: " + sentence );

                
		
                }
                
        }
        
}
                      
		

		
