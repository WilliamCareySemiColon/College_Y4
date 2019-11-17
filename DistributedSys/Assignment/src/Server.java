import java.net.*;
import java.io.*;
import java.util.*;

public class Server implements Runnable {
    //varaibles to ensure the server works
    private ServerSocket server = null;
    private Thread thread = null;
    //the variables and information to deal with the clients
    private static final int MAXCLIENTS = 50;
    private ServerThread [] manyClients = new ServerThread[MAXCLIENTS];
    private int clientCount = 0;
    //variable to work with in the application
    private static List<Items> ItemCollection;
    private Items toBeAuctioned;
    private static ClientItems clientItem;
    private Timer timer;
    private TimerTask task;
    private Boolean flag = false;
    //temp timer until bidding starts
    private long timeLeftForBid = 0;

    //constructor for the programme
    public Server(int PORT) {
        try {
            System.out.println("Binding to port " + PORT + ", please wait  ...");
            server = new ServerSocket(PORT);
            System.out.println("Server started: " + server.getInetAddress());
            start();
        } catch(IOException ioe) {
            System.out.println("Can not bind to port " + PORT + ": " + ioe.getMessage());
        }
    
    }//end constructor

    //the operation to kick the programme
    public void start() {
        if (thread == null) {
            thread = new Thread(this);
            timer = new Timer();
            runTimer();
            timer.scheduleAtFixedRate(task,1000l,1000l);
            thread.start();
            
        }
    } //end start

    //the operation to kill the thread
    public void stop(){ thread = null; }

    //the method to run the programme
    public void run() {
        while (thread != null) {
            try{
                System.out.println("Waiting for a client ...");
                addClientThread(server.accept());
            } catch(IOException ioe){
                System.out.println("Server accept error: " + ioe);
                stop();
            }

            StartAuction();

            // if(!flag){
            //     timer.scheduleAtFixedRate(task,1000,1000);
            //     flag = true;
            // }

            if(timeLeftForBid > 5){ //will change to 60 after test
                BroadcastBidSpec();
            }
        }
    }//end run

    //add the client threads that connect to the application
    private void addClientThread(Socket socket) {
        if (clientCount < manyClients.length){
            System.out.println("Client accepted: " + socket);
            manyClients[clientCount] = new ServerThread(this, socket);
            try{
                manyClients[clientCount].open();
                manyClients[clientCount].start();
                clientCount++;
            } catch(IOException ioe){
                System.out.println("Error opening thread: " + ioe);
            }
        } else
            System.out.println("Client refused: maximum " + manyClients.length + " reached.");
    }//end adding client thread

    //method to let the server access the clients using the server
    private int findClient(int ID) {
        for (int i = 0; i < clientCount; i++)
            if (manyClients[i].getID() == ID)
            return i;
        return -1;
    }

    //all the syncronisations programme to ensure the server syncs all the threads

    //display the message to all the users of the application
    public synchronized void broadcast(int ID, String input) {
        if (input.equals("1")){
            manyClients[findClient(ID)].send("1");
            remove(ID);
        } else
            for (int i = 0; i < clientCount; i++){
            if(manyClients[i].getID() != ID) 
                manyClients[i].send(ID + ": " + input); 
            }
        notifyAll();
    }

    //method to remove the client from the collection
    public synchronized void remove(int ID) {
        int pos = findClient(ID);
        if (pos >= 0){
            ServerThread toTerminate = manyClients[pos];
            System.out.println("Removing client thread " + ID + " at " + pos);

            if (pos < clientCount-1){
                for (int i = pos+1; i < clientCount; i++) {
                    manyClients[i-1] = manyClients[i];
                }
            }
            clientCount--;

            try{ toTerminate.close(); } catch(IOException ioe) {
                System.out.println("Error closing thread: " + ioe);
            }
            toTerminate = null;
            System.out.println("Client " + pos + " removed");
            notifyAll();
        }
    }
    //create new items
    public synchronized void AllowNewItemCreation(int ID) {
        manyClients[findClient(ID)].send("Name and reserve price for the item you want to create");
        notifyAll();
    }

    //create new item and add it to the control section
    public synchronized void CreatedNewItem(int ID, String name, Double price){
            Items newItem = new Items(name, price);
            ItemCollection.add(newItem);

            Items.SerialiseItems(ItemCollection);
            broadcast(ID,"New item has been created to be auctioned off");
    }

