package Exercice3;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.InetAddress;
import java.net.MulticastSocket;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class TchatReceiveUDP extends Thread {
	
	// Permet de gerer les utilisateur par le hostAddress et leur nom
	private Map<String, String> users = new HashMap<>();
	private Properties properties;
	private FileInputStream fileInputStream;
	private static final String PROPERTIES_FILES = "ressource/TchatProperties.properties";
	
	public TchatReceiveUDP() {
		// Properties pour garder les données
		this.properties = new Properties();
		try {
			fileInputStream = new FileInputStream(PROPERTIES_FILES);
			// On charge le properties
			this.properties.load(fileInputStream);
			fileInputStream.close();
			
			// Si le properties a des données on l'insert dans la hashmap
			for (String key : this.properties.stringPropertyNames()) {
				String login = this.properties.getProperty(key);
				this.users.put(key, login);
			}
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
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
				
				
				// Permet de se logger et l'enregistrer dans le fichier si il n'existe pas et dans le hashmap
				if (line.startsWith("/login ")) {
					String tmp = line.substring("/login ".length(), line.length());
					
					String hostAdress = data.getAddress().getHostAddress();
					
					if (!users.containsKey(hostAdress)) {
						users.put(hostAdress, tmp);
						FileOutputStream out = new FileOutputStream(PROPERTIES_FILES);
						this.properties.setProperty(hostAdress, tmp);
						this.properties.store(out, null);
						out.close();
						
						
						System.out.println(tmp+" logged");
					} else {
						System.out.println(tmp+" already logged");
					}
				} 
				
				// Permet de changer son login
				if(line.startsWith("/rlogin ")) {
					String tmp = line.substring("/rlogin ".length(), line.length());
					
					String hostAdress = data.getAddress().getHostAddress();
					
					if (users.containsKey(hostAdress)) {
						users.put(hostAdress, tmp);
						FileOutputStream out = new FileOutputStream(PROPERTIES_FILES);
						this.properties.setProperty(hostAdress, tmp);
						this.properties.store(out, null);
						out.close();
					}
				}
				
				String hostAdress = data.getAddress().getHostAddress();
				
				System.out.println(((users.containsKey(hostAdress))? users.get(hostAdress): "Unknow")+" : "+new String(data.getData(), data.getOffset(), data.getLength()));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			multicastSocket.close();
		}
	}
}
