#!/bin/sh

scenes=(ME  ML  SE  SL  VSE  WE  WL neural)
index=(a b c d e f g h i j k)

for idx in {0..7}
do
	sed -i "7s/^.*.$/scene = \"${scenes[$idx]}\"/" rcp.ncl
	sed -i "8s/^.*.$/index = \"(${index[$idx]}) \"/" rcp.ncl
	ncl rcp.ncl
done
