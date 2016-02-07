
var fs = require('fs');
var app = require("express")();
//var io = require('socket.io').listen(server);

// Create a server
var server = require('http').createServer(app);
server.listen(8081, function(){
  console.log('listening on *:8081');
});

app.get('/',function (request, response)
{  
   response.sendFile(__dirname + '/index.html');
})

app.post('/',function (request, response)
{  
   console.log('RECEIVE POST');
})

console.log('Server running at http://127.0.0.1:8081/');