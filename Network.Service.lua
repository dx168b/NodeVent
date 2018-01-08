-------------------------------------------------------
--

local wifiStatus = wifi.sta.status();
	
if(wifiStatus == wifi.STA_WRONGPWD) then
	NetworkService.PublicData.connected = false;
	if(wifiStatus ~= NetworkService.wifiOldStatus) then
		NetworkService.wifiOldStatus = wifiStatus;
		print("[Network] Wrong password!");
		NetworkService.Stop();
	end
elseif(wifiStatus == wifi.STA_APNOTFOUND) then
	NetworkService.PublicData.connected = false;
	if(wifiStatus ~= NetworkService.wifiOldStatus) then
		NetworkService.wifiOldStatus = wifiStatus;
		print("[Network] Access point not found!");
	end
elseif(wifiStatus == wifi.STA_FAIL) then
	NetworkService.PublicData.connected = false;
	if(wifiStatus ~= NetworkService.wifiOldStatus) then
		NetworkService.wifiOldStatus = wifiStatus;
		print("[Network] Connection failed!");
	end
elseif(wifiStatus == wifi.STA_CONNECTING) then
	NetworkService.PublicData.connected = false;
	if(wifiStatus ~= NetworkService.wifiOldStatus) then
		NetworkService.wifiOldStatus = wifiStatus;
		print("[Network] Connecting...");
	end
elseif(wifiStatus == wifi.STA_GOTIP) then
	local netIp, netMsk, gateWay = wifi.sta.getip();
	if(netIp ~= nil) then
		NetworkService.PublicData.ip = netIp;
		NetworkService.PublicData.netmask = netMsk;
		NetworkService.PublicData.gateway = gateWay;
		NetworkService.PublicData.broadcast = wifi.sta.getbroadcast();
		NetworkService.PublicData.connected = true;
		NetworkService.PublicData.rssi = wifi.sta.getrssi();
		
		local wifiConf = wifi.sta.getconfig(true);
		NetworkService.PublicData.ssid = wifiConf.ssid;
		
		if(wifiConf.bssid == nil) then
			NetworkService.PublicData.bssid = "none";
		else
			NetworkService.PublicData.bssid = wifiConf.bssid;
		end
		
		if(wifiConf.pwd == nil) then
			NetworkService.PublicData.pwd = "none";
		else
			NetworkService.PublicData.pwd = wifiConf.pwd;
		end
		
		if(wifiStatus ~= NetworkService.wifiOldStatus) then
			NetworkService.wifiOldStatus = wifiStatus;
			print("[Network] IP = "..NetworkService.PublicData.ip);
			print("[Network] MASK = "..NetworkService.PublicData.netmask);
			print("[Network] GATE = "..NetworkService.PublicData.gateway);
			print("[Network] BROAD = "..NetworkService.PublicData.broadcast);
			print("[Network] SSID = "..NetworkService.PublicData.ssid);
			print("[Network] BSSID = "..NetworkService.PublicData.bssid);
			print("[Network] PASSW = "..NetworkService.PublicData.pwd);
			print("[Network] RSSI = "..NetworkService.PublicData.rssi);
		end
	else
		NetworkService.PublicData.ip = "0.0.0.0";
		NetworkService.PublicData.netmask = "0.0.0.0";
		NetworkService.PublicData.gateway = "0.0.0.0";
		NetworkService.PublicData.connected = false;
		if(wifiStatus ~= NetworkService.wifiOldStatus) then
			NetworkService.wifiOldStatus = wifiStatus;
			print("[Network] IP address not set!");
		end
	end
else
	NetworkService.PublicData.connected = false;
	if(wifiStatus ~= NetworkService.wifiOldStatus) then
		NetworkService.wifiOldStatus = wifiStatus;
		print("[Network] Disconnected.");
		--NetworkService.Stop();
	end
end

collectgarbage("collect");
