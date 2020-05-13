import arcpy
from arcpy import env
from arcpy.sa import *

root = "C:/Users/QQF/Desktop"

env.workspace = "%s/tmp" % root

scenario = ['static']

bios = ['alt','gdd','soil_carbon','soil_ph','UVB1','UVB2','UVB3','UVB4','UVB5','UVB6']

for scene in scenario:
	for bio in bios:
		infile = "%s/maxentdata/%s/%s.asc" % (root, scene, bio)
		maskfile = "%s/bouder/bou1_4p.shp" % root
		outfile = "%s/maskout/%s/%s" % (root, scene, bio)
		outExtractByMask = ExtractByMask(infile, maskfile)
		outExtractByMask.save(outfile)
		print("==============%s/%s==============" % (scene, bio))
	print("-----------------%s complete!-----------------" % scene)

print("All complete!!!")
