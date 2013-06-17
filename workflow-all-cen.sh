#!/bin/bash
#Create tab delimited files from bedgraph files 
for file in *bg 
do
./Cen-boxplot.pl  $file
done
#R code to plot files 
R --no-save < AllCen.r
