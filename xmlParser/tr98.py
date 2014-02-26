try : 
	import xml.etree.cElementTree as ET 
except ImportError : 
	import xml.etree.ElementTree as ET

tree = ET.ElementTree(file = 'tr-098-1-0-0.xml')
#tree = ET.ElementTree(file = 'tr-069-1-0-0.xml')
print tree.getroot()

root = tree.getroot()
print root.tag, root.attrib

for child_of_root in root : 
	print child_of_root.tag, child_of_root.attrib

for myObject in tree.iter(tag = 'object') : 
	accessObject = myObject.get('access')
	baseObject = myObject.get('base')
	nameObject = myObject.get('name')
	if baseObject : 
		for myParameter in myObject.findall('parameter') : 
			accessParameter = myParameter.get('access')
			baseParameter = myParameter.get('base')
			nameParameter = myParameter.get('name')
			if baseParameter :
				print '[%s%s][%s]' %(baseObject, baseParameter, accessParameter)
			elif nameParameter :
				print '[%s%s][%s]' %(baseObject, nameParameter, accessParameter)
	elif nameObject : 
		for myParameter in myObject.findall('parameter') : 
			accessParameter = myParameter.get('access')
			baseParameter = myParameter.get('base')
			nameParameter = myParameter.get('name')
			if baseParameter :
				print '[%s%s][%s]' %(nameObject, baseParameter, accessParameter)
			elif nameParameter :
				print '[%s%s][%s]' %(nameObject, nameParameter, accessParameter)