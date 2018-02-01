# Genetic_Sequence_Matching_Cetaceans
Script that allows matching of full and half siblings but also shows non-related matches.

![Inputfile_Demerelate](DataUK.csv)
![Inputfile_adegenet](Data_Hetero_fix.csv)
![RScript](RScript_corrected.r)
![python](Relatedness.py)
![shell](Script.sh)

## Description
Within cetacean populations you can determine relatedness of individuals if you have the different microsatellite lengths for each individual.

Before trying to download and run the scripts make sure that you have R studio and python on your computer. If not these must be downloaded for this program to work.

Then download and save 'Rscript_corrected.R' and the 'Relatedness.py' file into the same directory.

There is three stages to this script. The first is a R script, second is a Python script and finally a code that allows you to create a bash script that once you have saved all the individual files and changed the modifications of the 'script.py' file (do this via the command 'chmod u+x script.py'), this script will be ready to run and you should be able to type into the terminal ./script.py (this is for Linux - the command to run this program could vary depending on what operating system you are using) and this will run all the programs from the terminal and create the documents that you can then open and use.

When making the bash script to allow your program to run from terminal this is the code you must use (take into account that where it says the path to each file, edit this to the path that your files are in):

#!/bin/bash

#will open r and execute the rscript
Rscript ~/Documents/Bioinformatics/FINAL_project/My_Data/RScript_corrected.R

#will execute the python script, running through all the outputfiles from the
#rscript with this "relatedness_*.csv" name
for i in relatedness_*.csv; do 
    echo $i
    python ~/Documents/Bioinformatics/FINAL_project/My_Data/Relatedness.py $i 
done

If you are using Linux then this script is called 'script.sh' you can just use that.

# RScript_corrected.R
This uses Demerelate and adegenet packages (These will have to be installed for them to install properly you need the newest version of R) to determine the threshold of relatedness (above a certain number individuals are classes as 'Full Siblings', above another number they are 'Half-Siblings' and then finally if the threshold is below the value for Half-Siblings then they are 'Not Related'), and creates a list comparing individuals. It also analyses the heterozygosity within the population.

Within the R script there are 2 things that you need to change. The first in the name of the input data file and the second is the threshold for the distinguishing relatedness (Full sublings, Half-Siblings and Not Related) will have to be changed depending on the output of your data. 

# Relatedness.py
This python script takes the threshold values and assigns Full sublings, Half-Siblings and Not Related to each comparision and then creates an output .txt file with all of the data in.

## Input
As both of the programes work together there is only need for one input. The dataset that is entered into this script must be a .csv file. The data that is being analysis must be microsatellite (e.g. 215 135 203) and not allele (GCAT). Any missing values should be replaced with 'NA'. An example of the format your input data is stated below:

Demerelate example data:
1,9,Channel,SW1991_17,SW1991/17,SW1991_17,51.35,1.43,141,M,8,Adult,1991,29/01/91,215,215,146,150,177,177,95,95,105,119,202,206,154,168,201,209,229,235,156,160

adegenet example data:
1,9,Channel,SW1991_17,SW1991/17,SW1991_17,51.35,1.43,141,M,8,Adult,1991,29/01/91,215/215,146/150,177/177,95/95,105/119,202/206,154/168,201/209,229/235,156/160

The difference is that the allele A and B are needed in one column for adegent seperated with a "/", while they need to be in different columns for Demerelate.

The names of our input files are: 
> For Demerelate - DataUK.csv
> For adegenet - Data_hetero_fix.csv 

## Output
The output will contain several files. All the files with the ending .csv are output from the R script and all the files ending .txt are output from python.

The files below all contain the data from each location separated into different files by the different regoins (e.g. Channel, CWest...), within these files you will have a list:

"SW1991_17_SW1991_17A" are half sibs <- this is read that the information in the first set of apostrophes is the ID of the first individual and then the second apostrophes is the ID of the second individual and the information within the last set of apostrophes is the relatedness outcome on those 2 individuals.

relatedness_channel.csv
relatedness_cwest.csv
relatedness_WScot.csv
relatedness_west.csv
#relatedness_nsn.csv 

The R output from the Demerelate function also contains information on the statistics.
Relatedness_Statistics.csv
Relatedness_t-test.csv
Relatedness_thresh_info.csv

The bash script when run will analyse all .csv files within that directory that start with 'relatedness_' and will compare the relatedness and heterozygosity within all the populations and it creates all of the following files:

relatedness_channel.csv.txt
relatedness_cwest.csv.txt
relatedness_WScot.csv.txt
relatedness_west.csv.txt
relatedness_nsn.csv.txt

These are the output from the python script, they contain the relatedness data between indivduals stating whether they are 'full/half siblings or not related'.These files contain the data from the samples from the different locations. 

Summary.txt <- This is a file that contains data on the expected and observed heterozygosity within the population (from this you can also work out the expected and observed homozygosity within the population - both of them together have to add up to 1 (e.g. observed heterozygosity is 0.52 observed homozygosity is 0.48). This is created from the R adegenet script.

[name of input file].txt <- This file contains the list of relatedness from python as stated in the input.

## Example 
Within the example file you will find a dataset that contains around 600 harbor porpoise microsatellite data that was collected around the UK. You can use this to check the outcome of the program but it can be useful to check to make sure your data is within the correct format.

## References
Blouin. M.S, et al., 1996. Use of Microsatellite loci to classify individuals by relatedness. Molecular Ecology, 5, 393-401.

Kraemer. P., 2017. Package 'Demerelate'. CRAN_R-project.org

Jombart. T, et al., 2017. Package 'adegenet'. CRAN_R-project.org

Ritland. K., 2000. Marker-Inferred relatedness as a tool for dectecting heritability in nature. Molecular Ecology, 9, 1195-1204.

Fountaine. M.C, et al., 2017. Mixing of porpoise ecotypes in southwestern UK waters revealed by genetic profiling. Royal society of open science. 4: 160992.
