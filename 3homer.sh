#!/bin/sh

module load ngs/samtools/1.9
module load ngs/Homer/4.9
module load ngs/UCSCutils
module load ngs/bedtools2

mkdir -p out


INPUT=`ls -d *.dir | grep "neg"| grep -v "l02"`
SAMPLES=`ls -d *.dir | grep -v "neg"| grep -v "l02"`

INPUTBASE=`echo ${INPUT} | sed -e 's/.dir//g'`
SAMPLESBASE=`echo ${SAMPLES} | sed -e 's/.dir//g'`

echo $INPUTBASE
echo $SAMPLESBASE

for FILEBASE in ${SAMPLESBASE}
do

	sbatch --export=FILEBASE=$FILEBASE,INPUTBASE=$INPUTBASE 3homer.sbatch
done