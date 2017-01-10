package Exercice2;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

public class SendUDPMulticast {
	public static void main(String[] args) throws Exception {
		int port = 7654;
		String IPMultiCast = "224.0.0.1";
		
		DatagramSocket datagramSocket = new DatagramSocket();
		
		InetAddress address = InetAddress.getByName(IPMultiCast);
		
		byte[] bs = args[0].getBytes();
		
		DatagramPacket datagramPacket = new DatagramPacket(bs, bs.length);
		datagramPacket.setAddress(address);
		datagramPacket.setPort(port);
		
		datagramSocket.send(datagramPacket);
		
		System.out.println("Sent a multicast message.");
		System.out.println("Exiting application");
		
		datagramSocket.close();
	}
}
