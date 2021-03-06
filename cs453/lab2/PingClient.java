import java.io.*;   
import java.net.*;   
import java.util.*;   

public class PingClient {   
  
   
  public static void main(String[] args)throws Exception {   
    
    long totalrtt = 0;
    long maxrtt = -9999;
    long minrtt = 9999;
    int drops = 0;
    int retPacket;
    
    if (args.length != 2) {  // check if number of arguments are correct
      System.out.println("Required arguments: host port");   
      return;   
    }   
    String server = args[0];   // Read first argument from user 
    String serport = args[1]; // Read second argument from user
    int serverPort = Integer.parseInt(serport);   
    
    DatagramSocket socket = new DatagramSocket(serverPort); // Create new datagram socket
    socket.setSoTimeout(1000); // Set socket timeout value. Read API for DatagramSocket to do this

    InetAddress serverAddress = InetAddress.getByName(server); //Convert server to InetAddress format; Check InetAddress API for this
    byte[] sendData = new byte[1024];   
    byte[] receiveData = new byte[1024];   
    
    for(int i = 0; i < 10; i++) {  
      Long time = new Long(System.currentTimeMillis());
      String payload = "PING " + i + " " + time + "\r\n"; // Construct data payload for PING as per the instructions
      sendData = payload.getBytes(); // Convert payload into bytes
      DatagramPacket packet = new DatagramPacket(sendData, sendData.length, serverAddress, serverPort);    // Create new datagram packet
      socket.send(packet); // send packet
      
      DatagramPacket reply = new DatagramPacket(receiveData, receiveData.length); // Create datagram packet for reply
      
      try {
        socket.receive(reply);
        byte[] buf = reply.getData();          
        ByteArrayInputStream bais = new ByteArrayInputStream(buf);   
        InputStreamReader isr = new InputStreamReader(bais);   
        BufferedReader br = new BufferedReader(isr);
        String line = br.readLine();   
        
	  // Parse incoming string "line"

	  // extract packet sequence number into the variable retPacket
        retPacket = (int)line.charAt(5) - 48;
        
        if (retPacket != i) {   
          System.out.print("Received out of order packet");
          System.out.println();
        }
	  else {
	    System.out.println("Received from " + reply.getAddress().getHostAddress() + " ," + new String(line)); 
          System.out.println();
          long rtt = System.currentTimeMillis() - Long.parseLong(line.substring(7));  // calculate roundtrip time
          // calculate total, max and min rtt
		  if(rtt < minrtt)
			minrtt = rtt;
		  else if (rtt > maxrtt)
		    maxrtt = rtt;
		  totalrtt += rtt;
        }        
      } 
      catch(SocketTimeoutException e) {
        System.out.println("Error: Request timed out");
        drops++;
      }   
    } 
    long avgrtt = totalrtt/(10-drops); 
    
    // print and store average, max, min rtt and drops
	System.out.printf("Average RTT:\t%d\nMax RTT:\t%d \nMin RTT:\t%d\n", avgrtt, maxrtt, minrtt);
  }    
}   