-------------------------------------------------------
-- 
function LedOn(ledPin, ledPol)
	if(ledPol == 1) then
		gpio.write(ledPin, gpio.LOW);
	else
		gpio.write(ledPin, gpio.HIGH);
	end
end

-------------------------------------------------------
--
function LedOff(ledPin, ledPol)
	if(ledPol == 0) then
		gpio.write(ledPin, gpio.LOW);
	else
		gpio.write(ledPin, gpio.HIGH);
	end
end

-------------------------------------------------------
--
function LedToggle(ledPin, ledPol)
	
end

-------------------------------------------------------
-- LedService.LedService() function
if(LedService.networkData.connected == true) then
	LedOn(LedService.config.wifiLedPin, LedService.config.wifiLedPol);
else
	LedOff(LedService.config.wifiLedPin, LedService.config.wifiLedPol);
end

if(LedService.mqttData.connected == true) then
	LedOn(LedService.config.mqttLedPin, LedService.config.mqttLedPol);
else
	LedOff(LedService.config.mqttLedPin, LedService.config.mqttLedPol);
end

collectgarbage("collect");
