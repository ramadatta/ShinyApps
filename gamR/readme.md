# **[gamR](https://prakkirama.shinyapps.io/gamr/)**
Draw Gene Arrow Maps with gggenes package using R-Shiny App 

## Content
  * [Synopsis](#synopsis)
  * [Input Requirements](#input-requirements)
  * [Details](#details)
  * [Example Usage](#example-usage)
  * [Version](#version)
  * [Community Guidelines ](#community-guidelines)
  * [Bug Report and Support Request](#bug-report-and-support-request)


##### **Synopsis**

[gamR](https://prakkirama.shinyapps.io/gamr/) is a shiny application for drawing gene arrow maps using gggenes package. 
  
##### **Input Requirements**
* A csv file in the gggenes input format (also available [here](https://github.com/ramadatta/ShinyApps/blob/master/gamR/example_genes.csv))

### **Details**

#### **Basic** 
Clicking this option would generate a basic plot with only gene directionality 

#### **Align using a specific gene + add label** 
Clicking this option would generate a plot with labels inside the arrows and the genes can be aligned based on a specific gene

#### **Align using a specific gene + add label above** 
Clicking this option would generate a plot with labels outside the arrows and the genes can be aligned based on a specific gene

#### **Align using a specific gene + add label above + order by gene pres/abs** 
Clicking this option would generate a plot with genomes sorted by gene presence/absence. 

#### **Align using a specific gene + add label above + order by gene pres/abs + Distinctive Gene Set Structures** 
Clicking this option would generate a plot of genomes with unique set of genes (directionality ignored). For example: Regardless of directionality, if genome A and B have same gene G1, G2, G3, G4 - only one of the genomes between the two will be choosen

### **Example Usage**
 
![](gamR_v2_compressed.gif)

##### **Version**

version 1.0.0

- Added color palette, b25 can accept upto 300 colors
- Added download pdf function with heigt and width from user
- Added label size, arrow head size and width change functionality

# Community Guidelines

## How to Contribute

In general, you can contribute to this project by creating [issues](https://github.com/ramadatta/gamR/issues).
You are also welcome to contribute to the source code directly by forking the project, modifying the code, and creating [pull requests](https://github.com/ramadatta/gamR/pulls).
If you are not familiar with pull requests, check out [this post](https://guides.github.com/activities/forking/).
Please use clear and organized descriptions when creating issues and pull requests.

Please note that ``gamR`` is released with a [Contributor Code of Conduct](https://github.com/ramadatta/ShinyApps/blob/master/gamR/Code_of_Conduct.md). By contributing to this project, you agree to abide by its terms.

## Bug Report and Support Request

You can use [issues](https://github.com/ramadatta/gamR/issues) to report bugs and seek support.
Before creating any new issues, please check for similar ones in the issue list first. 

## Citation

If you publish the results of gamR, please also cite the following software and the database:

gggenes package
ggplot2 package



