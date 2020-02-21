var mysql = require('mysql');
var con = mysql.createConnection({ 
	host: "localhost",
	user: "yourusername",
	password: "yourpassword",
	database: "mydb"
	});
con.connect(function(err) {
	if (err) throw err;
	con.query("SELECT username, pass FROM users", 
	function (err, result, fields) { 	
	// fields is an array with information about each field as an object
		if (err) throw err;
		console.log(result[2].username);
	});
});