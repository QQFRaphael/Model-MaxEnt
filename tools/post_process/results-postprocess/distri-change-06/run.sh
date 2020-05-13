#!/bin/sh

# scenes2 is the base

scenes1=(ME  ML  SE  SL  VSE  WE  WL)
scenes2=(neural neural neural neural neural neural neural)

for idx in {0..6}
do
	sed -i "6s/^.*.$/scene1 = \"${scenes1[$idx]}\"/" change.ncl
	sed -i "7s/^.*.$/scene2 = \"${scenes2[$idx]}\"/" change.ncl
	ncl change.ncl
done
