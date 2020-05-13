import arcpy
from arcpy import env
from arcpy.sa import *

root = "C:/Users/QQF/Desktop"

env.workspace = "%s/tmp" % root

scenario = ['rcp6_0_2030s', 'rcp6_0_2050s', 'rcp6_0_2070s', 'rcp8_5_2030s', 'rcp8_5_2050s', 'rcp8_5_2070s']

bios = ['bio_1','bio_2','bio_3','bio_4','bio_5','bio_6','bio_7','bio_8','bio_9','bio_10','bio_11','bio_12','bio_13','bio_14','bio_15','bio_16','bio_17','bio_18','bio_19']

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
