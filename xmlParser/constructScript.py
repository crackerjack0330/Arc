import sys
import re
from subprocess import call

profileList = []
find = 0
inputFile = open(sys.argv[1])

for line in inputFile:
	match = re.search('^Profile\s([-><$]+).(.+).$', line)
	if match:
		if match.group(1) == '------->':
			# print 'find -------> new profile for [%s]' %match.group(2)
			for subList in profileList:
				if subList[0] == match.group(2):
					# print '[%s] is in profileList' %match.group(2)
					find = 1
					break
			if find == 0:
				tmpList = []
				tmpList.append(match.group(2))
		if match.group(1) == '<-------':
			# print 'find <------- end profile for [%s]' %match.group(2)
			# print '===================='
			# print tmpList
			# print '===================='
			if find == 1:
				find = 0
			else:
				profileList.append(tmpList)
		continue
	if find == 1:
		if line not in subList:
			subList.append(line)
	else:
		tmpList.append(line)

profileList.sort()
subFolder = './Scripts/' + sys.argv[1][0:sys.argv[1].rfind('.txt')] + '/'
mkdir = 'mkdir ' + subFolder
call(mkdir, shell=True)
section = 0

for profile in profileList:
	outputfile = open(subFolder + profile[0].replace(':', '-') + '.lua', 'w')
	outputfile.write('logFile = "log.txt"\n')
	outputfile.write('log = io.open(logFile, "a")\n')
	for line in profile[1:]:
		lineList = line[:-1].split(' ')
		if lineList[1] == 'present':
			pass
		elif lineList[1] == 'notSpecified':
			pass
		elif lineList[1] == 'createDelete':
			path = lineList[0][:-4].replace('{i}', '1')
			str = 'paraPath = "' + path + '"'
			outputfile.write(str)
			str = '''
instance = acs.AddObject(paraPath)
if string.len(instance) > 2 then
	log:write("[" .. os.date() .. "]" .. "[AddObject][FAIL]" .. "[" .. paraPath .. "][" .. instance .. "]\\n")
else
	log:write("[" .. os.date() .. "]" .. "[AddObject][PASS]" .. "[" .. paraPath .. "][" .. instance .. "]\\n")
	ret = acs.GetParameterValues(paraPath .. instance)
	ret = acs.DeleteObject(paraPath .. instance)
	if ret == "0" then
		log:write("[" .. os.date() .. "]" .. "[DeleteObject][PASS]" .. "[" .. paraPath .. "][" .. instance .. "]\\n")
	else
		log:write("[" .. os.date() .. "]" .. "[DeleteObject][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\\n")
	end
end\n'''
			outputfile.write(str)
		elif lineList[1] == 'readOnly':
			path = lineList[0].replace('{i}', '1')
			str = 'paraPath = "' + path + '"'
			outputfile.write(str)
			str = '''
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\\n")
end\n'''
			outputfile.write(str)
		elif lineList[1] == 'readWrite':
			path = lineList[0].replace('{i}', '1')
			str = 'paraPath = "' + path + '"'
			outputfile.write(str)
			str = '''
ret = acs.GetParameterValues(paraPath)
acs.execute()
if ret == "9005" then
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "]\\n")
else
	log:write("[" .. os.date() .. "]" .. "[GetParameterValues][PASS]" .. "[" .. paraPath .. "][" .. ret .. "]\\n")
	acs.SetParameterValues(paraPath, ret)
	acs.execute()
	retE = acs.GetError()
	if retE == "0" then
		log:write("[" .. os.date() .. "]" .. "[SetParameterValues][PASS]" .. "[" .. paraPath .. "][0]\\n")
	else
		log:write("[" .. os.date() .. "]" .. "[SetParameterValues][FAIL]" .. "[" .. paraPath .. "][" .. ret .. "][" .. retE .. "]\\n")
	end
end\n'''
			outputfile.write(str)
		# print lineList
	outputfile.write('io.close(log)\n')
	outputfile.close()
