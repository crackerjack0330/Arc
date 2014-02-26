try: 
	import xml.etree.cElementTree as ET 
except ImportError: 
	import xml.etree.ElementTree as ET
import sys
import urllib
import datetime
import time

url = 'http://www.broadband-forum.org/cwmp/'
downloadFolder = './Downloads/'
importFileList = []
profileList = []

def importFileRecursive(importFile, flist): 
	print 'parsing file [%s]' %importFile
	# print list
	try:
		with open(downloadFolder + importFile, "r"): 
			pass
	except IOError:
		print 'can not open file [%s], try downloading' %importFile
		urllib.urlretrieve(url + importFile, downloadFolder + importFile)

	try:
		tree = ET.ElementTree(file = downloadFolder + importFile)
	except ET.ParseError:
		# print '[%s] is not a xml file!' %importFile
		flist.remove(importFile)
		return

	for myImport in tree.iter(tag = 'import'): 
		downloadFile = myImport.get('file')
		if downloadFile not in flist: 
			flist.append(downloadFile)
			importFileRecursive(downloadFile, flist)
		else:
			print 'parsing file [%s] done' %importFile


importFileRecursive(sys.argv[1], importFileList)
st = datetime.datetime.fromtimestamp(time.time()).strftime('%Y%m%d%H%M%S')
outputFile = sys.argv[1][0:sys.argv[1].rfind('.xml')] + '_' + st + '.txt'
print outputFile

output = open(outputFile, 'w')
if '098' in sys.argv[1]:
	notUseDM = '181'
	root = 'InternetGatewayDevice.'
	wrongRoot = 'Device.'
else:
	notUseDM = '98'
	root = 'Device.'
	wrongRoot = 'InternetGatewayDevice.'
# print importFileList

for dataModel in importFileList:
	# print 'notUseDM=[%s], dataModel=[%s]' %(notUseDM, dataModel)
	if notUseDM in dataModel:
		continue
	tree = ET.ElementTree(file = downloadFolder + dataModel)
	for myProfile in tree.iter(tag='profile'): 
		nameProfile = myProfile.get('name')
		baseProfile = myProfile.get('base')
		if not nameProfile:
			continue
		print 'Profile ------->[%s]' %nameProfile
		output.write('Profile ------->[' + str(nameProfile) + ']\n')
		# profileList.append(nameProfile)
		for myObject in myProfile.findall('object'):
			refObject = myObject.get('ref')
			reqObject = myObject.get('requirement')
			if refObject.startswith(wrongRoot):
				# print 'root=[%s], object=[%s]' %(root, refObject)
				# profileList.remove(nameProfile)
				break
			elif refObject.startswith(root):
				# print '%s %s' %(refObject, reqObject)
				output.write(refObject + ' ' + reqObject + '\n')
				# output.write(refObject + '\n')
			else:
				# print '%s%s %s' %(root, refObject, reqObject)
				output.write(root + refObject + ' ' + reqObject + '\n')
				# output.write(root + refObject + '\n')
			for myParameter in myObject.findall('parameter'):
				refParameter = myParameter.get('ref')
				reqParameter = myParameter.get('requirement')
				if refObject.startswith(root):
					# print '%s%s %s' %(refObject, refParameter, reqParameter)
					output.write(refObject + refParameter + ' ' + reqParameter + '\n')
					# output.write(refObject + refParameter + '\n')
				else:
					# print '%s%s%s %s' %(root, refObject, refParameter, reqParameter)
					output.write(root + refObject + refParameter + ' ' + reqParameter + '\n')
					# output.write(root + refObject + refParameter + '\n')
		print 'Profile <-------[%s]' %nameProfile
		output.write('Profile <-------[' + str(nameProfile) + ']\n')
output.close()