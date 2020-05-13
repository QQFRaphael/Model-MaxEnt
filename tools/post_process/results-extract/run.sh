#!/bin/sh

for scene in  ME  ML  SE  SL  VSE  WE  WL
do
	cp ../results/$scene/Tetrastigma_hemsleyanum_avg.asc ./neural.asc
	cp ../results/$scene/Tetrastigma_hemsleyanum_${scene}_avg.asc ./${scene}.asc
	gdal_translate  neural.asc neural.nc
	gdal_translate  ${scene}.asc ${scene}.nc
done
