-------------------------------------------------------
--
function RelayOff(relayPin, relayPol)
	if(relayPol == 0) then
		gpio.write(relayPin, gpio.LOW);
	else
		gpio.write(relayPin, gpio.HIGH);
	end
end

-------------------------------------------------------
-- RelayService.Start function
gpio.mode(RelayService.config.relayPin, gpio.OUTPUT);
RelayOff(RelayService.config.relayPin, RelayService.config.relayPol);

RelayService.RelayTimer = tmr.create();
RelayService.RelayTimer:register(RelayService.config.period, tmr.ALARM_AUTO, RelayService.RelayService);
RelayService.RelayTimer:start();
print("[Relay] Start service.");
collectgarbage("collect");
