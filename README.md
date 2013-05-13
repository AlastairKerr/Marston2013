#Adele Marston 2013 Paper
Scripts and program version information. Publication information will be updated

#Program Versions:
Mapper: BWA Version: 0.6.1-r104 

Reference Genome: sacCer3 

Removal of duplicate reads: samtools Version: 0.1.16 (r963:234) 

RPM scaling, bedgraph creation and bed intersections:  bedtools v2.16.2 

Peak calling: macs14 1.4.0rc2 20110214 (Valentine)

bedgraph to bigwig conversion: wigToBigWig v 4 (UCSC  utilities)

#Included scripts:
workflow1.sh : initial mapping and processing 

Cen-boxplot.pl : generates boxplot data binned around the centromere 

EveryCen-boxplot.pl: Pairwise fold chage data binned around the centromere

plot-everyboxplot.r: Create the plots from EveryCen-boxplot.pl

ui.R and Server.R : shiny server files for Cen-boxplot.pl data 

#Data files 
CENTROMERE.gff : Centromere locations 

rDNA.bed  : excluded region




