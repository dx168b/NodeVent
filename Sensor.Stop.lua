-- Stop service
SensorService.SensorTimer:stop();
-- Delete service content
tmr.unregister(SensorService.SensorTimer);
SensorService.SensorTimer = nil;
print("[Sensor] Stop service.");
-- Correct this trash
collectgarbage("collect");
