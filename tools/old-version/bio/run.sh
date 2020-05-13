#!/bin/sh

for ii in `ls *.nc`
do
	sed -i "1s/^.*.$/f = addfile(\"${ii}\", \"r\")/" combine.ncl
	name="${ii:6:3}_${ii:13:2}.nc"
	sed -i "12s/^.*.$/out = addfile(\"${name}\",\"c\")/" combine.ncl

	ncl combine.ncl
	gdal_translate -of aaigrid netcdf:$name:Band1 ${name/nc/asc}
	echo $ii  
done

rm -rf *.xml
