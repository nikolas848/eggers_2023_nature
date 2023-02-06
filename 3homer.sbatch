#!/bin/sh

#SBATCH -J findPeaksHomer   # A single job name for the array
#SBATCH -p slim16                    # Partition
#SBATCH -n 6                         # 6 cores
#SBATCH -N 1                         # one node ?required
#SBATCH -t 0-6:00                    # Running time of 2 hours
#SBATCH --mem 40000                  # Memory request
#SBATCH -o out/findPeaks_%A.out          # Standard output
#SBATCH -e out/findPeaks_%A.err          # Standard error

module load ngs/samtools/1.9
module load ngs/Homer/4.9
module load ngs/UCSCutils

#makeTagDirectory ${INPUTBASE}.dir ${INPUTBASE}.bed -single 
#makeTagDirectory ${FILEBASE}.dir ${FILEBASE}.bed -single 

findPeaks ${FILEBASE}.dir -i ${INPUTBASE}.dir -style factor -F 6 -o ${FILEBASE}.peaks.txt

for TXT in *.txt
do
		TXTBASE=`echo ${TXT} | sed -e 's/.txt//g'`
		pos2bed.pl - ${TXTBASE}.txt > ${TXTBASE}.bed
done

		makeUCSCfile ${FILEBASE}.dir -i ${INPUTBASE}.dir -o ${FILEBASE}.bedgraph
		gunzip ${FILEBASE}.bedgraph.gz
		bedGraphToBigWig ${FILEBASE}.bedgraph /work/project/becbec_003/drosophila_genome/dm6.chromsizes.txt ${FILEBASE}.ipnorm.bw

		#makeUCSCfile ${INPUTBASE}.dir -o ${INPUTBASE}.bedgraph
		#gunzip ${INPUTBASE}.bedgraph.gz
		#bedGraphToBigWig ${INPUTBASE}.bedgraph /work/project/becbec_003/drosophila_genome/dm6.chromsizes.txt ${INPUTBASE}.ipnorm.bw

