function wait_wifi()
  --wifi.setmode(wifi.STATION)
  wifi.sta.config("HP-Spectre360","17332E6D") 
  print("Checking wifi... \n")
  wifi.sta.connect()
  wifi_ip = wifi.sta.getip()
  if wifi_ip ~= "192.168.3.101" then
    tmr.alarm(0, 2000,1,wait_wifi)
    --print("Waiting WiFi... \n")
  else
    wifi_connected = true
    print("Got IP "..wifi_ip.."\n")
    print("CONNECTED \n")
    tmr.stop(0)
    dofile("main.lua")
  end
end

print("Starting init.lua... \n")
wifi.sta.disconnect()
wifi.setmode(wifi.STATION)
wifi.sta.config("HP-Spectre360","17332E6D") 
wait_wifi()

