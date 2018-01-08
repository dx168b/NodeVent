MqttService.MqttTimer = tmr.create();
MqttService.MqttTimer:register(MqttService.config.period, tmr.ALARM_AUTO, MqttService.MqttService);
MqttService.MqttTimer:start();
print("[MQTT] Start service.");
collectgarbage("collect");