    //display the items to be auctioned to the user
    public synchronized void DisplayAuctionItems(int ID){
        StringBuffer listItemstoUser = new StringBuffer(200);

        listItemstoUser.append("Items to be auctioned are:\n\n");

        for(Items item: ItemCollection){
            listItemstoUser.append("Name: " + item.getName() + " Price: " 
                + String.valueOf(item.getReservePrice()) + "\n");
        }

        if(ID != -2)
        {
            manyClients[findClient(ID)].send(listItemstoUser.toString());
        }
        else{
            for (int i = 0; i < clientCount; i++){
                manyClients[i].send(listItemstoUser.toString()); 
            }
        }
        notify();
    }

    //method to check the creditals
    public synchronized void CheckCreditals(int ID, String credits){
        String [] creditials = credits.split("---");

        if(clientItem.ClientExist(creditials[0])){
        if(!(clientItem.CheckPassword(creditials[0], creditials[1]))){
            manyClients[findClient(ID)].send("Invalid Creditials");
            manyClients[findClient(ID)].send("1");
            remove(ID);
        }
        } else {
            new ClientItems(creditials[0], creditials[1]);
        }
    }

    // //start the auction for the items to be allocated
    public synchronized void StartAuction(){
        DisplayAuctionItems(-2);
        toBeAuctioned = Items.GetElementToAuction(ItemCollection);

        runTimer();

        String auctionPrice = String.valueOf(
            (toBeAuctioned.getReservePrice() > toBeAuctioned.getCurrentBid() ? 
            toBeAuctioned.getReservePrice() : toBeAuctioned.getCurrentBid())
        ); 

        String message = "\n\nItem currently on auction is " + toBeAuctioned.getName() 
            + "\nand the price is at " + auctionPrice;
        //start the timer tasks
        for (int i = 0; i < clientCount; i++){
            manyClients[i].send(message); 
        }
        notify();
    }

    //checking the bid for the item
    public synchronized void CheckBid(int ID, String bid){
        double bidInput = Double.parseDouble(bid);

        double higherValue = (toBeAuctioned.getReservePrice() > toBeAuctioned.getCurrentBid() ? 
        toBeAuctioned.getReservePrice() : toBeAuctioned.getCurrentBid());

        if(higherValue > bidInput){
            manyClients[findClient(ID)].send("Bid is rejected as it does not match the required number");
        }

        if( (toBeAuctioned.getCurrentBid() == 0 && higherValue <= bidInput)
            || (higherValue < bidInput)){
            timeLeftForBid = 0;
            for (int i = 0; i < clientCount; i++){
                if(manyClients[i].getID() != ID) {
                    manyClients[i].send("New bid of " + bidInput + " has been accepted"); 
                } else{
                    manyClients[findClient(ID)].send("Your bid of " + bidInput + " is acceppted");
                }
            } 
            toBeAuctioned.setCurrentBid(bidInput);
            toBeAuctioned.setPersonId(ID);
            StartAuction();
            notify();
        }
    }

    //return time left on bid
    public synchronized void GetTimeonItemBidded(int ID){
        long timeLeft = 60 - timeLeftForBid;

        manyClients[findClient(ID)].send(timeLeft + " seconds left on current bid");
        notify();
    }

    public synchronized void BroadcastBidSpec(){
        if(toBeAuctioned.getPersonId() == -10){
            timeLeftForBid = 0;
            for (int i = 0; i < clientCount; i++){
                manyClients[i].send("Current item bid has been reset"); 
            } 
        } else {
            for (int i = 0; i < clientCount; i++){
                if(manyClients[i].getID() != toBeAuctioned.getPersonId()) {
                    manyClients[i].send("Current item has been sold"); 
                } else{
                    manyClients[findClient(toBeAuctioned.getPersonId())].send("You have successfully bought the item");
                }
            }
            toBeAuctioned.setSold(true);
            toBeAuctioned.GetElementToAuction(ItemCollection);
        }
        notify();
    }
    //run the timer
    public void runTimer(){
        task = new TimerTask(){
            public void run(){
                timeLeftForBid++;
            }
        };
    }

    //the main programme to kick off the system
    public static void main(String[] args) {
        ItemCollection = Items.LoadItems();
        clientItem = new ClientItems();

        if (args.length != 1)
         System.out.println("Usage: java ChatServer port");
      else
        new Server(Integer.parseInt(args[0]));
    }//end main 
}//end class server