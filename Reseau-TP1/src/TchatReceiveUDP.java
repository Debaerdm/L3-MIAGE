import java.net.DatagramPacket;
import java.net.InetAddress;
import java.net.MulticastSocket;
import java.util.HashMap;
import java.util.Map;

public class TchatReceiveUDP extends Thread {
	
	private Map<String, String> users = new HashMap<>();
	
	public void run() {
		int port = 7654;
		String IPMultiCast = "224.0.0.1";
		
		MulticastSocket multicastSocket = null;
		
		try {
			byte[] buffer = new byte[1024];
			multicastSocket = new MulticastSocket(port);
			multicastSocket.joinGroup(InetAddress.getByName(IPMultiCast));
			
			while(true) {
				DatagramPacket data = new DatagramPacket(buffer, buffer.length);
				multicastSocket.receive(data);
				String line = new String(data.getData(), data.getOffset(), data.getLength());
				if (line.startsWith("/login ")) {
					String tmp = line.substring("/login ".length(), line.length());
					
					String hostAdress = data.getAddress().getHostAddress();
					
					if (!users.containsKey(data.getAddress().getHostAddress())) {
						users.put(hostAdress, tmp);
						
						System.out.println(tmp+" successfuly registered");
					} else {
						System.out.println(tmp+" already exist");
					}
				}
				
				System.out.println(((users.containsKey(data.getAddress().getHostAddress()))? users.get(data.getAddress().getHostAddress()): "Unknow")+" : "+new String(data.getData(), data.getOffset(), data.getLength()));
			
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			multicastSocket.close();
		}
	}
}
