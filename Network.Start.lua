-- Network initialization

wifi.sta.setaplimit(1);

if(wifi.getmode() ~= wifi.STATION) then
	wifi.setmode(wifi.STATION);
	print("[Network] WiFi mode = "..wifi.getmode());
end

if(wifi.sta.gethostname() ~= NetworkService.config.hostname) then
	wifi.sta.sethostname(NetworkService.config.hostname);
end

if(wifi.getphymode() ~= NetworkService.config.wifiMode) then
	wifi.setphymode(NetworkService.config.wifiMode);
end

NetworkService.WiFiConfig = 
{
	ssid = NetworkService.config.WiFi_SSID,
	pwd = NetworkService.config.WiFi_Pass,
	auto = true,
	save = false,
};

if(wifi.sta.config(NetworkService.WiFiConfig) == false) then
	print("[Network] WiFi configuration not changed!");
end

if(NetworkService.config.DHCP == 0) then
	local ipConfig =
	{
		ip = NetworkService.config.ip,
		netmask = NetworkService.config.netmask,
		gateway = NetworkService.config.gateway,
	};
	wifi.sta.setip(ipConfig);
end

wifi.sta.connect();

NetworkService.NetworkTimer = tmr.create();
NetworkService.NetworkTimer:register(NetworkService.config.period, tmr.ALARM_AUTO, NetworkService.NetworkService);
NetworkService.NetworkTimer:start();
print("[Network] Start service.");
collectgarbage("collect");
