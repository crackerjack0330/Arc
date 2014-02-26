logFile = "log.txt"
log = io.open(logFile, "a")
paraPath = "InternetGatewayDevice.DeviceInfo.TemperatureStatus.TemperatureSensor.1.PollingInterval"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
	acs.SetParameterValues(paraPath, ret)
	acs.execute()
	retE = acs.GetError()
	if retE == "0" then
		log:write("[" .. os.date() .. "]" .. "[SetParameterValues][PASS]" .. "[" .. paraPath .. "][0]\n")
	else
		log:write("[" .. os.date() .. "]" .. "[SetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "][" .. retE .. "]\n")
	end
end
io.close(log)
