#! /usr/bin/env python

#goal: running all r-script Demeralate output files, that state the relatedness
#of individuals, to state how related they are:
#"full sib", "half sib", "not related"
#Sophia Feuerhake, Charleyy Russell
#03.02.2018

#importing regular expressions
import re
import os, sys
import csv

print "Run python"

#Will let all related_*.csv files (defined in script.sh) run through this script
filename = sys.argv[1]

print sys.argv[1] 

#step 1: reading/writing input file
#the program has to be run from within the directory the inputfile is saved in
InFileName = filename

#Open the input file for reading
InFile = open(InFileName, 'r')

#Initialize the counter used to keep track of each line in the file
LineNumber = 0

#Open the output file for writing before the loop
OutFileName=InFileName + ".txt"
OutFile=open(OutFileName, 'wa')


#Loop through each line in the file (each individual)
for Line in InFile:
	#skipping the header in the loop
	if LineNumber > 0:
		#Splitting the lines of data (data of each individual) into columns, 
		#by defining the deliminator
		ElementList = Line.split(',')
		
		#Defining Elements of the file
		CompairedPair = ElementList[0]
		Relatedness = ElementList[1]
		
		#If relatedness is over 0.53 it will print full sibs
		#Problem: if the threshhold for full sibs, half sibs is different for 
		#other populations, it will have to be changed manually
		if float(Relatedness) >= 0.53:
			a = " ".join([CompairedPair, 'are full sibs',"\n"])
			#will write output to outfile
			OutFile.write(a)
		#If relatedness is over 0.36, but under 0.53 it will print half sibs
		elif float(Relatedness) >=  0.36 and float(Relatedness) < 0.53:
			#will write output to outfile
			b = " ".join([CompairedPair, 'are half sibs',"\n"])
			OutFile.write(b)
		#if relatedness is below 0.36 it will print not related
		else:
			c = " ".join([CompairedPair, 'are not related',"\n"])
			#will write output to outfile
			OutFile.write(c)
	#always adds 1 to linenumber, every time the loop runs
	LineNumber = LineNumber + 1
	



#After the loop the file is closed
InFile.close()
OutFile.close()

print "Closing the script"