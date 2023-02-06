#! /bin/bash

# convert bed to fasta
module load ngs/bedtools2/2.27.1 

mkdir out

FILES=`ls *peaks.bed` 
echo ${FILES}
GENOME=`find ~/../../work/project/becbec_003/drosophila_genome -name "*.BDGP6.dna.toplevel.fasta" -size +10`
echo ${GENOME}

for FILE in $FILES
do 
	bedtools getfasta -fi ${GENOME} -bed ${FILE} -fo ${FILE}.fasta

done


FASTA=`find . -name "*.fasta"` 
FILENUMBER=`find . -name "*.fasta" | wc -l` 
arr=($FASTA)

for i in `eval echo {1..$FILENUMBER}`
do
	F=`echo ${FASTA} | cut -d" " -f${i}`

	sbatch --export=f=${F} 2meme.sbatch

done 




