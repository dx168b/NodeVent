--------------------------------------------------------
-- Filtering and overaging sensor data 
-- (govnokitayskie govnosensory AM2302... bljad!)
function ConvertAndFilterSensorData(sensorTable, inputData)
    if(sensorTable.firstTime == nil) then
        sensorTable.prevData = inputData;
        sensorTable.firstTime = 1;
		sensorTable.totalErrorCounter = 0;
    else
        if((inputData > (sensorTable.prevData + sensorTable.offsetUp)) or (inputData < (sensorTable.prevData - sensorTable.offsetDown)))
        then
			sensorTable.totalErrorCounter = (sensorTable.totalErrorCounter + 1);
			if(sensorTable.errorFlag == 0) then
				sensorTable.errorFlag = 1;
				sensorTable.errorCounter = sensorTable.errorCount;
				inputData = sensorTable.prevData;
			else
				sensorTable.errorCounter = (sensorTable.errorCounter - 1);
				
				if(sensorTable.errorCounter <= 0)then
					sensorTable.errorFlag = 0;
					sensorTable.prevData = inputData;
				else
					inputData = sensorTable.prevData;
				end
			end
        else
            sensorTable.prevData = inputData;
			sensorTable.errorFlag = 0;
        end
    end
	
	sensorTable.acc[sensorTable.accCounter] = inputData;
	
	if(sensorTable.accCounter >= sensorTable.accSize)then
		sensorTable.accCounter = 1;
	else
		sensorTable.accCounter = sensorTable.accCounter + 1;
	end
	
	local tmpData = 0;
	
	for i = sensorTable.accCounter, sensorTable.accSize, 1 do
		tmpData = tmpData + sensorTable.acc[i];
		--print("F1 - "..i);
	end
	
	for i = 1, (sensorTable.accCounter - 1), 1 do
		tmpData = tmpData + sensorTable.acc[i];
		--print("F2 - "..i);
	end
	
	tmpData = tmpData / sensorTable.accSize;
	
    return tmpData;
end

local status, temp, humi = dht.read(SensorService.config.sensorPin);

if(status == dht.OK) then
	temp = (temp + SensorService.config.tempCalibrConst); -- Calibrating temperature
    SensorService.PublicData.temperature = tonumber(string.format("%1.2f", ConvertAndFilterSensorData(SensorService.TempSensorContent, temp)));
	print("[Sensor] Temp - "..SensorService.PublicData.temperature.." C");
	
	humi = (humi + SensorService.config.humCalibrConst); -- Calibrating humidity
    SensorService.PublicData.humidity = tonumber(string.format("%1.2f", ConvertAndFilterSensorData(SensorService.HumSensorContent, humi)));
	print("[Sensor] Hum  - "..SensorService.PublicData.humidity.." %");
	
	SensorService.PublicData.tempErrorCounter = SensorService.TempSensorContent.totalErrorCounter;
	SensorService.PublicData.humErrorCounter = SensorService.HumSensorContent.totalErrorCounter;
	SensorService.PublicData.sensorRequestCounter = (SensorService.PublicData.sensorRequestCounter + 1);
else
	SensorService.PublicData.sensorFailCounter = (SensorService.PublicData.sensorFailCounter + 1);
	print("[Sensor] Sensor fail!");
end
collectgarbage("collect");
