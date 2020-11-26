#!/bin/sh

for scene in 1990-1999 2010-2019
do
rm -rf outputs/$scene
mkdir -p outputs/$scene

#java -Xmx4096m -jar maxent.jar environmentallayers=data/2000-2009 projectionlayers=data/$scene samplesfile=samples/ALL-2000-2009.csv outputdirectory=outputs/$scene responsecurves=false jackknife=false outputfiletype="asc" outputformat=cloglog randomtestpoints=25 writemess=true redoifexists autorun  warnings=false # 30 cross-validate fold
java -Xmx4096m -jar maxent.jar environmentallayers=data/2000-2009 projectionlayers=data/$scene samplesfile=samples/ALL-2000-2009.csv outputdirectory=outputs/$scene responsecurves=false jackknife=false outputfiletype="asc" outputformat=cloglog writemess=false removeduplicates=true maximumiterations=6000 convergencethreshold=0.00001 replicates=15 replicatetype=crossvalidate warnings=false redoifexists autorun

echo "======================= $scene is complete ======================="

done


#for scene in 2000-2009 2010-2019
#do
#rm -rf outputs/$scene
#mkdir -p outputs/$scene
#
##java -Xmx4096m -jar maxent.jar environmentallayers=data/2000-2009 projectionlayers=data/$scene samplesfile=samples/ALL-2000-2009.csv outputdirectory=outputs/$scene responsecurves=false jackknife=false outputfiletype="asc" outputformat=cloglog randomtestpoints=25 writemess=true redoifexists autorun  warnings=false # 30 cross-validate fold
#java -Xmx4096m -jar maxent.jar environmentallayers=data/1990-1999  projectionlayers=data/$scene samplesfile=samples/ALL-1990-1999.csv outputdirectory=outputs/$scene responsecurves=false jackknife=false outputfiletype="asc" outputformat=cloglog writemess=false removeduplicates=true maximumiterations=6000 convergencethreshold=0.00001 replicates=15 replicatetype=crossvalidate warnings=false redoifexists autorun
#
#echo "======================= $scene is complete ======================="
#
#done


#for scene in 2000-2009 1990-1999
#do
#rm -rf outputs/$scene
#mkdir -p outputs/$scene
#
##java -Xmx4096m -jar maxent.jar environmentallayers=data/2000-2009 projectionlayers=data/$scene samplesfile=samples/ALL-2000-2009.csv outputdirectory=outputs/$scene responsecurves=false jackknife=false outputfiletype="asc" outputformat=cloglog randomtestpoints=25 writemess=true redoifexists autorun  warnings=false # 30 cross-validate fold
#java -Xmx4096m -jar maxent.jar environmentallayers=data/2010-2019  projectionlayers=data/$scene samplesfile=samples/ALL-2010-2019.csv outputdirectory=outputs/$scene responsecurves=false jackknife=false outputfiletype="asc" outputformat=cloglog writemess=false removeduplicates=true maximumiterations=6000 convergencethreshold=0.00001 replicates=15 replicatetype=crossvalidate warnings=false redoifexists autorun
#
#echo "======================= $scene is complete ======================="
#
#done