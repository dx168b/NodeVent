Project NodeVent

This project required NodeMCU (based on Lua 5.1) firmware for ESP8266 with next libraries:
	MQTT
	GPIO
	DHT22
	File
	Node
	tim
	
Installation:

	1. Copy all ".lua" files from this repository to internal SPI flash of your ESP8266 (see ESPLORER project or other)
	2. Open the terminal (Putty, ESPLORER, etc) and connect to COM port, linked and connected to yor ESP8266
	3. Enter command dofile("install.lua")

Configuration:
	Connect to your device with UART terminal (or ESPLORER) to configure it with commands.
	
	WiFi network:
	
		config.network.WiFi_SSID = "YourSSID"; -- (SSID with quotes!)
		config.network.WiFi_Pass = "YourPassword";
		
		config.network.hostname = "YourDeviceHostName"; -- Host name of your device (optional, default value is "NodeVent")
		
		--if your network are no DHCP, then enter next commands:
		
		config.network.DHCP = 0;
		config.network.ip = "XXX.XXX.XXX.XXX"; -- IP address (with quotes!)
		config.network.netmask = "XXX.XXX.XXX.XXX"; -- your network mask
		config.network.gateway = "XXX.XXX.XXX.XXX"; -- your gateway
		config.network.DNS1 = "XXX.XXX.XXX.XXX"; -- your primary Domain Name Server
		config.network.DNS2 = "XXX.XXX.XXX.XXX"; -- your secondary Domain Name Server (optional)
		
	MQTT server connectivity:
	
		config.mqtt.host = "yourMqttBroker.com"; -- MQTT broker domain or IP address (all with quotes!)
		config.mqtt.port = XXXX; -- port number of MQTT broker (default value is 1883)
		config.mqtt.client = "YourClientId"; -- MQTT client ID (optional, default value is "NodeVent")
		config.mqtt.secured = false; -- type 'true' to enable secured connection and 'false' to disable it. Default value - false
		config.mqtt.user = "yourUserName"; -- username (if required)
		config.mqtt.password = "yourPassword"; -- password (if required)
		config.mqtt.path = "/YOUR/BASE/TOPIC/VENT"; -- base path to subscribe and publish message (default value = "/HOME/BATHROOM/VENT")
		
	Sensor configuration:
	
		config.sensor.tempCalibrConst = 0.0; -- Temperature calibration. For example if sensor value = 10.0 and real temperature = 11.0, tempCalibrConst = (real - sernsor value) = 1.0
		config.sensor.humCalibrConst = 0.0; -- Humidity calibration. For example if sensor value = 50.0 and real humidity = 40.0, humCalibrConst = (real - sernsor value) = -10.0
		config.sensor.bufferLenght = 6; -- Buffer size for average. Buffer size = count of samples.
		config.sensor.errorCount = 3; -- Count of ignoring "false" sensor data, exited from filterUpValue and filterDownValue band. At the end of the count, "false" data will become "true" and the counter will reset.
		config.sensor.filterDownValue = 5.0; -- If current sample of sensor exited down from this band, this sample will be ignoring, and error counter will be incremented.
		config.sensor.filterDownValue = 5.0; -- If current sample of sensor exited up from this band, this sample will be ignoring, and error counter will be incremented.
		config.sensor.sensorPin = 1; -- GPIO pin, where sensor is connected.
	
	Relay configuration:
	
		config.relay.humstart = 69.5; -- humidity level to power on fan.
		config.relay.humstop = 68.5; -- humidity level to power off fan.
		config.relay.mode = 2; -- work mode. 0 - fan always off. 1 - fan always on. 2 - automatic mode (start if the humidity level is higher than the humstart level and stop if lower than the humstop level)
		config.relay.relayPol = 0; -- relay output polarity. Logic level for power on relay.
		config.relay.relayPin = 2; -- GPIO pin for relay control.
	
	LEDs configuration:
	
		config.led.wifiLedPol = 0; -- LED output polarity. Logic level to power on WiFi LED.
		config.led.wifiLedPin = 4; -- GPIO pin for WiFi LED control.
		config.led.mqttLedPol = 1; -- LED output polarity. Logic level to power on MQTT LED.
		config.led.mqttLedPin = 3; -- GPIO pin for MQTT LED control.
	
	After all configuration type SaveConfig(); command to save configuration (to file 'config.user.lc')
	You also can configure the device by editing the file 'config.factory.lua' with notepad before installing or 
	by creating file 'config.user.lua' as copy of file 'config.factory.lua', editing it with notepad and compiling with standalone luac5.1 or 
	downloading your 'config.user.lua' file to device and running node.compile("config.user.lua"); command in device.
	
MQTT topics:
	
	Read-only topics:
	
		$(config.mqtt.path)/TEMP  -- current temperature
		$(config.mqtt.path)/HUM -- current humidity
		$(config.mqtt.path)/HUMSTART -- current fan start level
		$(config.mqtt.path)/HUMSTOP -- current fan stop level
		$(config.mqtt.path)/MODE -- current work mode (0, 1 or 2 - see configuration section)
		$(config.mqtt.path)/STATE -- current fan state (0 - power off, 1 - power on)
		$(config.mqtt.path)/IP -- current IP address assigned to this device
		
	Write-only topics:
	
		$(config.mqtt.path)/CONFIG/HUMSTART -- fan start level. Changes will be apply immediately and not writed to config file.
		$(config.mqtt.path)/CONFIG/HUMSTOP -- fan stop level. Changes will be apply immediately and not writed to config file.
		$(config.mqtt.path)/CONFIG/MODE -- work mode selection. Changes will be apply immediately and not writed to config file.
		$(config.mqtt.path)/CONFIG/SAVE -- publish the '100500' value to save current settings in config file. Device in reply publishing '0' value after accepting this command.

	