#!/bin/bash

#Create tab delimited files from bedgraph files 
for file in *bg 
do
./EveryCen-boxplot.pl $file
done
#R code for plotting 
R --no-save < plot-everyboxplot.r
