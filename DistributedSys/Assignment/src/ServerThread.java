import java.net.*;
import java.io.*;
import java.util.*;
import java.util.regex.*;

public class ServerThread extends Thread {
    private Server           server    = null;
    private Socket           socket    = null;
    private int              ID        = -1;
    private DataInputStream  streamIn  = null;
    private DataOutputStream streamOut = null;
    private Thread           thread    = null;

    //the constructor for the threads for the appliction
    public ServerThread(Server _server, Socket _socket) {
        super();
        server = _server;
        socket = _socket;
        ID     = socket.getPort();
    }

    //getter of the id for the thread
    public int getID(){ return ID;}

    //create and open the communication channel
    public void open() throws IOException {
        try {
            streamIn = new DataInputStream(new BufferedInputStream(socket.getInputStream()));
            streamOut = new DataOutputStream(new BufferedOutputStream(socket.getOutputStream()));
        } catch (IOException e) {
            System.out.println("Error opening the comminication channels");
        }
    }

    //the method to close the thread
    public void close() throws IOException {
        if (socket != null) socket.close();

        if (streamIn != null) streamIn.close();

        if (streamOut != null) streamOut.close();
   }

    //the programme to run the thread
    public void run() {
        System.out.println("Server Thread " + ID + " running.");
        thread = new Thread(this);
        while (true){
            try{
                String choice = streamIn.readUTF();
                String [] choices = null;
                String credits = "";
                String number = "";

                Pattern pattern = Pattern.compile("(\\d+)");
                Matcher m = pattern.matcher(choice);

                if(m.matches()) {
                    number = choice;
                    choice = "Bid";
                }

                if(choice.contains(" ")) {
                    choices = new String [2];
                    String [] items = choice.split(" ");

                    for(int i = 0; i < choices.length; i++) {
                        choices[i] = items[i];
                    }
                }
                if(choice.contains("---")) {
                    credits = choice;
                    choice = "-2";
                }

                switch(choice) {
                    case "Create": {
                        server.AllowNewItemCreation(ID);
                        break;
                    }
                    case "List":{
                        server.DisplayAuctionItems(ID);
                        break;
                    }
                    case "Bid":{
                        server.CheckBid(ID,number);
                        break;
                    }
                    case "Leave":{
                        server.broadcast(ID, "1");
                        break;
                    }
                    case "Time":{
                        server.GetTimeonItemBidded(ID);
                        break;
                    }
                    case "-2":{
                        server.CheckCreditals(ID,credits);
                    }
                    default:{
                        if(choices == null) {
                            server.broadcast(ID, choice);
                        } else {
                            server.CreatedNewItem(ID,choices[0], 
                                Double.parseDouble((choices)[1]));
                        }
                    }

                }
                //not the best pratise to use sleepers - need to modify
                int pause = (int)(Math.random()*3000);
                Thread.sleep(pause);
                //area to modify in the future
            } catch (InterruptedException e) {
                System.out.println(e);
            } catch(IOException ioe){
                server.remove(ID);
                thread = null;
            }
        }
   }

   //the method to send the message to the client server
   public void send(String msg) {
	   try {
            streamOut.writeUTF(msg);
            streamOut.flush();
        } catch(IOException ioe) {
            System.out.println(ID + " ERROR sending: " + ioe.getMessage());
            server.remove(ID);
            thread=null;
        }
   }

}