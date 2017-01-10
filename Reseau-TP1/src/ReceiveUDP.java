import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;

public class ReceiveUDP {
	
	public static void main(String[] args) {
		int port = Integer.parseInt(args[0]);
		DatagramSocket datagramSocket = null;
		
		try {
			datagramSocket = new DatagramSocket(port);
			
			while(true) {
				
				byte[] buffer = new byte[120];
				DatagramPacket data = new DatagramPacket(buffer, buffer.length);
				
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
