print("Starting main.lua... \n")

--setup GPIO
led = 3 --GPIO 0
gpio.mode(led, gpio.OUTPUT) -- set GPIO 0 as an output

--create ESP8266 server
srv=net.createServer(net.TCP) -- create TCP server
print("Server created... \n")

--listening on port 80...
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        -- declare variables
        local pinState = "";
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

        --if receive get request "ON", turn LED on
        if(_GET.pin == "ON")then
              gpio.write(led,gpio.HIGH)
              pinState=pinState.."1"
              print("LED ON")
              client:send(pinState);
              client:close();
              collectgarbage();
              
        --if receive get request "OFF", turn LED off     
        elseif(_GET.pin == "OFF")then --ledOff
              gpio.write(led,gpio.LOW)
              pinState=pinState.."0"
              print("LED OFF")
              client:send(pinState);
              client:close();
              collectgarbage();

        --if receive get request "STATS", return pinState to Node.js server
        elseif(_GET.pin == "STATS")then
            --currently in progress
        end
    end)

    -- will trigger when something is sent
    conn:on("sent",function(client)
          print("DATA SENT")
          client:close();
          collectgarbage();
    end)
end)
