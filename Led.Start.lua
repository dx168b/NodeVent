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
-- LedService.Start() function
gpio.mode(LedService.config.wifiLedPin, gpio.OUTPUT);
LedOff(LedService.config.wifiLedPin, LedService.config.wifiLedPol);

gpio.mode(LedService.config.mqttLedPin, gpio.OUTPUT);
LedOff(LedService.config.mqttLedPin, LedService.config.mqttLedPol);

LedService.LedTimer = tmr.create();
LedService.LedTimer:register(LedService.config.period, tmr.ALARM_AUTO, LedService.LedService);
LedService.LedTimer:start();
print("[LED] Start service.");
collectgarbage("collect");
