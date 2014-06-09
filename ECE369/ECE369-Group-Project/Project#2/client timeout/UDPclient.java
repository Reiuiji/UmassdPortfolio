/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//package udpclient;
import java.net.*;
import java.io.*;
/**
 *
 * @author Luis
 */
public class UDPclient {

	/**
	 * @param args the command line arguments
	 */
	//UDPClient.java


	public static void main(String argv[]) throws Exception
	{

		byte[] send_data = new byte[1024];
		byte[] receiveData = new byte[1024];
		int port = 9092;

		if (argv.length == 0)
		{
			System.out.println("Incorrect command line arguments. Expected port");
			return;
		}

		InetAddress IPAddress =  InetAddress.getByName("localhost");
		port = Integer.parseInt(argv[0]);

		System.out.println("Connecting to UDPServer over \n  port: " + port);
		System.out.println("  Ip address: " + IPAddress);

		BufferedReader infromuser = new BufferedReader(new InputStreamReader(System.in));
		DatagramSocket client_socket = new DatagramSocket();
		/* new */ client_socket.setSoTimeout(1000); //MS_count

		while (true)
		{
			System.out.print("Send: ");

			send_data = infromuser.readLine().getBytes();
			try
			{
				DatagramPacket send_packet = new DatagramPacket(send_data, send_data.length, IPAddress, port);

				long T1 = System.nanoTime();
				client_socket.send(send_packet);

				DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);

				client_socket.receive(receivePacket);
				long T2 = System.nanoTime() - T1;
				String sentence = new String(receivePacket.getData() );
				System.out.println("Message Recieved: " + sentence );	
				System.out.println("RTT : " + T2 + " ns");	
			}


			/* new */catch (InterruptedIOException e){
				System.err.println("Client response timeout" + e);

			}

			/* new */catch(IOException ie){
				System.err.println ("Other error occured" + ie);
			}

		}       
	}
}



