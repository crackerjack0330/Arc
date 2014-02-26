logFile = "log.txt"
log = io.open(logFile, "a")
paraPath = "InternetGatewayDevice.PeriodicStatistics.MinSampleInterval"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.PeriodicStatistics.MaxReportSamples"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.PeriodicStatistics.SampleSetNumberOfEntries"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.PeriodicStatistics.SampleSet."
instance = acs.AddObject(paraPath)
if string.len(instance) > 2 then
	log:write("[" .. os.date() .. "]" .. "[AddObject][FAIL]" .. "[" .. paraPath .. "][" .. instance .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[AddObject][PASS]" .. "[" .. paraPath .. "][" .. instance .. "]\n")
	ret = acs.GetParameterValues(paraPath .. instance)
	ret = acs.DeleteObject(paraPath .. instance)
	if ret == "0" then
		log:write("[" .. os.date() .. "]" .. "[DeleteObject][PASS]" .. "[" .. paraPath .. "][" .. instance .. "]\n")
	else
		log:write("[" .. os.date() .. "]" .. "[DeleteObject][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
	end
end
paraPath = "InternetGatewayDevice.PeriodicStatistics.SampleSet.1.Name"
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
paraPath = "InternetGatewayDevice.PeriodicStatistics.SampleSet.1.SampleInterval"
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
paraPath = "InternetGatewayDevice.PeriodicStatistics.SampleSet.1.ReportSamples"
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
paraPath = "InternetGatewayDevice.PeriodicStatistics.SampleSet.1.ReportStartTime"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.PeriodicStatistics.SampleSet.1.ReportEndTime"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.PeriodicStatistics.SampleSet.1.SampleSeconds"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.PeriodicStatistics.SampleSet.1.ParameterNumberOfEntries"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.PeriodicStatistics.SampleSet.1.Parameter."
instance = acs.AddObject(paraPath)
if string.len(instance) > 2 then
	log:write("[" .. os.date() .. "]" .. "[AddObject][FAIL]" .. "[" .. paraPath .. "][" .. instance .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[AddObject][PASS]" .. "[" .. paraPath .. "][" .. instance .. "]\n")
	ret = acs.GetParameterValues(paraPath .. instance)
	ret = acs.DeleteObject(paraPath .. instance)
	if ret == "0" then
		log:write("[" .. os.date() .. "]" .. "[DeleteObject][PASS]" .. "[" .. paraPath .. "][" .. instance .. "]\n")
	else
		log:write("[" .. os.date() .. "]" .. "[DeleteObject][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
	end
end
paraPath = "InternetGatewayDevice.PeriodicStatistics.SampleSet.1.Parameter.1.Reference"
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
paraPath = "InternetGatewayDevice.PeriodicStatistics.SampleSet.1.Parameter.1.SampleSeconds"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.PeriodicStatistics.SampleSet.1.Parameter.1.SuspectData"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.PeriodicStatistics.SampleSet.1.Parameter.1.Values"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
io.close(log)
