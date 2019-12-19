library(readxl)
library(ggplot2)
library(tidyverse)
library(ggpubr)
Malaria <- read_excel("~/Desktop/Belajar R/Malaria/Malaria_Data.xlsx", 
                           col_types = c("text", "text", "text", 
                                         "text", "numeric", "text", "text", 
                                         "numeric", "numeric", "numeric", 
                                         "text"))
attach(Malaria)

#Recode Variabel Malaria type
Malaria$stat <- recode(Type, NEG="NEG", .default = "POS")

### Descriptive Analysis
#Dusun
sample1<-table(Dusun, Sex)
sample1
plotbydusun<-ggplot(Malaria, aes(Dusun, fill=Sex)) + geom_bar(position="Dodge")
plotbydusun

#Temperature
plotbytemp <- ggplot(Malaria, aes(Dusun, `Temp (oC)`, fill=Sex)) + geom_boxplot()
plotbytemp

#HbLevel
plotbyHb <- ggplot(Malaria, aes(Dusun, HB, fill=Sex)) + geom_boxplot()
plotbyHb

#Malaria Status
plotbyMalaria <- plotbydusun<-ggplot(Malaria, aes(Dusun, fill=Malaria$stat)) + geom_bar(position="Dodge")
plotbyMalaria

#Temperature by Malaria Status
malpos <- subset(Malaria, stat=="POS")
malbytempall <- ggplot(Malaria, aes(Dusun, HB, fill=stat)) + geom_boxplot()
malbytempall
malbytemppos <-ggplot(malpos, aes(Dusun, HB, fill=stat)) + geom_boxplot()
malbytemppos

#Anova two way analysis for Hb Level
anovahb <- aov(HB~Dusun + Sex, data = Malaria)
summary(anovahb)

# Boxplot Graph HB by status for each village showing pvalue
p <- ggboxplot(Malaria, x = "stat", y = "HB",
               color = "stat", palette = "jco",
               facet.by = "Dusun", short.panel.labs = FALSE)
p + stat_compare_means(label = "p.format")

#Boxplot Graph Hb comparing Dusun for Malaria Positive only
compare_means(HB~Dusun, data = malpos)
mycomparison <- list(c("I", "II"), c("I", "III"), c("I", "IV"), c("II","III"), c("II", "IV"), c("III", "IV"))
ggboxplot(malpos, x = "Dusun", y = "HB",
          color = "Dusun", palette = "jco")+ 
  stat_compare_means(comparisons = mycomparison, label.y = c(20, 25, 30, 35, 40, 45))+ # Add pairwise comparisons p-value
  stat_compare_means(label.y = 50)     # Add global p-value
