function wait_wifi()
  --wifi.setmode(wifi.STATION)
  wifi.sta.config("YOUR_SSID","PASSWORD")
  wifi.sta.connect()
  wifi_ip = wifi.sta.getip()
  if wifi_ip ~= "192.168.2.23" then --enter your ESP's IP address here
    tmr.alarm(0, 2000,1,wait_wifi)
  else
    wifi_connected = true
    print("Got IP "..wifi_ip.."\n")
    tmr.stop(0)
    dofile("main.lua")
  end
end

wifi.setmode(wifi.STATION)
wifi.sta.config("YOUR_SSID","PASSWORD") 
wait_wifi()


