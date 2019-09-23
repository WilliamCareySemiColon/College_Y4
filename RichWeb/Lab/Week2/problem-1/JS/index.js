
function display()
{
    //document.getElementsByTagName("button").style.color = "red";
    alert("Hello World");
}

function AddToList()
{
    var textfield = document.getElementById("l1-p1-Text");

    var textfieldText = textfield.value;

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


}