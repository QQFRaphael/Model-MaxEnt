#!/bin/sh

#for ii in `ls *.tif`
#do
#	gdal_translate $ii ${ii/tif/nc}
#	echo $ii
#done

for ii in `ls *.nc`
do
	sed -i "1s/^.*.$/f = addfile(\"${ii}\", \"r\")/" uvb.ncl
	name="${ii:6:4}.nc"
	sed -i "13s/^.*.$/out = addfile(\"${name}\",\"c\")/" uvb.ncl

	ncl uvb.ncl
	gdal_translate -of aaigrid netcdf:$name:Band1 ${name/nc/asc}
	echo $ii  
done

rm -rf *.xml
