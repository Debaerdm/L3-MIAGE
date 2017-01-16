package Exercice3;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.util.Scanner;

public class TchatSendUDP extends Thread {
	
	
	// On utilise un thread pour lancer le serveur
	public void run() {
		int port = 7654;
		String IPMultiCast = "224.0.0.1";

		try (Scanner args = new Scanner(System.in); DatagramSocket datagramSocket = new DatagramSocket()) {
			InetAddress address = InetAddress.getByName(IPMultiCast);

			while (true) {
				byte[] bs = args.nextLine().getBytes();

				// Les commandes clients
				switch (new String(bs)) {
					case "/help":
						StringBuilder builder = new StringBuilder();
						builder.append("The folowing command : \n");
						builder.append("/login <login> : login the actually user in the properties.\n");
						builder.append("/rlogin <login> : modify the login of user.\n");
						builder.append("/exit : exit the program.\n");
						System.out.println(builder);
						break;
					case "/exit":
						System.out.println("You have exit the chat");
						System.exit(0);
					default:

						// Pour ecrire et envoyer vers le serveur
						DatagramPacket datagramPacket = new DatagramPacket(bs, bs.length);
						datagramPacket.setAddress(address);
						datagramPacket.setPort(port);

						datagramSocket.send(datagramPacket);
						break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		
		// Pour lancer et initialiser les threads
		TchatReceiveUDP receiveUDP = new TchatReceiveUDP();
		TchatSendUDP sendUDP = new TchatSendUDP();
		
		receiveUDP.start();
		sendUDP.start();
	}

}
