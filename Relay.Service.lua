-------------------------------------------------------
-- 
function RelayOn(relayPin, relayPol)
	if(relayPol == 1) then
		gpio.write(relayPin, gpio.LOW);
	else
		gpio.write(relayPin, gpio.HIGH);
	end
end

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
-- Mode setting
if(RelayService.config.mode == 0) then -- Force off mode
	RelayService.PublicData.state = 0;
elseif(RelayService.config.mode == 1) then -- Force on mode
	RelayService.PublicData.state = 1;
else -- Automatic mode
	if(RelayService.sensor.humidity >= RelayService.config.humStart) then
		RelayService.PublicData.state = 1;
	else
		if(RelayService.sensor.humidity <= RelayService.config.humStop) then
			RelayService.PublicData.state = 0;
		end
	end
end

-------------------------------------------------------
-- Switch relay
if(RelayService.oldState ~= RelayService.PublicData.state)then
	RelayService.PublicData.switchCounter = (RelayService.PublicData.switchCounter + 1);
	RelayService.oldState = RelayService.PublicData.state
end

if(RelayService.PublicData.state == 1) then
	RelayOn(RelayService.config.relayPin, RelayService.config.relayPol);
else
	RelayOff(RelayService.config.relayPin, RelayService.config.relayPol);
end
collectgarbage("collect");
