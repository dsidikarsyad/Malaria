library(readxl)
library(ggplot2)
library(tidyverse)
library(ggpubr)

#Loading and attaching Data
Malaria <- read_excel("~/Malaria/data/raw/Malaria_Data.xlsx", 
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
png("/results/figures/plotbydusun.png")
ggsave(filename="~/Malaria/results/figures/plotbydusun.png")
dev.off()

#Temperature
plotbytemp <- ggplot(Malaria, aes(Dusun, `Temp (oC)`, fill=Sex)) + geom_boxplot()
plotbytemp
png("/results/figures/plotbytemp.png")
ggsave(filename="~/Malaria/results/figures/plotbytemp.png")
dev.off()

#HbLevel
plotbyHb <- ggplot(Malaria, aes(Dusun, HB, fill=Sex)) + geom_boxplot()
plotbyHb
png("/results/figures/plotbyHb.png")
ggsave(filename="~/Malaria/results/figures/plotbyHb.png")
dev.off()


#Malaria Status
plotbyMalaria <- plotbydusun<-ggplot(Malaria, aes(Dusun, fill=Malaria$stat)) + geom_bar(position="Dodge")
plotbyMalaria
png("/results/figures/plotbyMalaria.png")
ggsave(filename="~/Malaria/results/figures/plotbyMalaria.png")
dev.off()

#### Bivariate Analysis
#Temperature by Malaria Status
malpos <- subset(Malaria, stat=="POS")
malbytempall <- ggplot(Malaria, aes(Dusun, HB, fill=stat)) + geom_boxplot()
malbytempall
png("/results/figures/plotbymalltempall.png")
ggsave(filename="~/Malaria/results/figures/plotbymalltempall.png")
dev.off()

malbytemppos <-ggplot(malpos, aes(Dusun, HB, fill=stat)) + geom_boxplot()
malbytemppos


#Anova two way analysis for Hb Level
anovahb <- aov(HB~Dusun + Sex, data = Malaria)
anovahb
table1<-summary(anovahb)
print(table1, file="~/Malaria/results/output/table1.txt")
dev.off()

# Boxplot Graph HB by status for each village showing pvalue
p <- ggboxplot(Malaria, x = "stat", y = "HB",
               color = "stat", palette = "jco",
               facet.by = "Dusun", short.panel.labs = FALSE)
plothbbymal<-p + stat_compare_means(label = "p.format")
png("/results/figures/plothbbymal.png")
ggsave(filename="~/Malaria/results/figures/plothbbymal.png")
dev.off()


#Boxplot Graph Hb comparing Dusun for Malaria Positive only
compare_means(HB~Dusun, data = malpos)
mycomparison <- list(c("I", "II"), c("I", "III"), c("I", "IV"), c("II","III"), c("II", "IV"), c("III", "IV"))
plot2 <- ggboxplot(malpos, x = "Dusun", y = "HB",
          color = "Dusun", palette = "jco")+ 
  stat_compare_means(comparisons = mycomparison, label.y = c(20, 25, 30, 35, 40, 45))+ # Add pairwise comparisons p-value
  stat_compare_means(label.y = 50)     # Add global p-value
plot2
png("/results/figures/compareHbmeans.png")
ggsave(filename="~/Malaria/results/figures/compareHbmeans.png")
dev.off()
