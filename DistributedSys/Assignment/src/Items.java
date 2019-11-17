import java.io.*;
import java.util.*;

public class Items implements Serializable {
    //serial item
    private static final long serialVersionUID = 1L;

    //variable for the programme to work
    private String name;
	private double reservePrice;
	private double currentBid;
	//private static int currentItem = 0;
	private boolean sold;
    //way to keep track of the person whom bidded for the item
    private int personId;
    

    //constructor
    public Items(String name, double reservePrice) { 
        this.name = name;
        this.reservePrice = reservePrice;
        currentBid = 0;
        sold = false;
        personId = -10;
    }
    
    //getters and setters
    public String getName() { return name; }
	public void setName(String name) { this.name = name; }

	public double getReservePrice() { return reservePrice; }
	public void setReservePrice(double reservePrice) { this.reservePrice = reservePrice; }

	public double getCurrentBid() { return currentBid; }
	public void setCurrentBid(double currentBid) { this.currentBid = currentBid; }

	public boolean isSold() { return sold; }
	public void setSold(boolean sold) { this.sold = sold; }


    public void setPersonId(int personId){this.personId = personId;}
    public int getPersonId(){return personId;}
    
    public static List<Items> LoadItems()
    {
        List<Items> itemsCollection = new ArrayList<Items>();
        Scanner itemScanner = null;

        try {
            itemScanner = new Scanner(new File("..//resources//items.dat"));
        } catch (Exception e) {
            System.out.println("Unable to load Items");
        }
        String fileLines;
        String [] itemsContents = new String[2];

        while (itemScanner.hasNextLine()) {
			fileLines = itemScanner.nextLine();
            itemsContents = fileLines.split("\t");
            
            itemsCollection.add(new Items(itemsContents[0], Double.parseDouble(itemsContents[1])));
		}
        itemScanner.close();
        
        return itemsCollection;
    }

    public static void SerialiseItems(List<Items> itemsToSerialise)
    {
        // We will use a PrintWriter to write character strings to a file.
        PrintWriter outToFile = null;
        
        try {
            outToFile = new PrintWriter(new FileWriter("..//resources//Sampleitems.dat", true));
            for(Items item: itemsToSerialise)
            {
                outToFile.println(String.format("%s\t%f", item.getName(), item.getReservePrice()));
            }
        } catch (Exception e) {
            System.out.println("Unable to write to file");
        }
        outToFile.close();
    }

    public static Items GetElementToAuction(List<Items> ItemsToBeAuctioned)
    {
        for(Items item: ItemsToBeAuctioned){
            if(item.isSold() == false) {
                return item;
            }
        }
        return null;
    }
}