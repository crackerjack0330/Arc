logFile = "log.txt"
log = io.open(logFile, "a")
paraPath = "InternetGatewayDevice.Layer2Bridging.MaxBridgeEntries"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.Layer2Bridging.MaxFilterEntries"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.Layer2Bridging.MaxMarkingEntries"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.Layer2Bridging.BridgeNumberOfEntries"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.Layer2Bridging.FilterNumberOfEntries"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.Layer2Bridging.MarkingNumberOfEntries"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.Layer2Bridging.AvailableInterfaceNumberOfEntries"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.Layer2Bridging.Bridge."
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Bridge.1.BridgeKey"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.Layer2Bridging.Bridge.1.BridgeEnable"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Bridge.1.BridgeStatus"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.Layer2Bridging.Bridge.1.BridgeName"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Bridge.1.VLANID"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Filter."
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Filter.1.FilterKey"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.Layer2Bridging.Filter.1.FilterEnable"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Filter.1.FilterStatus"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.Layer2Bridging.Filter.1.FilterBridgeReference"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Filter.1.ExclusivityOrder"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Filter.1.FilterInterface"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Filter.1.VLANIDFilter"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Filter.1.AdmitOnlyVLANTagged"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Filter.1.EthertypeFilterList"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Filter.1.EthertypeFilterExclude"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Filter.1.SourceMACAddressFilterList"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Filter.1.SourceMACAddressFilterExclude"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Filter.1.DestMACAddressFilterList"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Filter.1.DestMACAddressFilterExclude"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Marking."
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Marking.1.MarkingKey"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.Layer2Bridging.Marking.1.MarkingEnable"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Marking.1.MarkingStatus"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.Layer2Bridging.Marking.1.MarkingBridgeReference"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Marking.1.MarkingInterface"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Marking.1.VLANIDUntag"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Marking.1.VLANIDMark"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Marking.1.EthernetPriorityMark"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.Marking.1.EthernetPriorityOverride"
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
paraPath = "InternetGatewayDevice.Layer2Bridging.AvailableInterface.1.AvailableInterfaceKey"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.Layer2Bridging.AvailableInterface.1.InterfaceType"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
paraPath = "InternetGatewayDevice.Layer2Bridging.AvailableInterface.1.InterfaceReference"
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\n")
end
io.close(log)
