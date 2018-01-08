-- Config filters
SensorService.TempSensorContent.offsetUp = SensorService.config.filterUpValue;
SensorService.TempSensorContent.offsetDown = SensorService.config.filterDownValue;
SensorService.HumSensorContent.offsetUp = SensorService.config.filterUpValue;
SensorService.HumSensorContent.offsetDown = SensorService.config.filterDownValue;

-- Config error counters
SensorService.TempSensorContent.errorCount = SensorService.config.errorCount;
SensorService.HumSensorContent.errorCount = SensorService.config.errorCount;

-- Config and reset buffers
SensorService.TempSensorContent.accSize = SensorService.config.bufferLenght;
SensorService.HumSensorContent.accSize = SensorService.config.bufferLenght;
for i = 1, SensorService.TempSensorContent.accSize, 1 do
	SensorService.TempSensorContent.acc[i] = 0;
end
for i = 1, SensorService.HumSensorContent.accSize, 1 do
	SensorService.HumSensorContent.acc[i] = 0;
end

-- Create and start service
SensorService.SensorTimer = tmr.create();
SensorService.SensorTimer:register(SensorService.config.period, tmr.ALARM_AUTO, SensorService.SensorService);
SensorService.SensorTimer:start();
print("[Sensor] Start service.");
collectgarbage("collect");
