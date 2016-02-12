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
    conn:on("receive", function(client,request)
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end 
        end

	   print("Method:"..method);
        --if receive POST, toggle LED
        if(method == "POST")then
           if(pinState==0)then -- if off, then on
              gpio.write(led,gpio.HIGH)
              pinState=1
              print("LED ON")
              --client:close();
              collectgarbage();
           elseif(pinState==1)then -- if on, then off
              gpio.write(led,gpio.LOW)
              pinState=0
              print("LED OFF")
              --client:close();
              collectgarbage();
           end
           
        --if receive get request, send state   
        elseif(method == "GET")then
              conn:send("1");
        end
    end)

    -- will trigger when something is sent
    conn:on("sent",function(client)
          print("DATA SENT")
          --client:close();
          collectgarbage();
    end)
end)
