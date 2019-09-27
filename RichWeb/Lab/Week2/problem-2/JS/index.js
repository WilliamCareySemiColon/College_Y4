var gridCount = 4;

var testTextBox = document.createTextNode("HelloWorld");

function DynamicGridRendering() {
    var parentDiv = document.getElementById("overallParent");
    for (let i = 0; i < gridCount; i++) {
        //secondary div
        var SecondaryParentDiv = document.createElement("div");
        SecondaryParentDiv.className = "SecondaryParentDiv";

        //for (let j = 0; j < gridCount; j++) {

        //    //tertiary div
        //    let divBox = document.createElement("div");
        //    divBox.className = "divBox";

        //    divBox.appendChild(testTextBox);

        //    SecondaryParentDiv.appendChild(divBox);
        //}//inner for loop

        SecondaryParentDiv.appendChild(testTextBox);
        parentDiv.appendChild(SecondaryParentDiv);
    }//outer for loop
}

var resWidth = screen.width;

if (resWidth > 720) {

}