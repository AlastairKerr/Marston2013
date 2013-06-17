#Adele Marston 2013 Paper "Shugoshin biases chromosomes for biorientation through condensin recruitment to the pericentromere"

Scripts and program version information. 

Publication information will be updated


#Program Versions:
Mapper: BWA Version: 0.6.1-r104 

Reference Genome: sacCer3 

Removal of duplicate reads: samtools Version: 0.1.16 (r963:234) 

RPM scaling, bedgraph creation and bed intersections:  bedtools v2.16.2 

Peak calling: macs14 1.4.0rc2 20110214 (Valentine)

bedgraph to bigwig conversion: wigToBigWig v 4 (UCSC  utilities)


# Included scripts:

## Workflows: 
workflow1.sh : initial mapping and processing 

workflow-each-cen.sh : Plot data for each centromere

workflow-all-cen.sh  : Plot all centromeres together as a boxplot per window


## Scripts

Cen-boxplot.pl : generates boxplot data binned around the centromere 

EveryCen-boxplot.pl: Pairwise fold chage data binned around the centromere

plot-everyboxplot.r: Create the plots from EveryCen-boxplot.pl

AllCen.r  : R script for plotting Cen-boxplot.pl





#Data files 

fastq files or bam files will be added to GEO or ArrayExpress: Will edit when I have an identifier

CENTROMERE.gff : Centromere locations 

rDNA.bed  : excluded region

bedgraphfiles.tgz : bedgraph files to be used with state 2 workflows 

