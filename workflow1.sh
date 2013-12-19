#!/bin/bash

# Updates to work with samtools Version: 0.1.16 (r963:234)
# and bwa Version: 0.6.1-r104 
# and bedtools v2.16.2



#input is a fastq file '$1'
export DB=/homes/genomes/s.cerevisiae/sacCer3/bwa_indexes/sacCer3

#bwa to align 
echo "## Aligning using bwa" 
bwa aln $DB $1 -t 40 > $1.sai
bwa samse $DB $1.sai $1  > $2.sam

#sam to bam
echo "## Converting sam to bam, and remove unmapped reads" 
samtools view -h -b -S -F 4 $2.sam > $2.bam

#sort 
echo "## sorting bam"
samtools sort -m 500000000000  $2.bam $2-all

#remove 'dupicates'
echo "## removing duplicates" 
samtools rmdup -s $2-all.bam $2-rmdup.bam


#remove intermediate  #tidy up
echo "## remove intermediate & tidy up"
rm $2.bam 
gzip -9 $2.sam & 

#remove rDNA region
echo "## intersecting"
bedtools intersect -v -abam $2-rmdup.bam -b rDNA.bed  > $2-rDNA-rmdup.bam
bedtools intersect -v -abam $2-all.bam -b rDNA.bed  > $2-rDNA-all.bam

#Info for rDNA alone

#this was ignored as region nr saturated with reads
echo "## generating coverage bed"
bedtools coverage -abam $2-rmdup.bam -b rDNA.bed -d  > $2-rmdup-rDNA.bed

#This used in figures 
bedtools coverage -abam $2-all.bam -b rDNA.bed -d  > $2-all-rDNA.bed


### Additional steps 
## To create bigwig in RPM for IGV: 
# genomeCoverageBed -ibam "bamfile"  -bg -scale "1000000/mapped reads" >  file.bg
# wigToBigWig "file.bg" sacCer3.fa.lengths file.bigwig
