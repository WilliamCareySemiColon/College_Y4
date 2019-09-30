var tableRowId = 1;

function AddANote()
{
    let note = prompt("What note would you like to add", "Sample Note");

    if(note == null)
    {
        return;
    }

   //getting the notes area 
    let notesArea = document.getElementById('NotesArea');

    //creating the table row and columns containing the notes and the button
    let tableRow = document.createElement("tr");

    //the first column
    let tableColumnNote = document.createElement("td");
    let inputtedNotes = document.createTextNode(note);
    tableColumnNote.appendChild(inputtedNotes);

    //appending the first column to the row
    tableRow.appendChild(tableColumnNote);

    //the second column
    let tableColumnEditButtons = document.createElement("td");
    //creating the buttons and their listener

    //the edit button fields
    let EditButton = document.createElement("button");
    let EditButtonText = document.createTextNode("Edit");
    EditButton.appendChild(EditButtonText);
    EditButton.id = "EditButton" + tableRowId;
    EditButton.addEventListener("click", function EditNote()
    {
        MainEditButtonFunction(EditButton.id);
    });

    tableColumnEditButtons.appendChild(EditButton);
    tableRow.appendChild(tableColumnEditButtons);

    //the delete button fields and function
    let DeleteButtonColumn = document.createElement("td");
    let DeleteButton = document.createElement("button");
    let DeleteButtonText = document.createTextNode("Delete");
    DeleteButton.appendChild(DeleteButtonText);
    DeleteButton.id = "DeleteButton"+tableRowId
    DeleteButton.addEventListener("click", function DeleteNote()
    {
        MainDeleteFunction(DeleteButton.id);
    });

    DeleteButtonColumn.appendChild(DeleteButton);
    tableRow.appendChild(DeleteButtonColumn);
    //attaching the buttons to the table

    notesArea.appendChild(tableRow);

    tableRow.id = tableRowId;

    tableRowId++;
}

function AddANoteToDiv()
{
    let note = prompt("What note would you like to add", "Sample Note");

    if(note == null)
    {
        return;
    }

   //getting the notes area 
    let notesArea = document.getElementById('NotesStorage');

    //creating the div area containing the notes and the button
    let notesDiv = document.createElement("div");

    //the paragraph containing the notes
    let noteParagraph = document.createElement("p");
    let inputtedNotes = document.createTextNode(note);
    noteParagraph.appendChild(inputtedNotes);

    //appending the paragraph and spaces
    notesDiv.appendChild(noteParagraph);
    notesDiv.appendChild(document.createElement("br"));

    //appending the buttons to the div 

    //the edit button fields
    let EditButton = document.createElement("button");
    let EditButtonText = document.createTextNode("Edit");
    EditButton.appendChild(EditButtonText);
    EditButton.id = "EditButton" + tableRowId;
    EditButton.addEventListener("click", function EditNote()
    {
        MainEditButtonFunction(EditButton.id);
    });

    notesDiv.appendChild(EditButton);

    //the delete button fields and function
    let DeleteButton = document.createElement("button");
    let DeleteButtonText = document.createTextNode("Delete");
    DeleteButton.appendChild(DeleteButtonText);
    DeleteButton.id = "DeleteButton"+tableRowId
    DeleteButton.addEventListener("click", function DeleteNote()
    {
        MainDeleteFunction(DeleteButton.id);
    });

    notesDiv.appendChild(DeleteButton);

    notesDiv.className = "NotesInsideDiv";

    notesDiv.id = "NotesInsideDiv" + tableRowId;

    //attaching the buttons to the table
    notesArea.appendChild(notesDiv);
    notesArea.appendChild(document.createElement("br"));

    // tableRow.id = tableRowId;

    tableRowId++;
}

//the function to edit the notes
function MainEditButtonFunction(ButtonID)
{
    let notesArea = document.getElementById('NotesArea');

    let tableRowCollection = notesArea.getElementsByTagName("tr");

    for(let i = 0; i < tableRowCollection.length; i++)
    {
        let tableRowItem = tableRowCollection[i].getElementsByTagName("td");

        let button = tableRowItem[1];

        if(button.innerHTML.match(ButtonID))
        {
            var newText = prompt("What is your new note", tableRowItem[0].innerText);
            if(newText == null)
            {
                return;
            }
            tableRowItem[0].innerText = newText;
            //console.log(button);
            break;
        }
        
    }
}

//the functions to remove the notes
function MainDeleteFunction(ButtonID)
{
   let notesArea = document.getElementById('NotesStorage');

    let notesCollection = notesArea.getElementsByClassName("NotesInsideDiv");

    for(let i = 0; i < notesCollection.length; i++)
    {
        let buttons = notesCollection[i].getElementsByTagName("button");

        let delButton = buttons[1];

        if(delButton.id == ButtonID)
        {
            console.log("item with " + delButton.id + " will be deleted");
            notesArea.removeChild(notesCollection[i]);
            break;
        }
    }
}