-------------------------------------------------------
-- HumRelay configuration script

return
{
	network =
	{
		period = 600,
		wifiMode = wifi.PHYMODE_N,
		WiFi_SSID = "Your SSID",
		WiFi_Pass = "YourWiFiPassword",
		hostname = "NodeVent",
		DHCP = 1,
		ip = "192.168.1.41",
		netmask = "255.255.255.0",
		gateway = "192.168.1.1",
		DNS1 = "192.168.1.1",
		DNS2 = "8.8.8.8",
	},
	mqtt =
	{
		period = 2500,
		host = "yourMqttBroker.com",
		port = 1883,
		client = "NodeVent",
		keepAlive = 120,
		secured = false,
		user = "yourUserName",
		password = "yourPassword",
		path = "/HOME/BATHROOM/VENT",
	},
	sensor = 
	{
		period = 5000,
		tempCalibrConst = -1.0,
		humCalibrConst = 1.0,
		bufferLenght = 6,
		errorCount = 3,
		filterUpValue = 5.0,
		filterDownValue = 5.0,
		sensorPin = 1,
	},
	relay = 
	{
		period = 800,
		humStart = 69.5,
		humStop = 68.5,
		mode = 2,
		relayPol = 0,
		relayPin = 2,
	},
	led =
	{
		period = 2000,
		wifiLedPol = 1,
		wifiLedPin = 4,
		mqttLedPol = 0,
		mqttLedPin = 3,
	},
	system =
	{
		sysClock = node.CPU80MHZ,
	},
};
