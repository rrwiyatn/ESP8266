var fs = require('fs');
var app = require("express")();

// Create server
var server = require('http').createServer(app);

//listen to port 8081
server.listen(8081, function(){
  console.log('listening on *:8081');
});

//open index.html
app.get('/',function (request, response)
{  
   response.sendFile(__dirname + '/index.html');
})

console.log('Server running at http://127.0.0.1:8081/');