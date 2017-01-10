import java.net.DatagramPacket;
import java.net.InetAddress;
import java.net.MulticastSocket;

public class ReceiveUDPMulticast {
	
	public static void main(String[] args) throws Exception {
		int port = 7654;
		String IPMultiCast = "224.0.0.1";
		
		MulticastSocket multicastSocket = null;
		
			byte[] buffer = new byte[1024];
			multicastSocket = new MulticastSocket(port);
			multicastSocket.joinGroup(InetAddress.getByName(IPMultiCast));
			
			while(true) {
				DatagramPacket data = new DatagramPacket(buffer, buffer.length);
				
				System.out.println("Waiting for a multicast message ...");
				multicastSocket.receive(data);
				System.out.println(data.getAddress());
				System.out.println("Server recieved : "+new String(data.getData(), data.getOffset(), data.getLength()));
			
			}
			//multicastSocket.leaveGroup(InetAddress.getByName(IPMultiCast));
			//multicastSocket.close();
	}
}
