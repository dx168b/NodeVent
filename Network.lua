-------------------------------------------------------
-- HumRelay network service module

NetworkService = {};

-------------------------------------------------------
-- Network public data
NetworkService.PublicData =
{
	connected = false,
	ip = "0.0.0.0",
	netmask = "0.0.0.0",
	gateway = "0.0.0.0",
	broadcast = "0.0.0.0",
	dns1 = "0.0.0.0",
	dns2 = "0.0.0.0",
	ssid = "none",
	bssid = "00:00:00:00:00:00",
	pwd = "none",
	rssi = 0,
};

-------------------------------------------------------
-- Network private data
NetworkService.wifiOldStatus = 0;

-------------------------------------------------------
-- Network service function (timer callback)
function NetworkService.NetworkService()
	dofile("Network.Service.lc");
end

-------------------------------------------------------
-- Start service function
function NetworkService.Start(serviceParam)
	NetworkService.config = serviceParam;
	dofile("Network.Start.lc");
end

-------------------------------------------------------
-- Stop service function
function NetworkService.Stop()
	dofile("Network.Stop.lc");
end

-------------------------------------------------------
-- Exit from module
print("[Network] Module loaded.");
collectgarbage("collect");
