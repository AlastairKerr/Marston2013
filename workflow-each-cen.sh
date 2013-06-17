#!/bin/bash

for file in *bg 
do
./EveryCen-boxplot.pl $file
done

R --no-save < plot-everyboxplot.r
