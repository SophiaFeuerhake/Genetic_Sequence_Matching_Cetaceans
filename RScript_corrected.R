#installing packages#
#install.packages("Demerelate") #uncommand this if you haven't installed Demerelate
#install.packages("adegenet")   #uncommand this if you haven't installed Demerelate


# loading packages
library(Demerelate)
library(devtools)
library(adegenet)


#reads in csv file --> formatted for Demerelate
Data_original <- read.csv("~/Documents/Bioinformatics/FINAL_project/My_Data/DataUK.csv")


#reads in csv file --> formatted for pop info with adegenet
Data_formatted <- read.csv("~/Documents/Bioinformatics/FINAL_project/My_Data/Data_hetero_fix.csv")


#makes a new dataset taking only the columns you want to keep: ref number, location, lat, lon, microsatellites
Data_new = Data_formatted[,c("ref_nhm","geogpop2","X","Y","X415_416A","IGF_1A","X417_418A",
                            "GT136A","GT011A","EV94A","GT015A","GATA053A","TAA031A","EV104A")]


# 1.step: gathering info on the populationstructure

#Change directory to the one you want
setwd("~/Documents/Bioinformatics/FINAL_project/My_Data")


#df2genind converts the data frame into a genind object
#contains individual genotypes --> sep="/" seperates the mother/father allele of each microsatellite
Genind_pop <- df2genind(Data_new[,c(5:14)], sep="/", ind.names = Data_new$ref_nhm, 
                       pop = Data_new$geogpop2, loc.names = names(Data_new)[c(5:14)], type='codom', NA.char="NA/NA")
Genind_pop #no of ind., loci, alleles, etc.

#summary will give us info on the genetic diversity of the population, 
#the percantage of missing data, no of alleles per locus, etc.
Summary = summary(Genind_pop)


#captures the output of Summary in a text file
capture.output(print(Summary),file="summary.txt")


#makes a new dataset taking only the columns you want to keep:
#ref number, location (populations), microsatellites
#--> in this case all alleles are in seperate columns, for the correct format for Demerelate
Data_Dem = Data_original[,c("ref_nhm","geogpop2","X415_416A","X415_416B","IGF_1A","IGF_1B","X417_418A",
                             "X417_418B","GT136A","GT136B","GT011A","GT011B","EV94A","EV94B",
                             "GT015A","GT015B","GATA053A","GATA053B","TAA031A","TAA031B",
                             "EV104A","EV104B")]

#Demerelate: function to calculate pairwise relatedness on diploid genetic datasets
Output = Demerelate(Data_Dem, ref.pop = 'NA', #we don't have a reference pop, but are comparing all individ. in pop
  #obj = False --> we want the data to be treted as file not objects
  #value = myx --> comparing genotype sharing, calculates the average number of matches per locus between individuals x and y
  #Fis = FALSE --> we don't need fis values to be calculated
  object = TRUE, value = "Mxy", Fis = FALSE, 
  #output is false because we hava NA values
  #p.correct is false FOR NOW
  file.output = FALSE, p.correct = FALSE,
  #iteration is number of bootstraps, pairs is number of pairs calculated
  iteration = 1000, pairs = 1000,
  #dis.data is anything to do with coordinates or distance meausures
  #NA.rm is removing any NA values in pop to lower chance of bias in results
  dis.data = "relative", NA.rm = TRUE,
  #genotype.ref if true is random non related pop are generated from genotypes
  genotype.ref = TRUE)

#making sure we are in the right directory
setwd("~/Documents/Bioinformatics/FINAL_project/My_Data")

#writing Demerelate outputs of diff locations into different csv files
print("Before Empirical")
write.csv(Output$Empirical_Relatedness$Channel, file="relatedness_channel.csv",sep=",")
write.csv(Output$Empirical_Relatedness$CWest, file="relatedness_cwest.csv",sep=",")
write.csv(Output$Empirical_Relatedness$NSN, file="relatedness_nsn.csv",sep=",")
write.csv(Output$Empirical_Relatedness$NSS, file="relatedness_nss.csv",sep=",")
write.csv(Output$Empirical_Relatedness$West, file="relatedness_west.csv",sep=",")
write.csv(Output$Empirical_Relatedness$WScott, file="relatedness_wscot.csv",sep=",")
#writing Demerelate outputs of statistics into different csv files
print("Before Relatedness_Statistics")
write.csv(Output$`Relatedness_Statistics (T-test)`, file="Relatedness_t-test.csv",sep=",")
write.csv(Output$`Relatedness_Statistics (X^2-Test)`, file="Relatedness_Statistics.csv",sep=",")
write.csv(Output$`Thresholds for relatedness`, file="Relatedness_thresh_info.csv",sep=",")
