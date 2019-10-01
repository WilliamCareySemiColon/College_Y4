var counter = 1;

function AddToList()
{
    //get the dom element that contains the text we want to add to the list
    let textfield = document.getElementById("l1-p1-Text");
    let textfieldText = textfield.value;
    //ensure there is no white space or null values 
    //otherwise reset the box and alert the user
    if(
        (textfieldText.length == 0 || 
            textfieldText == null || 
            (textfieldText.trim() == "")
        )
        )
    {
        textfield.value = ""
        alert("Textbox needs sample text");
        return false;
    }

    //create a list item and attach the word to it
    let listItems = document.createElement("li");
    let wordItem = document.createTextNode(textfieldText);
    listItems.appendChild(wordItem);
    //ensure every third item is red
    if(counter % 3 == 0)
    {
        listItems.setAttribute("style","color:red;");
    }
    else
    {
        listItems.setAttribute("style","color:black;");
    }

    document.getElementById("tableRowsSection").appendChild(listItems);

    counter++;

    return true;
}