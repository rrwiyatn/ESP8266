var request = require('request');

// Configure request
var options = {
    url: 'http://192.168.3.101',//ESP's IP address
    method: 'GET'
}
 
// Start the request
request(options, function (error, response, body) 
{
    if(!error) 
	{
        return console.log('Server responded with:', body);
    }
	if(error)
	{
        return console.log('Error:', error);
    }
});

