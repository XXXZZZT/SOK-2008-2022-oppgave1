# HELP SCRIPT FILE  Utfording 2.3 - sok-2008

# Download the data file union_unempl.csv and store it in an easily accessible location, such as a folder on your Desktop or in your personal folder.
# Install any R packages that you need using the command install.packages("package name").
# You will need the following packages for the assignment: 



# Set your working directory to the correct folder. 
# Insert your file path for 'YOURFILEPATH'. 
setwd("C:/Users/marti/Downloads")
getwd()

# You will need the following libraries for the assignment:

library(readr) # fileformat of the dataset
library(ggplot2)     # the ggplot package
library(tidyverse)  # the tidyverse package


# To carry out the assignment, you will need to combine the union_unempl data with map data. 

union<- read_csv("union_unempl.csv") #This loads the data with information about the variables of interest
View(union) #Displays the data
#To combine the unemployment and union data with the map data, we merge on country name. 
#We face two problems here: 1) United Kingdom is called "UK" in the map data, 2) the variable "country" is called "region" in the map data. We need to change this.

#Changing the name of a single observation. The below code changes all observations called "United Kingdom" to "UK" in the union data. 
union$country <- gsub("United Kingdom", "UK", union$country)
View(union) 

# Renaming a variable. The below code renames the variable "Country" to "Region".
names(union)[names(union) == "country"] <- "region"
View(union) 



view(union)

# Creating a new variable. To create a map showing "Excess coverage", you need to create a new variable. The below code shows how to create a new variable in R. 
new_union <- union
new_union <- transform(new_union, Excess_coverage = coverage - density)

(view)(new_union)


# You are now ready to create your maps! Follow the tutorial at https://www.youtube.com/watch?v=AgWgPSZ7Gp0 

# The "Coord" variable takes 5 discrete levels. It may therefore be better to use a discrete scale for the coloring. 
# To do this, simply replace "scale_fill_gradient(name="name", low="color1", high="color2", na.value="grey50")" with "scale_fill_brewer(name="name", palette = "Set1")" (or another set you prefer)


mapdata <- map_data("world") ##ggplot2
View(mapdata)
mapdata <- left_join(mapdata, new_union, by="region")
View(mapdata)

mapdata1<-mapdata %>% filter(!is.na(mapdata$unempl))
View(mapdata1)

map1<-ggplot(mapdata1, aes( x = long, y = lat, group=group)) +
  geom_polygon(aes(fill = unempl), color = "black")
map1
View(map1)


#) fagforeningsdensitet

mapdata2<-mapdata %>% filter(!is.na(mapdata$density))
View(mapdata2)

fagforening<-ggplot(mapdata2,aes( x = long, y = lat, group=group)) +
  geom_polygon(aes(fill = density), color = "black")
fagforening
View(fagforening)


fagforening + scale_fill_gradient(name = "Union_Density", low = "yellow", high =  "red", na.value = "grey50")+
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.y=element_blank(),
        axis.title.x=element_blank(),
        rect = element_blank())




#Excces coverage


mapdata3<-mapdata %>% filter(!is.na(mapdata$Excess_coverage))
View(mapdata3)

Excess_coverage<-ggplot(mapdata2,aes( x = long, y = lat, group=group)) +
  geom_polygon(aes(fill = Excess_coverage), color = "black")
Excess_coverage
View(Excess_coverage)


Excess_coverage + scale_fill_gradient(name = "Excess_coverage", low = "yellow", high =  "red", na.value = "grey50")+
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.y=element_blank(),
        axis.title.x=element_blank(),
        rect = element_blank())


# Koordinering av l??nnsfastsettelse.(levels)

mapdata4<-mapdata %>% filter(!is.na(mapdata$level))
View(mapdata4)

level<-ggplot(mapdata2,aes( x = long, y = lat, group=group)) +
  geom_polygon(aes(fill = level), color = "black")
level
View(level)


level + theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.y=element_blank(),
        axis.title.x=element_blank(),
        rect = element_blank())
#Stop/2/