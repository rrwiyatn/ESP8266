best_ssid = nil
function best_ssid(ap_db)
   for k,v in pairs(ap_db) do
        if k=="YOUR_SSID" then
            a = v
            dofile("main.lua")
        end
   end
   return
end

best_ssid2 = nil
function best_ssid2(ap_db)
   for k,v in pairs(ap_db) do
        if k=="YOUR_SSID" then
            a = v
        end
   end
   return
end
     
print("starting init.lua..")
ap_db = {}
wifi.sta.getap(best_ssid)
