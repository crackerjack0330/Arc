logFile = "log.txt"
log = io.open(logFile, "a")
paraPath = "InternetGatewayDevice.FAP.PerfMgmt.ConfigNumberOfEntries"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.FAP.PerfMgmt.Config.1.Enable"
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
paraPath = "InternetGatewayDevice.FAP.PerfMgmt.Config.1.URL"
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
paraPath = "InternetGatewayDevice.FAP.PerfMgmt.Config.1.Username"
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
paraPath = "InternetGatewayDevice.FAP.PerfMgmt.Config.1.Password"
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
paraPath = "InternetGatewayDevice.FAP.PerfMgmt.Config.1.PeriodicUploadInterval"
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
paraPath = "InternetGatewayDevice.FAP.PerfMgmt.Config.1.PeriodicUploadTime"
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
