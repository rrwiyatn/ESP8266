-- Function declaration
function wait_wifi()
  wifi.sta.connect() -- connect to AP
  wifi_ip = wifi.sta.getip() -- get your ESP's IP address
  if wifi_ip ~= "192.168.3.101" then --enter your ESP's IP address
    tmr.alarm(0, 2000,1,wait_wifi) -- will recall wait_wifi function every 2 sec (2000 ms)
  else
    print("Got IP "..wifi_ip.."\n")
    print("CONNECTED \n")
    tmr.stop(0) -- stop the timer
    dofile("main.lua") -- call our main.lua file
  end
end

-- program starts here
print("Starting init.lua... \n") -- print to your serial terminal (for debugging)
wifi.setmode(wifi.STATION) -- set the module in STATION mode
wifi.sta.config("HP-Spectre360","17332E6D") -- setup WiFi SSID and Password, wifi.sta.config("SSID","PASSWORD")
wait_wifi() -- call wait_wifi function

