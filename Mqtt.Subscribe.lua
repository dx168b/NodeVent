print("[MQTT] Connected to broker.");
MqttService.MqttClient:subscribe(MqttService.config.path.."/CONFIG/HUMSTART", 0, MqttService.SubcribeCallback);
MqttService.MqttClient:subscribe(MqttService.config.path.."/CONFIG/HUMSTOP", 0);
MqttService.MqttClient:subscribe(MqttService.config.path.."/CONFIG/MODE", 0);
MqttService.MqttClient:subscribe(MqttService.config.path.."/CONFIG/SAVE", 0);
collectgarbage("collect");
