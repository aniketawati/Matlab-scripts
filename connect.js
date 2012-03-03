var ws = require('websocket.io')
  , server = ws.listen(3381)
var net = require('net');
var sock;
var tcpcon;
var client;
var connected = false;
var buffer;
server.on('connection', function (socket) {
	sock = socket;
	console.log('connections');
	client = 	net.createConnection('3381','ec2-46-137-225-15.ap-southeast-1.compute.amazonaws.com', 
	function() { //'connect' listener
		console.log('client connected');
		connected = true;
		client.on('data', function(data) {
	//		console.log('data received:'+data);
		//	sock.send(new Buffer(data,'binary').toString('base64'));
			sock.send(data);
		});
		client.on('end', function() {
		sock.close();
		console.log('client disconnected');
		});

	});
	
	socket.on('message', function (message) {
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
	socket.on('close', function () { 
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
