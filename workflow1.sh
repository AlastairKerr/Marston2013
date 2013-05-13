#!/bin/bash
#inpout is a fastq file '$1'
export DB="sacCer3 location"
#bwa to align 
bwa aln $DB $1 -t 20 > $1.sai
bwa samse $DB $1.sai $1  > $2.sam
#sam to bam
samtools -b -S $2.sam > $2.bam
#sort 
samtools sort $2.bam $2-all
#remove 'dupicates'
samtools rmdupse $2-all.bam $2-rmdup.bam
#remove intermediate
rm $2.bam 
#tidy up
gzip -9 $2.sam & 

#remove rDNA region
bedtools intersect -v -a $2-rmdup.bam -b rDNA.bed  > $2-rDNA-rmdup.bam
bedtools intersect -v -a $2-all.bam -b rDNA.bed  > $2-rDNA-all.bam

#Info for rDNA alone
bedtools coverage -abam $2-rmdup.bam -b rDNA.bed -d  > $2-rmdup-rDNA.bed
bedtools coverage -abam $2-all.bam -b rDNA.bed -d  > $2-all-rDNA.bed


### Additional steps 
## To create bigwig in RPM for IGV: 
# genomeCoverageBed -ibam "bamfile"  -bg -scale "1000000/mapped reads" >  file.bg
# wigToBigWig "file.bg" sacCer3.fa.lengths file.bigwig
