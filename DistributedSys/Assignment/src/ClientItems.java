import java.io.*;
import java.util.*;

public class ClientItems implements Serializable {
    //serial item
    private static final long serialVersionUID = 1L;

    private String username;
    private String password;

    //collection of clients
    private static List<ClientItems> registeredClients = new ArrayList<ClientItems>();

    public ClientItems(String username, String password)
    {
        this.username = username;
        this.password = password;

        registeredClients.add(this);
        WriteClientList();
    }

    public ClientItems() {
        this.SetClientList();
    }

    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password){
        this.password = password;
    }

    public void SetClientList() {
        Scanner itemScanner = null;

        try {
            itemScanner = new Scanner(new File("..//resources//Usersnames.dat"));
        } catch (Exception e) {
            System.out.println("Unable to load Items");
        }
        String fileLines;
        String [] itemsContents = new String[2];

        while (itemScanner.hasNextLine()) {
            fileLines = itemScanner.nextLine();
            itemsContents = fileLines.split("\t");
            
            registeredClients.add(new ClientItems(itemsContents[0], itemsContents[1]));
        }
        itemScanner.close();
    }

    public void WriteClientList() {
        // We will use a PrintWriter to write character strings to a file.
        PrintWriter outToFile = null;
        
        try {
            outToFile = new PrintWriter(new FileWriter("..//resources//Usersnames.dat", true));
            for(ClientItems item: registeredClients)
            {
                if(!ClientExist(item.getUsername())) {
                    outToFile.println(String.format("%s\t%s", item.getUsername(), item.getPassword()));
                }
            }
        } catch (Exception e) {
            System.out.println("Unable to write to file");
        }
        outToFile.close();
    }

    public Boolean ClientExist(String username){
        for(ClientItems clients: registeredClients){
            if(clients.getUsername().equals(username)){
                return true;
            }
        }
        return false;
    }

    public Boolean CheckPassword(String username, String password){
        for(ClientItems clients: registeredClients){
            if(clients.getUsername().equals(username) 
                && clients.getPassword().equals(password)){
                return true;
            }
        }
        return false;
    }

}