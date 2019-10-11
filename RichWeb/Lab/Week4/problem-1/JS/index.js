var flag = false;

function ClearPhoneSearchInput()
{
    document.getElementById("PhoneInput").value = "";
    ShowNoResultDiv(false);
}
//dictionary to store all the details
var MobileListDict = {};
var NameListDict = {};
var namesArray = [];

function AddToContactList()
{
    //getting the elements from the form
    let NameInput = document.getElementById("NameInput");
    let nameDetails = NameInput.value;

    let MobileInput = document.getElementById("MobileInput");
    let MobileDetails = MobileInput.value;

    let EmailInput = document.getElementById("EmailInput");
    let EmailDetails = EmailInput.value;

    if(!(
            (ValidateName(nameDetails) && nameDetails.length < 21) &&
            (ValidateNumber(MobileDetails) && MobileDetails.length == 10) &&
            (ValidateEmail(EmailDetails) && EmailDetails.length < 41)
        ))
    {
        document.getElementById("Error").style.visibility = "visible";
    }
    else
    {
        //colecting the eelements into the separate lists collection
        MobileListDict[MobileDetails] = [nameDetails,MobileDetails,EmailDetails];
        NameListDict[nameDetails] = [nameDetails,MobileDetails,EmailDetails];
        namesArray.push(nameDetails);
        
        ReloadDataTable();
    }
    //reset the fields
    NameInput.value = ""; MobileInput.value = "";  EmailInput.value = "";
}

function ValidateName(Name)
{
    let nameTest = /^[ A-Za-z]+$/;

    return nameTest.test(Name);
}

function ValidateNumber(UserNumber)
{
    let NumberTest = /^[0-9]+$/

    return NumberTest.test(UserNumber);
}

function ValidateEmail(Email)
{
    let EmailTest = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

    return EmailTest.test(Email);
}

function CloseErrorMessage()
{
    document.getElementById("Error").style.visibility = "hidden";
}
//display the content on the page
function ReloadDataTable()
{
    let counter = 1;
    //creation of the details for the table
    let Table = document.getElementById("PhoneDir");
    Table.innerHTML = "";
    //create the row
    let firstTableRow = document.createElement("tr");
    //create the headers, withthe first one having a event handler
    let NameTableHeader = document.createElement("th");
    NameTableHeader.appendChild(document.createTextNode("Name"));
    NameTableHeader.addEventListener("click",function SortbyHeader()
    {
        MainSortbyHeader();
    });
    let MobileTableHeader = document.createElement("th");
    MobileTableHeader.appendChild(document.createTextNode("Mobile"));
    let EmailTableHeader = document.createElement("th");
    EmailTableHeader.appendChild(document.createTextNode("Email"));

    firstTableRow.appendChild(NameTableHeader);
    firstTableRow.appendChild(MobileTableHeader);
    firstTableRow.appendChild(EmailTableHeader);

    Table.appendChild(firstTableRow);

    for(let key in NameListDict)
    {
        //creating the table row to append the element to the end
        let ContactRow = document.createElement("tr");
        let NameInputCol = document.createElement("td");
        let MobileInputCol= document.createElement("td");
        let EmailInputCol = document.createElement("td");

        //attaching the text to the element
        let NameTextNode = document.createTextNode(NameListDict[key][0]);
        let MobileTextNode = document.createTextNode(NameListDict[key][1]);
        let EmailTextNode = document.createTextNode(NameListDict[key][2]);

        NameInputCol.appendChild(NameTextNode);
        MobileInputCol.appendChild(MobileTextNode);
        EmailInputCol.appendChild(EmailTextNode);
        //attaching the elements to the table row
        ContactRow.appendChild(NameInputCol);
        ContactRow.appendChild(MobileInputCol);
        ContactRow.appendChild(EmailInputCol);

        if(counter % 2 == 1)
        {
            ContactRow.style.backgroundColor = "#f2f2f2";
            ContactRow.style.color = "black";
        }
        else
        {
            ContactRow.style.backgroundColor = "black";
            ContactRow.style.color = "white";
        }

        //attaching the table row to the table
        Table.appendChild(ContactRow);
        counter++;
    }
}
//sort out the contents by the header
function MainSortbyHeader()
{
    if(flag)
    {
        namesArray.reverse();
        flag = false;
    }
    else
    {
        namesArray.sort();
        flag = true;
    }

    //sort out the elements based off the name array contents
    displaySortedContacts();
}
//sort out the dictionary then reload the data
 function displaySortedContacts()
 {
    let TempDict = {}
    for(let i = 0; i < namesArray.length; i++)
    {
        TempDict[namesArray[i]] = NameListDict[namesArray[i]];
    }
    NameListDict = TempDict;

    ReloadDataTable();
 }

 function FilterOutNumbers()
 {
    let flag = true;
    //setting up the connection
    let PhoneInput = document.getElementById("PhoneInput");
    let keyword = PhoneInput.value.toLowerCase();

    //connect with the data table
    let Table = document.getElementById("PhoneDir");
    let tableRows = Table.getElementsByTagName("tr");
    //checking inside the data table which matches our criteria
    //if it does, let it be visible. Otherwise hide it
    for(let i = 1; i < tableRows.length; i++)
    {
        let name = tableRows[i].getElementsByTagName("td")[0];
        let nameValue = name.innerText.toLowerCase();

        if(nameValue.indexOf(keyword) > -1)
        {
            tableRows[i].style.visibility = "visible";
            flag = false;
        }
         else
        {
            tableRows[i].style.visibility = "hidden";
        }
    }

    ShowNoResultDiv(flag);

 }

 function ShowNoResultDiv(status)
 {
    if(status)
    {
        document.getElementById("noResult").style.visibility = "visible";
    }
    else
    {
        document.getElementById("noResult").style.visibility = "hidden";
    }
 }