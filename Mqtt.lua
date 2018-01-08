-------------------------------------------------------
-- HumRelay mqtt service module

MqttService = {};

-------------------------------------------------------
-- MQTT flags
MqttService.netOldFlag = false;

-------------------------------------------------------
-- MQTT flags
MqttService.PublicData = 
{
	connected = false,
};

-------------------------------------------------------
--
function MqttService.SubcribeCallback(client)
	print("[MQTT] Topic subscribed.");
end
-------------------------------------------------------
-- MQTT Connect callback (mqtt callback)
function MqttService.ConnectCallback(client)
	dofile("Mqtt.Subscribe.lc");
	MqttService.PublicData.connected = true;
end

-------------------------------------------------------
-- MQTT Disconnect callback (mqtt callback)
function MqttService.DisconnectCallback(client)
	MqttService.PublicData.connected = false;
	print("[MQTT] Disconnected from broker.");
end

-------------------------------------------------------
-- MQTT Message callback (mqtt callback)
function MqttService.GetMessageCallback(client, topic, data)
	MqttService.rcvClient = client;
	MqttService.rcvTopic = topic;
	MqttService.rcvData = data;
	dofile("Mqtt.Message.lc");
end

-------------------------------------------------------
-- MQTT publish callback
function MqttService.PublishCallback(client)
	--print("[MQTT] Data published.");
end

-------------------------------------------------------
-- MQTT Service callback (timer callback)
function MqttService.MqttService()
	dofile("Mqtt.Service.lc");
end

--------------------------------------------------------
-- Mqtt service start
function MqttService.Start(serviceParam, networkData, sensorData, relayData)
	MqttService.config = serviceParam.mqtt;
	MqttService.configData = serviceParam;
	MqttService.networkData = networkData;
	MqttService.sensorData = sensorData;
	MqttService.relayData = relayData;
	dofile("Mqtt.Start.lc");
end

--------------------------------------------------------
-- MQTT service stop
function MqttService.Stop()
	dofile("Mqtt.Stop.lc");
end

--------------------------------------------------------
-- Exit from module
print("[MQTT] Module loaded.");
collectgarbage("collect");
