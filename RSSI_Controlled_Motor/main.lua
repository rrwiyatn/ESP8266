
function f()
     ap_db = {}
     wifi.sta.getap(best_ssid2)
     s=string.sub(a,3,5)
     signal=tonumber(s)
     print("Signal:"..signal)
     val=(signal+100)/100*1023; --Map signal value (0-1023)
     val=math.floor(val);
     pwm.setup(3, 15, val); --Adjust motor speed based on signal power
     pwm.start(3);
     print("Val:"..val);
end

print("Starting main.lua...")
led = 3 --GPIO 0 on the ESP8266
gpio.mode(led, gpio.OUTPUT)
tmr.alarm(0,2500,1,f)
