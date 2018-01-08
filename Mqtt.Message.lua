local msg =
{
	[MqttService.config.path.."/CONFIG/HUMSTART"] = function(data)
		print("[MQTT] /CONFIG/HUMSTART = "..data);
		MqttService.configData.relay.humStart = tonumber(data);
	end,
	[MqttService.config.path.."/CONFIG/HUMSTOP"] = function(data)
		print("[MQTT] /CONFIG/HUMSTOP = "..data);
		MqttService.configData.relay.humStop = tonumber(data);
	end,
	[MqttService.config.path.."/CONFIG/MODE"] = function(data)
		print("[MQTT] /CONFIG/MODE = "..data);
		MqttService.configData.relay.mode = tonumber(data);
	end,
	[MqttService.config.path.."/CONFIG/SAVE"] = function(data)
		print("[MQTT] /CONFIG/SAVE = "..data);
		if(tonumber(data) == 100500) then
			SaveConfig();
			MqttService.MqttClient:publish(MqttService.config.path.."/CONFIG/SAVE", "0", 0, 0);
		elseif(tonumber(data) == 0) then
			print("[MQTT] topic \"/SAVE\" cleared.");
		else
			print("[MQTT] Command not executed. Please, publish value \"100500\"")
		end
	end,
	default = function(Arg, data)
		print("[MQTT] Topic \""..Arg.."\" not recognized. Data = "..data);
	end,
	switch = function(self, switchArg, data)
		if(self[switchArg] ~= nil) then
			self[switchArg](data);
		else
			self.default(switchArg, data);
		end
	end,
};

print("[MQTT] Message received.");
msg:switch(MqttService.rcvTopic, MqttService.rcvData);
collectgarbage("collect");
