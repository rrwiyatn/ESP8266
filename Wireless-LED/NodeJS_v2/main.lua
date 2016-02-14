print("Starting main.lua... \n")


--setup GPIO
led = 3 --GPIO 0
gpio.mode(led, gpio.OUTPUT) -- set GPIO 0 as an output

--create ESP8266 server
srv=net.createServer(net.TCP) -- create TCP server
print("Server created... \n")
pinState=0 --initially off

--listening on port 80...
srv:listen(80,function(conn)
    conn:on("receive", function(conn,request)
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end

        --print("Received:"..request);
	   print("Method:"..method);

        --if receive POST, toggle LED
        if(method == "POST")then
           if(pinState==0)then -- if off, then on
              gpio.write(led,gpio.HIGH)
              pinState=1
              print("LED ON")
              message="HTTP/1.1 200 OK\r\n"
              message=message.."Content-Type: text/html\r\n\r\n";
              message=message.."POST request successfully received\r\n";
              conn:send(message);
              message=nil;
           elseif(pinState==1)then -- if on, then off
              gpio.write(led,gpio.LOW)
              pinState=0
              print("LED OFF")
              message="HTTP/1.1 200 OK\r\n"
              message=message.."Content-Type: text/html\r\n\r\n";
              message=message.."POST request successfully received\r\n";
              conn:send(message);
              message=nil;
           end
           
        --if receive get request, send state   
        elseif(method == "GET")then
           message="HTTP/1.1 200 OK\r\n"
           message=message.."Content-Type: text/html\r\n\r\n";
           --message=message.."<!DOCTYPE HTML>\r\n<html>\r\n";
           message=message.."LED STATE="..tostring(pinState).."\r\n";
           conn:send(message);
           message=nil;
        end
    end)

    -- will trigger when server successfully responded to request
    conn:on("sent",function(conn)
          print("DATA SENT")
          collectgarbage();
    end)
end)
