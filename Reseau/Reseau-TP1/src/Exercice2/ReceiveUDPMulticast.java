package Exercice2;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.InetAddress;
import java.net.MulticastSocket;
import java.net.UnknownHostException;

public class ReceiveUDPMulticast {

	public static void main(String[] args) {
		int port = 7654;
		String IPMultiCast = "224.0.0.1";

		MulticastSocket multicastSocket = null;

		byte[] buffer = new byte[1024];
		try {
			
			// Ecoute sur le port du broadcast
			multicastSocket = new MulticastSocket(port);

			// Rejoint le groupe concernant le multiCast
			multicastSocket.joinGroup(InetAddress.getByName(IPMultiCast));

			while (true) {
				DatagramPacket data = new DatagramPacket(buffer, buffer.length);

				System.out.println("Waiting for a multicast message ...");
				multicastSocket.receive(data);
				System.out.println(data.getAddress());
				System.out
						.println("Server recieved : " + new String(data.getData(), data.getOffset(), data.getLength()));

			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				multicastSocket.leaveGroup(InetAddress.getByName(IPMultiCast));
			} catch (UnknownHostException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			multicastSocket.close();
		}

	}
}
