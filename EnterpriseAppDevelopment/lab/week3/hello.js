var http = require('http'); 
// include module for the http server
var url = require('url'); 
// include module to split the query string
http.createServer(function (req, res){
	res.writeHead(200,{'Content-Type': 'text/html'});
	var q = url.parse(req.url, true).query; // returns an object
  	res.end('Hello World! The month is: ' + q.month);
	}).listen(8080); 