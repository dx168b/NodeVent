-------------------------------------------------------
-- HumRelay LED service module

LedService = {};

-------------------------------------------------------
-- Led service variables

-------------------------------------------------------
-- LED Service callback (timer callback)
function LedService.LedService()
	dofile("Led.Service.lc");
end

--------------------------------------------------------
-- LED service start
function LedService.Start(serviceParam, mqttData, networkData)
	LedService.config = serviceParam;
	LedService.mqttData = mqttData;
	LedService.networkData = networkData;
	dofile("Led.Start.lc");
end

--------------------------------------------------------
-- LED service stop
function LedService.Stop()
	dofile("Led.Stop.lc");
end

--------------------------------------------------------
-- Exit from module
print("[LED] Module loaded.");
collectgarbage("collect");
