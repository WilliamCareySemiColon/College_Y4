function GetUserRepoDetails()
{
    //getting the user details from the fields
    let username = document.getElementById("SeachUserInput").value;

    if(username == null || 
        username.length == 0 ||
        username.trim() == "")
    {
        alert("Username cannot be blank");
        document.getElementById("SeachUserInput").value = "";
        return false;
    }

    //creating the XML Request variables
    let UserProfileXHR = new XMLHttpRequest();
    UserProfileXHR.timeout = 2000;
    UserProfileXHR.onreadystatechange = function(e){
        if(UserProfileXHR.readyState === 4)
        {
            if (UserProfileXHR.status === 200)
            {
                //console.log(UserProfileXHR.response);
                let UserProfileResponse = JSON.parse(UserProfileXHR.response);
                FilterOutJSONObject(UserProfileResponse);
            }
        }
    };

    let UserProfileRepoXHR = new XMLHttpRequest();
    UserProfileRepoXHR.timeout = 2000;
    UserProfileRepoXHR.onreadystatechange = function(e)
    {
        if(UserProfileRepoXHR.readyState === 4)
        {
            if (UserProfileRepoXHR.status === 200)
            {
                //console.log(UserProfileRepoXHR.response);
                SetCollectionOFRepo(JSON.parse(UserProfileRepoXHR.response));
            }
        }
    };
    
    //Creating the strings to get access to the url
    let UserProfileStr = "https://api.github.com/users/" + username;
    let UserProfileRepoStr = UserProfileStr + "/repos";

    //creating the send requests
    UserProfileXHR.open("get", UserProfileStr, true);
    UserProfileXHR.send();

    UserProfileRepoXHR.open("get",UserProfileRepoStr,true);
    UserProfileRepoXHR.send();
}

//function to get the main details of the user and assign them to the fields inside the elements
function FilterOutJSONObject(JSONObject)
{
    //console.log(JSONObject);

    //assiging the image
    if(JSONObject.avatar_url != null)
    {
        document.getElementById("PlaceholderImage").src = JSONObject.avatar_url;
    }

    //assigning the name
    if(JSONObject.name == null)
    {
        document.getElementById("UserProfileName").innerText = "Name: No Name";
    }
    else
    {
        document.getElementById("UserProfileName").innerText = "Name: " + JSONObject.name;
    }

    //assigning the username
    document.getElementById("UserProfileUsername").innerText = "Username: " + JSONObject.login;

    //assigning the email
    if(JSONObject.email == null)
    {
        document.getElementById("UserProfileEmail").innerText = "Email: No Email";
    }
    else
    {
        document.getElementById("UserProfileEmail").innerText = "Email: " + JSONObject.email;
    }

    //assigning the location
    if(JSONObject.location == null)
    {
        document.getElementById("UserProfileLocation").innerText = "Location: No Location";
    }
    else
    {
        document.getElementById("UserProfileLocation").innerText = "Location: " + JSONObject.location;
    }

    //assigning the Number of gists
    if(JSONObject.public_gists == null)
    {
        document.getElementById("UserProfileNoOfGists").innerText = "Number of Gists: None to count";
    }
    else
    {
        document.getElementById("UserProfileNoOfGists").innerText = "Number of Gists: " + JSONObject.public_gists;
    }
}

//function to create and set out the repo collection
function SetCollectionOFRepo(JSONCollection)
{
    if(JSONCollection.length > 0)
    {
        let RepoCollectionDiv = document.getElementById("UserRepos");
        RepoCollectionDiv.innerHTML = "";

        for(let item in JSONCollection)
        {
            let RepoDiv = document.createElement("div");
            RepoDiv.className = "UserReporColloection";

            let namePara = document.createElement("p");
            let desPara = document.createElement("p");

            let nameString = document.createTextNode("Name: " + JSONCollection[item].name);
            let desString = document.createTextNode("Description: " + JSONCollection[item].description);

            namePara.appendChild(nameString);
            desPara.appendChild(desString);

            RepoDiv.appendChild(namePara);
            RepoDiv.appendChild(desPara);

            RepoCollectionDiv.append(RepoDiv);
            //console.log(JSONCollection[item].name);
        }
    }

    else
    {
        alert("No repo to filter through");
    }
}