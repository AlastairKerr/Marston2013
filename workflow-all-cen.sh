#!/bin/bash

for file in *bg 
do
./Cen-boxplot.pl  $file
done

R --no-save < AllCen.r
