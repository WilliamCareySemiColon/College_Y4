import java.net.*;
import java.util.Scanner;
import java.io.*;

public class Client implements Runnable {
    private Socket           socket    = null;
    private Thread           thread    = null;
    private BufferedReader   console   = null;
    private DataOutputStream streamOut = null;
    private ClientThread client    = null;
    private String username;
    private String password;

    //the contructor for the client access
    public Client(String serverName, int serverPort, String username, String password) {
        System.out.println("Establishing connection. Please wait ...");

        this.username = username;
        this.password = password;
        try{
            socket = new Socket(serverName, serverPort);
            System.out.println("Connected: " + socket);
            start();
        } catch(UnknownHostException uhe){
            System.out.println("Host unknown: " + uhe.getMessage());
        } catch(IOException ioe) {
            System.out.println("Unexpected exception: " + ioe.getMessage());
        }
    }

    //the application to start the client threads
    public void start() throws IOException {
        console = new BufferedReader(new InputStreamReader(System.in));
        streamOut = new DataOutputStream(socket.getOutputStream());
        if (thread == null) {  
            client = new ClientThread(this, socket);
            thread = new Thread(this);
            thread.start();
            CheckUsernameCreditials(username, password);
        }

    }

    //the method to stop each client
    public void stop() {
        try {  
            if (console   != null)  console.close();
            if (streamOut != null)  streamOut.close();
            if (socket    != null)  socket.close();
        } catch(IOException ioe) {
            System.out.println("Error closing ...");
        }
        client.close();
        thread = null;
    }

    //the part of the application to run the thread
    public void run() {
        while (thread != null) {
            try {
                DisplayOptions();
                String message = console.readLine();
                //ensure no negative numbers are passed back
                if(!message.contains("-")){
                    streamOut.writeUTF(message);
                    streamOut.flush();
                }
            } catch(IOException ioe) {  
                System.out.println("Sending error: " + ioe.getMessage());
                stop();
            }
        }
    }

    //the handling of the application input and output
    public void handle(String msg) {  
        if (msg.equals("1")) {  
            System.out.println("Good bye. Press RETURN to exit ...");
            stop();
        } else
            System.out.println(msg);
    }

    public void DisplayOptions() {
        System.out.println(
            "Select your keyword option from the list below\n" +
            "Time: Check the time left\n" +
            "'Leave': Leave Auction System\n" + 
            "'Enter a number': Bid on a item \n" + 
            "'Create': Create New Item to auction\n" +
            "'List':List items on auction\n\n" 
        );
    }

    //creation of the new object
    public void SendNewCeatedItem(){
        String itemAuctioned = null;
        String name = null;
        String price = null;
        try {
            System.out.println("Please enter the details of the item to be auctioned");
            itemAuctioned = console.readLine();

            System.out.println(itemAuctioned);

            String items [] = itemAuctioned.split(" ");

            name = items[0]; price = items[1];
            String parameters = name + " " + price;
            try {
                streamOut.writeUTF(parameters);
                streamOut.flush();
            } catch (IOException e) {
                System.out.println("Failed to send details");
            }
        } catch(Exception e) {
            System.out.println("Cannot enter new items - invalid entries\n");
        }
    }

    //method to check the usernames of the objects
    public void CheckUsernameCreditials(String username, String password){
        try {
            streamOut.writeUTF(username+"---"+password);
            streamOut.flush();
        } catch (IOException e) {
            System.out.println("Failed to get credits for spec details");
        }
    }
    //the main programme for client execution
    public static void main(String args[]) {  
        if (args.length != 4) 
            System.out.println("Usage: java ChatClient host port name password");
        else
            new Client(args[0], Integer.parseInt(args[1]), args[2], args[3]) ;
    }
    /*Had plans to store to file and check from there the user, which is why I started with the four args as the fourth would have been 
    a password. Time condtraints me from this*/
}