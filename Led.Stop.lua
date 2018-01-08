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
LedOff(LedService.config.wifiLedPin, LedService.config.wifiLedPol);
LedOff(LedService.config.mqttLedPin, LedService.config.mqttLedPol);

LedService.LedTimer:stop();
tmr.unregister(LedService.LedTimer);
LedService.LedTimer = nil;
print("[LED] Stop service.");
collectgarbage("collect");
