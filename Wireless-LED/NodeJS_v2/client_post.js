var request = require('request');
 
// Configure request
var options = {
    url: 'http://192.168.3.101',//ESP's IP address
    method: 'POST'
}
 
// Start the request
request(options, function (error, response, body) {
    if (!error) {
		console.log('SUCCESS',response.statusCode);
    }
	if(error){
		return console.error('ERROR:', error);
	}
})


