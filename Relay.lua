-------------------------------------------------------
-- HumRelay relay script

RelayService = {};

-------------------------------------------------------
-- Network public data
RelayService.PublicData =
{
	state = 0,
	switchCounter = 0,
};

-------------------------------------------------------
-- Relay service private data
RelayService.oldState = 0;

-------------------------------------------------------
-- Relay service function (timer callback)
function RelayService.RelayService()
	dofile("Relay.Service.lc");
end

--------------------------------------------------------
-- Start relay service
function RelayService.Start(serviceParam, sensorData)
	RelayService.config = serviceParam;
	RelayService.sensor = sensorData;
	dofile("Relay.Start.lc");
end

--------------------------------------------------------
-- Stop relay service
function RelayService.Stop()
	dofile("Relay.Stop.lc");
end

-------------------------------------------------------
-- Exit from module
print("[Relay] Module loaded.");
collectgarbage("collect");
