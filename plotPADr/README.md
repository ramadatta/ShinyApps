# **[plotPADr](https://prakkirama.shinyapps.io/plotPADr/)**

**Plot** **P**resence/**A**bsence **D**ata using **R** (plotPADr)

## Content
  * [Synopsis](#synopsis)
  * [Input Requirements](#input-requirements)
  * [Why use plotPADr?](#why-use-plotpadr)
  * [Example Usage](#example-usage)
  * [Version](#version)
  * [Community Guidelines ](#community-guidelines)
  * [Bug Report and Support Request](#bug-report-and-support-request)


##### **Synopsis**

[plotPADr](https://prakkirama.shinyapps.io/plotPADr/) is a shiny application for plotting PCA for samples with gene presence/absence matrix using R. 
  
##### **Input Requirements**

plotPADr requires two files
1. An **.Rtab** file produced from Roary/Panaroo is required as input file (See sample [here](https://github.com/ramadatta/ShinyApps/blob/master/plotPADr/input/gene_presence_absence.Rtab))
2. A metadata file for the samples in the above file with **Sample** as header in the first column (See sample [here](https://github.com/ramadatta/ShinyApps/blob/master/plotPADr/input/meta.csv))


### **Why use plotPADr?**

- A PCA plot is generally used to visualize the clusters of samples based on their similarity. The input is given in the data matrix.
- One of the output from Roary/Panaroo is gene presence/absence matrix. So, it would be intersting to see the clusters of various samples with similar gene content and associate the sample clusters with the meta-data. 
- plotPADr does exactly this by taking gene PA matrix and associated meta-data and plots both static plot (useful for publication) and interactive plot (useful to explore).

You can view plot by dynamically changing the inputs such as:

- Changing Principal Components
- Changing Color and Shape variables from the provided input
- Changing transparency of the data points


### **Example Usage**
 
![](plotPADr.gif)

##### **Version**

version 1.0.0

# Community Guidelines

## How to Contribute

In general, you can contribute to this project by creating [issues](https://github.com/ramadatta/ShinyApps/issues).
You are also welcome to contribute to the source code directly by forking the project, modifying the code, and creating [pull requests](https://github.com/ramadatta/plotPADr/pulls).
If you are not familiar with pull requests, check out [this post](https://guides.github.com/activities/forking/).
Please use clear and organized descriptions when creating issues and pull requests.

Please note that ``plotPADr`` is released with a [Contributor Code of Conduct](https://github.com/ramadatta/ShinyApps/blob/master/plotPADr/Code_of_Conduct.md). By contributing to this project, you agree to abide by its terms.

## Bug Report and Support Request

You can use [issues](https://github.com/ramadatta/ShinyApps/issues) to report bugs and seek support.
Before creating any new issues, please check for similar ones in the issue list first. 

## Citation

If you publish the results of plotPADr, please also cite the following software and the database:

ggplot2 package




