
var listCollection = [];

var counter = 1;

function AddToList()
{
    let textfield = document.getElementById("l1-p1-Text");

    let textfieldText = textfield.value;

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

    let listItems = document.createElement("li");
    let wordItem = document.createTextNode(textfieldText);

    listItems.appendChild(wordItem);

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