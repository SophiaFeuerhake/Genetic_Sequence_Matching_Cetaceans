#!/bin/bash

#will open r and execute the rscript
Rscript ~/Documents/Bioinformatics/FINAL_project/My_Data/RScript_corrected.R

#will execute the python script, running through all the outputfiles from the
#rscript with this "relatedness_*.csv" name
for i in relatedness_*.csv; do 
	echo $i
	python ~/Documents/Bioinformatics/FINAL_project/My_Data/Relatedness.py $i 
done
