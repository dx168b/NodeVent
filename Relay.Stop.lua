-------------------------------------------------------
-- Relay stop function
function RelayOff(relayPin, relayPol)
	if(relayPol == 0) then
		gpio.write(relayPin, gpio.LOW);
	else
		gpio.write(relayPin, gpio.HIGH);
	end
end

-------------------------------------------------------
-- RelayService.Stop function
gpio.mode(RelayService.config.relayPin, gpio.INPUT);
RelayOff(RelayService.config.relayPin, RelayService.config.relayPol);
RelayService.RelayTimer:stop();
tmr.unregister(RelayService.RelayTimer);
RelayService.RelayTimer = nil;
print("[Relay] Stop service.");
collectgarbage("collect");
