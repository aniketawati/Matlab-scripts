

var net = require('net');
var sock;
var tcpcon;
var client;
var connected = false;
var buffer;
server = net.createServer(function(c) {
//server.on('connection', function (socket) {
	sock = c;
	console.log('connections');
	client = 	net.createConnection('5901','96.31.76.142', 
	function() { //'connect' listener
		console.log('client connected');
		connected = true;
		client.on('data', function(data) {
	//		console.log('data received:'+data);
		//	sock.send(new Buffer(data,'binary').toString('base64'));
			sock.write(data);
		});
		client.on('end', function() {
		sock.end();
		console.log('client disconnected');
		});

	});
	
	sock.on('data', function (message) {
//	console.log(message);
//	buffer= new Buffer(message,'base64');
	if(connected == true)
	{		
		//client.write(new Buffer(message,'base64'));
		client.write(message);
	}
	else
	{	
		setTimeout('sendLater()',500);
	}
	});
	sock.on('end', function () { 
	if(connected)
	{
		client.end();
	}
	});	
});

function sendLater()
{

if(connected)
{
	client.write(buffer);
}
else
{
	setTimeout('sendLater()',500);
}
}
server.listen('3381','127.0.0.1');
