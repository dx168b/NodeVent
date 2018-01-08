MqttService.MqttTimer:stop();
tmr.unregister(MqttService.MqttTimer);
MqttService.MqttTimer = nil;
print("[MQTT] Stop service.");
collectgarbage("collect");
