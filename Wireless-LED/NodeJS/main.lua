print("Starting main.lua... \n")

--setup GPIO
led = 3 --GPIO 0
gpio.mode(led, gpio.OUTPUT)

--create ESP8266 server
srv=net.createServer(net.TCP)
print("Server created... \n")

--listening...
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
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
        local _on,_off = "",""
        if(_GET.pin == "ON")then --ledOn
              gpio.write(led,gpio.HIGH)
              buf=buf.."1"
              print("LED ON")
              client:send(buf);
              client:close();
              collectgarbage();
        elseif(_GET.pin == "OFF")then --ledOff
              gpio.write(led,gpio.LOW)
              buf=buf.."0"
              print("LED OFF")
              client:send(buf);
              client:close();
              collectgarbage();
        elseif(_GET.pin == "STATS")then --send stats
              --sendData()
              print("Sending data...")
              buf=buf.."<h1> HELLO </h1>"
              --client=net.createConnection(net.TCP, 0);
              --client:connect(8081,"http://127.0.0.1");
              client:send(buf);
              
        end
        --client:send(buf);
        --client:close();
        --collectgarbage();
    end)
    conn:on("sent",function(client)
          print("DATA SENT")
          client:close();
          collectgarbage();
    end)
    --conn:on("disconnection",function(client)
    --     print("DISCONNECTED")
          --[[
          client:close();
          srv:close()
          collectgarbage();
          dofile("init.lua")
           ]]--
    --end)
   
end)
