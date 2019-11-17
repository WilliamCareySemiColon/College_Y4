import java.net.*;
import java.io.*;

public class ClientThread extends Thread {
    private Socket           socket   = null;
    private Client           client   = null;
    private DataInputStream  streamIn = null;

    //the constructor for the application
    public ClientThread(Client _client, Socket _socket) {  
        client   = _client;
        socket   = _socket;
        open();
        start();
    }

    //the method to open the communcation lines
    public void open() {  
        try {
            streamIn  = new DataInputStream(socket.getInputStream());
        } catch(IOException ioe) {
            System.out.println("Error getting input stream: " + ioe);
            client.stop();
        }
    }

    //the method to close the thread
    public void close() {  
        try {  
            if (streamIn != null) streamIn.close();
        } catch(IOException ioe) {  
            System.out.println("Error closing input stream: " + ioe);
        }
    }

    //the part to run the application
    public void run() {
        while (true && client!= null) {
            try {
                String message = streamIn.readUTF();

                switch(message)
                {
                    case "Name and reserve price for the item you want to create": {
                        client.SendNewCeatedItem();
                        break;
                    }
                    default: {
                        client.handle(message);
                    }
                }
            } catch(IOException ioe) {
                client = null;
                System.out.println("Listening error: " + ioe.getMessage());
            }
        }
    }
}