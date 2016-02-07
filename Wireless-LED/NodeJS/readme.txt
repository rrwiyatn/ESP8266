Controlling LED by using Node.js + ESP8266

The module used for this project is ESP8266 HUZZAH Breakout Board. 
The firmware used is NodeMCU that powered by Lua (see links below)

This folder contains:
	esp.js 		: contain the script to initialize node.js server
	index.html	: contain the HTML file to create the content of web page
	init.lua	: contain script to let your ESP8266 module connect to your wifi
	main.lua	: contain script to tell your ESP8266 module to do whatever you like :)

Make sure you have node.js installed. Also, make sure you have the framework required such as fs and express.
I also use jQuery for this project, make sure you have it too!

For more documentations, please visit:
	ESP8266 HUZZAH Breakout Board: https://learn.adafruit.com/adafruit-huzzah-esp8266-breakout/overview
	NodeMCU: http://nodemcu.com/index_en.html
	NodeMCU Lua Command: http://www.nodemcu.com/docs/index/
	ESP8266 Forum: http://www.esp8266.com/
