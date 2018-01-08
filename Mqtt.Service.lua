if(MqttService.networkData.connected ~= MqttService.netOldFlag) then
	MqttService.netOldFlag = MqttService.networkData.connected;
	if(MqttService.networkData.connected == true) then
		print("[MQTT] Run service");
		MqttService.MqttClient = mqtt.Client(MqttService.config.client, MqttService.config.keepAlive, MqttService.config.user, MqttService.config.password);
		MqttService.MqttClient:on("connect", MqttService.ConnectCallback);
		MqttService.MqttClient:on("offline", MqttService.DisconnectCallback);
		MqttService.MqttClient:on("message", MqttService.GetMessageCallback);
	else
		MqttService.MqttClient:close();
		print("[MQTT] Idle service");
	end
end

if((MqttService.PublicData.connected == false) and (MqttService.networkData.connected == true)) then
	MqttService.MqttClient:connect(MqttService.config.host, MqttService.config.port, MqttService.config.secured, 1);
end

if(MqttService.PublicData.connected == true) then
	MqttService.MqttClient:publish(MqttService.config.path.."/TEMP", MqttService.sensorData.temperature, 0, 0, MqttService.PublishCallback);
	MqttService.MqttClient:publish(MqttService.config.path.."/HUM", MqttService.sensorData.humidity, 0, 0);
	MqttService.MqttClient:publish(MqttService.config.path.."/STATE", MqttService.relayData.state, 0, 0);
	MqttService.MqttClient:publish(MqttService.config.path.."/HUMSTART", MqttService.configData.relay.humStart, 0, 0);
	MqttService.MqttClient:publish(MqttService.config.path.."/HUMSTOP", MqttService.configData.relay.humStop, 0, 0);
	MqttService.MqttClient:publish(MqttService.config.path.."/MODE", MqttService.configData.relay.mode, 0, 0);
	MqttService.MqttClient:publish(MqttService.config.path.."/IP", MqttService.networkData.ip, 0, 0);
end
collectgarbage("collect");
