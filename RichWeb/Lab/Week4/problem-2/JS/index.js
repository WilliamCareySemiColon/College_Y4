function LoadTitlesFromAPI()
{
    //fetch the api
    fetch('http://jsonplaceholder.typicode.com/posts')
    //get the data and convert to json
    .then(response => response.json())
    //filter all the json fields by title count of 6+
    .then(json => json.filter(x => x.title.split(" ").length > 6))
    //get the tile only
    .then(data => data.map(x => x.title))
    //display the title
    .then(data => data.forEach(x => console.log(x)));
}
//getting the map frequency
var WordFrequencyMap = {};

function DisplayWordFrequencyMap()
{
    //fetch the api
    fetch('http://jsonplaceholder.typicode.com/posts')
    //get the data and convert to json
     .then(response => response.json())
     //map onto the body contents
     .then(json => json.map(x => x.body))
     //for each body content, split them up and count each word count
     .then(data => 
        data.forEach(x => 
            x.split(" ").forEach(Y => 
                (WordFrequencyMap[Y] == null ? WordFrequencyMap[Y] = 1 :
                 WordFrequencyMap[Y] = WordFrequencyMap[Y] + 1)
            )
        )
    );

    //mapping the keys onto a another object
    let WordFrequencyMapIndexes = Object.keys(WordFrequencyMap);
    //using the keys to access each content word
    WordFrequencyMapIndexes.forEach(key => console.log(key + " : " + WordFrequencyMap[key]));

    //reset the map
    WordFrequencyMap = {};
}