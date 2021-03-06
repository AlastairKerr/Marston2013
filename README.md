#Verzijlbergen and Marston 2013: 

Paper title : "Shugoshin biases chromosomes for biorientation through condensin recruitment to the pericentromere"
Verzijlbergen et al. eLife 2014;3:e01374. DOI: 10.7554/eLife.01374

The data discussed in this publication have been deposited in NCBI's Gene Expression Omnibus (Edgar et al., 2002) and are accessible through GEO Series accession number  GSE53856 http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE53856 

Edgar R, Domrachev M, Lash AE.
Gene Expression Omnibus: NCBI gene expression and hybridization array data repository
Nucleic Acids Res. 2002 Jan 1;30(1):207-10

#Program Versions:
Mapper: BWA Version: 0.6.1-r104 

Reference Genome: sacCer3 

Removal of duplicate reads: samtools Version: 0.1.16 (r963:234) 

RPM scaling, bedgraph creation and bed intersections:  bedtools v2.16.2 

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
Most of the  data in this repository is intended to be used as an example for the scripts. For the complete set of data please see the GEO identifier GSE53856: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE53856

CENTROMERE.gff : Centromere locations 

rDNA.bed  : excluded region

bedgraphfiles.tgz : bedgraph files to be used with state 2 workflows 

