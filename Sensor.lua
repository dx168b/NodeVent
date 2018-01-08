-------------------------------------------------------
-- HumRelay sensor service

SensorService = {};
-------------------------------------------------------
-- Public data for using in other services
SensorService.PublicData =
{
	temperature = 0,
	humidity = 0,
	sensorFailCounter = 0,
	sensorRequestCounter = 0,
	tempErrorCounter = 0,
	humErrorCounter = 0,
};

-------------------------------------------------------
-- Local sensors content (filter and overage)

-- For temperature sensor
SensorService.TempSensorContent =
{
	acc = 
	{
		0,
	},
	accCounter = 1,
	accSize = 1,
	
	prevData = 0,
    offsetUp = 5,
    offsetDown = 5,
    errorCount = 3,
    errorCounter = 0,
	totalErrorCounter = 0,
};

-- For humidity sensor
SensorService.HumSensorContent =
{
	acc = 
	{
		0,
	},
	accCounter = 1,
	accSize = 1,
	
	prevData = 0,
    offsetUp = 5,
    offsetDown = 5,
    errorFlag = 0,
    errorCount = 3,
    errorCounter = 0,
	totalErrorCounter = 0,
};



--------------------------------------------------------
-- Main service function (timer callback)
function SensorService.SensorService()
	dofile("Sensor.Service.lc");
end

--------------------------------------------------------
-- Create and start Sensor Service
function SensorService.Start(serviceParam)
	SensorService.config = serviceParam;
	dofile("Sensor.Start.lc");
end

--------------------------------------------------------
-- Stop and delete Sensor Service
function SensorService.Stop()
	dofile("Sensor.Stop.lc");
end

-------------------------------------------------------
-- Exit from module
print("[Sensor] Module loaded.");
collectgarbage("collect");
