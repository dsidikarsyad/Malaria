# malaria

Version 0.1.0

This project is based on Mass Blood Survey for Malaria study data conducted in South West Sumba, Indonesia in 2014, and have been published.
Please start the 

## How To Use
To clone and run this application, you'll need Git and Node.js (which comes with npm) installed on your computer. From your command line:

### Clone this repository
$ git clone https://github.com/dsidikarsyad/Malaria

### Go into the repository
$ cd Malaria

### Script for Data Anaysis
Script analysis is located in the folder called "src"

### Package Dependency
We use R version 3.6.2, but version 3.4 above is good

Install this package before starting to work with the data 
library(readxl)
library(ggplot2)
library(tidyverse)
library(ggpubr)

## Project organization

```
.
├── .gitignore
├── CITATION.md
├── LICENSE.md
├── README.md
├── requirements.txt
├── bin                <- Compiled and external code, ignored by git (PG)
│   └── external       <- Any external source code, ignored by git (RO)
├── config             <- Configuration files (HW)
├── data               <- All project data, ignored by git
│   ├── processed      <- The final, canonical data sets for modeling. (PG)
│   ├── raw            <- The original, immutable data dump. (RO)
│   └── temp           <- Intermediate data that has been transformed. (PG)
├── docs               <- Documentation notebook for users (HW)
│   ├── manuscript     <- Manuscript source, e.g., LaTeX, Markdown, etc. (HW)
│   └── reports        <- Other project reports and notebooks (e.g. Jupyter, .Rmd) (HW)
├── results
│   ├── figures        <- Figures for the manuscript or reports (PG)
│   └── output         <- Other output for the manuscript or reports (PG)
└── src                <- Source code for this project (HW)

```


## License

This project is licensed under the terms of the [MIT License](/LICENSE.md)

## Citation

Please [cite this project as described here](/CITATION.md).
