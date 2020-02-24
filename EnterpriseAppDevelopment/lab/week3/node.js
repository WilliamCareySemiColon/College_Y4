var mysql = require('mysql');
var con = mysql.createConnection({ 
	host: "localhost",
	user: "William",
	password: "6Y4w7c4M11061998",
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