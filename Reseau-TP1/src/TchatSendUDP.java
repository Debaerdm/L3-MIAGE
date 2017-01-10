import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.util.Scanner;

public class TchatSendUDP extends Thread {
	public void run() {
		int port = 7654;
		String IPMultiCast = "224.0.0.1";
		Scanner args = new Scanner(System.in);
		
		DatagramSocket datagramSocket = null;
		
		try {
			datagramSocket = new DatagramSocket();
			
			InetAddress address = InetAddress.getByName(IPMultiCast);
			
			while(true) {
				byte[] bs = args.nextLine().getBytes();
				
				DatagramPacket datagramPacket = new DatagramPacket(bs, bs.length);
				datagramPacket.setAddress(address);
				datagramPacket.setPort(port);
				
				datagramSocket.send(datagramPacket);
				
				System.out.println("Sent a multicast message.");
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			args.close();
			datagramSocket.close();
		}
	}
	
	public static void main(String[] args) {
		TchatReceiveUDP receiveUDP = new TchatReceiveUDP();
		TchatSendUDP sendUDP = new TchatSendUDP();
		
		receiveUDP.start();
		sendUDP.start();
	}

}
