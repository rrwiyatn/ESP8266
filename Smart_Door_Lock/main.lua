servo = 4; --GPIO 2 on ESP8266
pwm.setup(servo, 50, 125);
pwm.start(servo);
srv=net.createServer(net.TCP)
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
        buf = buf.."<h1> ESP8266 Web Server</h1>";
        buf = buf.."<p>GPIO2 <a href=\"?pin=ON1\"><button>LOCKED</button></a>&nbsp;<a href=\"?pin=OFF1\"><button>UNLOCKED</button></a></p>";
        local _on,_off = "",""
        if(_GET.pin == "ON1")then --lock
               pwm.close(4)
               pwm.setup(4, 50, 125);
               pwm.start(4);
        elseif(_GET.pin == "OFF1")then --unlock
              pwm.close(4);
              pwm.setup(4, 50, 31);
              pwm.start(4);
        end
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)
