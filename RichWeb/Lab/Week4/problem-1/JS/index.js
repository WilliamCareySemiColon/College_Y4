function HelloWorld()
{
    alert("Hello Worlds");
}

function AddToContactList()
{
    //getting the elements from the form
    let NameInput = document.getElementById("NameInput");
    let nameDetails = NameInput.value;
    console.log(nameDetails);

    let MobileInput = document.getElementById("MobileInput");
    let MobileDetails = MobileInput.value;
    console.log(MobileDetails);

    let EmailInput = document.getElementById("EmailInput");
    let EmailDetails = EmailInput.value;
    console.log(EmailDetails);

    let Table = document.getElementById("PhoneDir");
    //creating the table row to append the element to the end
    let ContactRow = document.createElement("tr");
    let NameInputCol = document.createElement("td");
    let MobileInputCol= document.createElement("td");
    let EmailInputCol = document.createElement("td");

    //attaching the text to the element
    let NameTextNode = document.createTextNode(nameDetails);
    let MobileTextNode = document.createTextNode(MobileDetails);
    let EmailTextNode = document.createTextNode(EmailDetails);

    NameInputCol.appendChild(NameTextNode);
    MobileInputCol.appendChild(MobileTextNode);
    EmailInputCol.appendChild(EmailTextNode);
    //attaching the elements to the table row
    ContactRow.appendChild(NameInputCol);
    ContactRow.appendChild(MobileInputCol);
    ContactRow.appendChild(EmailInputCol);

    //attaching the table row to the table
    Table.appendChild(ContactRow);
}

function ValidateName(Name)
{
    //if(Name.includes([!@#$%^&*(),.?":{}|<>]))
}