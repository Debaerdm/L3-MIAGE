package Exercice1;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;

public class ReceiveUDP {
	
	public static void main(String[] args) {
		// Recupere le port donner en parametre de la commande
		int port = Integer.parseInt(args[0]);
		DatagramSocket datagramSocket = null;
		
		try {
			
			// Creer un socket qui ecoute sur le port donnée
			datagramSocket = new DatagramSocket(port);
			
			while(true) {
				// Buffer pour recevoir le packet
				byte[] buffer = new byte[120];
				DatagramPacket data = new DatagramPacket(buffer, buffer.length);
				
				// Ecoute(while(true)) et reçois le packet envoyer
				datagramSocket.receive(data);
				System.out.println(data.getAddress());
				System.out.println("Server recieved : "+new String(data.getData(), data.getOffset(), data.getLength()));
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			datagramSocket.close();
		}
		
	}
}
