# installing required Library packages.
install.packages('dplyr')
install.packages('quantreg')
install.packages('ggplot2')
install.packages('corrplot')
install.packages('corrgram')
install.packages('rworldmap')

# Calling required libraries
library(dplyr)
library(ggplot2)
library(corrgram)
library(corrplot)

# Saving the dataset in variable db
db <- read.csv("life-expectancy-data-2014.csv")

#  Remove Columns of Total Expenditure, Population, composition of income 
db <- db[ ,-17]
db <- db[ ,-18]
db <- db[ ,-13]

# Creating new column of Continent
db$Continent <- NA

# Assigning different Regions the Continent they fall in
db$Continent[which(db$Region %in% c("Australia & New Zeland"))] <- "Australia"
db$Continent[which(db$Region %in% c("Western Europe","Central & Eastern Europe"))] <- "Europe"
db$Continent[which(db$Region %in% c("North America"))] <- "North America"
db$Continent[which(db$Region %in% c("Sub-Saharan Africa","Middle East & Northen Africa"))] <- "Africa"
db$Continent[which(db$Region %in% c("Eastern Asia","Southern Asia","Southeastern Asia"))] <- "Asia"
db$Continent[which(db$Region %in% c("Latin America & Caribbean"))] <- "South America"

# Storing the mean value of all the numeric value columns Continent wise  
hp  <- aggregate(db[ ,4:17],list(db$Continent),mean)

# Creating Healthmeter Column
db$Healthmeter <- NA
db$Healthmeter[which(db$Region %in% c("Australia & New Zeland","Western Europe","North America"))] <- "Healthiest"
db$Healthmeter[which(db$Region %in% c("Latin America & Caribbean","Central & Eastern Europe","Eastern Asia","Southern Asia","Southeastern Asia","Middle East & Northen Africa"))] <- "Neutral"
db$Healthmeter[which(db$Region %in% c("Sub-Saharan Africa"))] <- "Unhealthiest"