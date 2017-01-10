package Exercice1;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

public class SendUDP {
	public static void main(String[] args) {
		
		int port = Integer.parseInt(args[0]);
		byte[] buffer = args[1].getBytes();
		
		DatagramSocket datagramSocket = null;
		InetAddress address = null;
		
		try {
			// L'addresse sur lequel on veut envoyer nos donner
			address = InetAddress.getByName("172.18.12.205");
			
			datagramSocket = new DatagramSocket();
			
			DatagramPacket datagramPacket = new DatagramPacket(buffer, buffer.length,address,port);
			// Gere les données
			datagramPacket.setData(buffer);
			
			// Envoie les données
			datagramSocket.send(datagramPacket);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			datagramSocket.close();
		}
	}
}
