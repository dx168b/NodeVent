--------------------------------------------------
-- NodeVent installer

-- Compile scripts
print("[INSTALL] Compiling scripts...");

node.compile("confman.lua");
print("[INSTALL] Configuration Manager Lib (confman) compiled.");

node.compile("config.factory.lua");
print("[INSTALL] Factory configuration compiled.");

node.compile("Sensor.lua");
node.compile("Sensor.Service.lua");
node.compile("Sensor.Start.lua");
node.compile("Sensor.Stop.lua");
print("[INSTALL] Sensor service compiled.");

node.compile("Network.lua");
node.compile("Network.Service.lua");
node.compile("Network.Start.lua");
node.compile("Network.Stop.lua");
print("[INSTALL] Network service compiled.");

node.compile("Relay.lua");
node.compile("Relay.Service.lua");
node.compile("Relay.Start.lua");
node.compile("Relay.Stop.lua");
print("[INSTALL] Relay service compiled.");

node.compile("Mqtt.lua");
node.compile("Mqtt.Service.lua");
node.compile("Mqtt.Subscribe.lua");
node.compile("Mqtt.Message.lua");
node.compile("Mqtt.Start.lua");
node.compile("Mqtt.Stop.lua");
print("[INSTALL] MQTT service compiled.");

node.compile("Led.lua");
node.compile("Led.Service.lua");
node.compile("Led.Start.lua");
node.compile("Led.Stop.lua");
print("[INSTALL] LED service compiled.");

-- Removing files
print("[INSTALL] Removing scripts.");

file.remove("confman.lua");
print("[INSTALL] Configuration Manager Lib (confman) removed.");

file.remove("config.factory.lua");
print("[INSTALL] Factory configuration removed.");

file.remove("Sensor.lua");
file.remove("Sensor.Service.lua");
file.remove("Sensor.Start.lua");
file.remove("Sensor.Stop.lua");
print("[INSTALL] Sensor service scripts removed.");

file.remove("Network.lua");
file.remove("Network.Service.lua");
file.remove("Network.Start.lua");
file.remove("Network.Stop.lua");
print("[INSTALL] Network service scripts removed.");

file.remove("Relay.lua");
file.remove("Relay.Service.lua");
file.remove("Relay.Start.lua");
file.remove("Relay.Stop.lua");
print("[INSTALL] Relay service scripts removed.");

file.remove("Mqtt.lua");
file.remove("Mqtt.Service.lua");
file.remove("Mqtt.Subscribe.lua");
file.remove("Mqtt.Message.lua");
file.remove("Mqtt.Start.lua");
file.remove("Mqtt.Stop.lua");
print("[INSTALL] MQTT service scripts removed.");

file.remove("Led.lua");
file.remove("Led.Service.lua");
file.remove("Led.Start.lua");
file.remove("Led.Stop.lua");
print("[INSTALL] LED service scripts removed.");

-- Rename files
print("[INSTALL] Setting-up \"init.lua\"");
file.rename("install-init.lua", "init.lua");

-- Reboot
print("[INSTALL] Install completed. Restarting the MCU.");
node.restart();
