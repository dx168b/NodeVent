NetworkService.NetworkTimer:stop();
NetworkService.PublicData.connected = false;
wifi.sta.disconnect();
tmr.unregister(NetworkService.NetworkTimer);
NetworkService.NetworkTimer = nil;
print("[Network Service] Stop service.");
collectgarbage("collect");
