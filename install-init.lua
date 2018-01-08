-------------------------------------------------------
-- HumRelay main script

-------------------------------------------------------
-- Loading config

configApi = require("confman");

config = configApi.LoadConfig("config.user.lc");

if(config == nil) then
	config = configApi.LoadConfig("config.factory.lc");
	if(config ~= nil) then
		configApi.SaveConfig("config.user.lua", config);
		node.compile("config.user.lua");
		print("[SYSTEM] User configuration not found. Using factory settings.");
	else
		print("[SYSTEM] Factory settings not found. Stop the Program!");
		return;
	end
end

print("[SYSTEM] Configuration loaded.");

-------------------------------------------------------
-- System config

--wifi.sta.disconnect();
node.setcpufreq(config.system.sysClock);

--------------------------------------------------------
-- Loading services

dofile("Sensor.lc");
dofile("Network.lc");
dofile("Relay.lc");
dofile("Mqtt.lc");
dofile("Led.lc");

print("[SYSTEM] Modules loaded.");

--------------------------------------------------------
-- Starting services

SensorService.Start(config.sensor);
NetworkService.Start(config.network);
RelayService.Start(config.relay, SensorService.PublicData);
MqttService.Start(config, NetworkService.PublicData, SensorService.PublicData, RelayService.PublicData);
LedService.Start(config.led, MqttService.PublicData, NetworkService.PublicData);

print("[SYSTEM] Services started.");

--------------------------------------------------------
-- Save configuration API
function SaveConfig()
	configApi.SaveConfig("config.user.lua", config);
	node.compile("config.user.lua");
	file.remove("config.user.lua");
	print("[SYSTEM] Configuration saved.");
end

--------------------------------------------------------
-- Finish the initialization
collectgarbage("collect");
