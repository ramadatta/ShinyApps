# ggResist
Generate a resistome plots from CGE resfinder output

## Content
  * [Synopsis](#synopsis)
  * [Input Requirements](#input-requirements)
  * [Installation](#installation)
  * [Example Usage](#example-usage)
  * [Working with testData](#working-with-testdata)
  * [Output Files](#output-files)
  * [Version](#version)
  * [A few example plots](#a-few-example-plots)
  * [Community Guidelines ](#community-guidelines)
  * [Bug Report and Support Request](#bug-report-and-support-request)


##### **Synopsis**

Current AMR detection tools generate comparative tables across genomes and can help in visualization of comprehensive AMR gene complement. Nevertheless, they do not readily generate a genetic profile for the presence of CP genes, extract and visualize the cocarriage of CP genes. Achieving this currently necessitates a restructuring and transformation of the output from these tools. 

To address this need, we describe here a lightweight R package, CPgeneProfiler that scans multiple bacterial genome assemblies to detect and visualize the presence of CP genes and their cocarriage using the R framework. Input required is a directory of FASTA file with genome assemblies.

Additionally, this package also allows to assess the size of CP contigs to check if the CP genes are distributed on the particular sequence size by generating the contig length distribution plots.

Other assembly statistics such as N50, N90, Assembly Size from the assembly are calculated and plots of length distribution of CP gene contigs from
 the list of assemblies are reported.  
 
Currently the package works only on Unix systems.
 
 
##### **Input Requirements**
* Path of a directory with multiple FASTA files (can be in multiple contigs) 
* Path of Carbapenemase Gene Database file (FASTA) directory

#### Conda (https://anaconda.org/bioconda/cpgeneprofiler) 

To install this package with conda run:
``` 
conda install -c bioconda cpgeneprofiler
```

##### **Requirements**

- **R packages (REQUIRED):**
	 tidyverse,
	 UpSetR,
	 scales,
	 ape,
	 BiocManager,
	 Biostrings,
	 reshape2,
	 gridExtra
	 png, 
	 tiff,
	 jpeg,
	 pdftools,
	 grid
	 
Install these packages using R (versions >=3.6):
	
``` r
install.packages(c("BiocManager", "tidyverse", "UpSetR", "scales", "ape", 
                    "reshape2", "gridExtra","png", "tiff", "jpeg", "pdftools", "grid"))

BiocManager::install("Biostrings")
```	 

- **External software (REQUIRED):** [NCBI BLAST 2.9.0+](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download)
   
	- Go to page: https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.9.0/

	- Save `ncbi-blast-2.9.0+-x64-linux.tar.gz` in the local directory

	- To install, simply extract the downloaded package using the following command

	```
	tar zxvpf ncbi-blast-2.9.0+-x64-linux.tar.gz
	```

	- Configure of NCBI BLAST+ executables using the following command. This would append the path to the new BLAST bin directory to the existing PATH setting.


	```
	export PATH=$PATH:$HOME/ncbi-blast-2.9.0+/bin
	```
	
	- Refer [here](https://www.ncbi.nlm.nih.gov/books/NBK52640/) for source documentation

	  Note 1: R package assumes `blastn` and `makeblastdb` files are in path
    
 	  Note 2: BLAST version 2.9.0+ was used for the present program although other BLAST+ similar to version 2.9.0+ parameters might also run without problems
    
- **CP gene Database Download (REQUIRED)**

 The CP gene database can be downloaded either of the following 3 ways:

- Using **R** console
	
``` r 	
# Specify CP gene database URL 
url <- "https://raw.githubusercontent.com/ramadatta/CPgeneProfiler/master/testData/db/NCBI_BARRGD_CPG_DB.fasta"

# Specify destination where CP gene database file should be saved 
path <- "/home/user/db" # Can change to prefarable location
setwd(path)
destfile <- "NCBI_BARRGD_CPG_DB.fasta"

# Download the CP gene database file to the folder set in "path"
download.file(url, destfile)
```

- Using **UNIX/Linux** command line terminal and download the `db` folder with SVN

```
svn export https://github.com/ramadatta/CPgeneProfiler/trunk/testData/db
```
- Else, simply [Click](https://downgit.github.io/#/home?url=https://github.com/ramadatta/CPgeneProfiler/tree/master/testData/db) to save database folder and uncompress the `db.zip` folder.    
    
#### **Installation**

##### **From Github**

The R package is available through github repository can be installed using devtools.

``` r 
install.packages("devtools")
devtools::install_github("ramadatta/CPgeneProfiler")
```

##### **Check installation**
Ensure you have installed the package properly:

``` r
library("CPgeneProfiler")
?CPgeneProfiler
```

### **Example Usage**
 
`CPgeneProfiler` package can be run using the following functions: `cpblast()`, `filt_blast()`, `cocarriage()`, `cpprofile()`, `upsetR_plot()`, `plot_conlen()`,`assemblystat()`, `cp_summarize()`, `db_summary()`. Below are the examples of `CPgeneProfiler` commands usage. 


- Generates NCBI BLAST Results by aligning input genome assemblies against Carbapenamase (CP) gene database

``` r
cpblast(fastalocation = "/home/user/CPgeneProfiler/testData/fasta", dblocation = "/home/user/CPgeneProfiler/testData/db")

```
- Filtering NCBI BLAST Results based on CP gene coverage and percent identity. By default, alignment coverage of CP gene (`cpgcov`) and percentage identity (`cpgpident`) are set to 100%.

``` r
filt_blast(cpgcov = 100, cpgpident = 100)
```

- Report cocarriage of CP genes across all the input genome assemblies (Default:`cpgcov = 100` and `cpgpident = 100`)

``` r
cocarriage(cpgcov = 100, cpgpident = 100)
```

- Generate CP gene Profile across all the input genome assemblies (Default:`cpgcov = 100` and `cpgpident = 100`)

``` r
cpprofile(xlab = "Carbapenamase Genes", ylab = "Assembly", title = "Carbapenamase Gene Profile Heatmap")
```

- Plot CP gene contig length distributions across all the input genome assemblies (Default:`cpgcov = 100` and `cpgpident = 100`)

``` r
plot_conlen(outputType = "png", xlab = "Contig Length", ylab = "Number of Contigs", title = " Contig Length Distribution", colorfill = "#F99245")
```
- Generate set intersection plot of CP genes across all the input genome assemblies (Default:`cpgcov = 100` and `cpgpident = 100`)

``` r
upsetR_plot(outputType="png", width = 2000, height = 2000, res = 250, xlab="Carbapenamase Gene Set Size", ylab="Number of genome assemblies",cpgcov=100, cpgpident=100, order.by = "degree",nsets = 40, number.angles = 0,point.size = 1.5, line.size = 1,sets.bar.color = "red")
```
- Generate basic assembly statistics such N50, N90 and Assembly Size and plots comparing Assembly Size with N50, N90 stats

``` r
assemblystat(fastalocation = "/home/user/CPgeneProfiler/testData/fasta")
```

- Summarize the plots and organize all the output files in specific folders

``` r
cp_summarize(outdir_loc = "/home/user/Desktop", outdir = "CPgeneProfiler_Output")
```

- Database information

``` r
db_summary()
```

### **Working with `testData`**

#### **Test Data Download**

To test the package with test input data, Go to the UNIX/Linux command line terminal and download the `fasta` folder with SVN

```
svn export https://github.com/ramadatta/CPgeneProfiler/trunk/testData/fasta
```
else simply [Click](https://downgit.github.io/#/home?url=https://github.com/ramadatta/CPgeneProfiler/tree/master/testData/fasta) to save fasta folder and uncompress the `fasta.zip` folder.


##### **1) A simple NCBI BLAST using `cpblast()` command**

As a first step, CPgeneProfiler generates NCBI BLAST Results by aligning input genome assemblies against Carbapenamase (CP) gene database. Now that you already have a directory with fasta files (should have extensions `.fasta` or `.fa`) in `fasta` folder and cp gene database sequence in `db` folder, you can specify the path of both directories as an input and run the package with `cpblast()` command.

``` r
cpblast(fastalocation = "/home/user/CPgeneProfiler/testData/fasta", dblocation = "/home/user/CPgeneProfiler/testData/db", num_threads = 4, evalue = "1e-3")
```
The users can adjust BLAST parameters `num_threads`, `evalue`, `word_size` and `max_target_seqs` accordingly. If not adjusted and command is simply executed with the file locations for `fasta` and `db`, then default parameters are used for the analysis.


##### **2) Filtering BLAST results using `filt_blast()` command**

`filt_blast()` then filters the output BLAST results obtained from `cpblast()` command. This filtering is to find the presence of CP genes given a particular CP gene coverage and Percentage Identity. Therefore, the BLAST hits are filtered based on CP gene coverage and Percentage Identity. By default, CP Gene Coverage and Percentage Identity are set at a threshold of 100% (cpgcov=100, cpgpident=100). This means that a CP gene should have 100% alignment length and 100% identity, without even a single mismatch with the input genome sequence. The default parameters can be adjusted.

``` r
filt_blast(cpgcov = 100, cpgpident = 100)
```

This should generate the following table:

| assemblyName     | qseqid                                    | sseqid  | qlen   | slen | qstart | qend   | length | pident | cov |
|------------------|-------------------------------------------|---------|--------|------|--------|--------|--------|--------|-----|
| genome_001.fasta | 4_length=71861_depth=1.95x_circular=true  | KPC-2   | 71861  | 918  | 3810   | 4727   | 918  | 100 | 100 |
| genome_001.fasta | 5_length=71851_depth=1.95x_circular=true  | KPC-2   | 71851  | 918  | 3810   | 4727   | 918  | 100 | 100 |
| genome_002.fasta | 5_length=51479_depth=1.31x_circular=true  | OXA-181 | 51479  | 998  | 31280  | 32277  | 998  | 100 | 100 |
| genome_003.fasta | 2_length=316292_depth=2.71x_circular=true | NDM-1   | 316292 | 1013 | 149582 | 150594 | 1013 | 100 | 100 |
| genome_003.fasta | 2_length=316292_depth=2.71x_circular=true | OXA-181 | 316292 | 998  | 49123  | 50120  | 998  | 100 | 100 |
| genome_004.fasta | 3_length=66727_depth=0.76x                | OXA-181 | 66727  | 998  | 49850  | 50847  | 998  | 100 | 100 |
| genome_004.fasta | 3_length=66727_depth=0.76x                | OXA-181 | 66727  | 998  | 43441  | 44438  | 998  | 100 | 100 |
| genome_004.fasta | 3_length=66727_depth=0.76x                | OXA-181 | 66727  | 998  | 37032  | 38029  | 998  | 100 | 100 |
| genome_005.fasta | 2_length=79441_depth=2.21x_circular=true  | KPC-2   | 79441  | 918  | 11390  | 12307  | 918  | 100 | 100 |
| genome_005.fasta | 2_length=79441_depth=2.21x_circular=true  | KPC-2   | 79441  | 918  | 3810   | 4727   | 918  | 100 | 100 |
| genome_007.fasta | 2_length=246497_depth=2.06x_circular=true | KPC-2   | 246497 | 918  | 178390 | 179307 | 918  | 100 | 100 |
| genome_007.fasta | 2_length=246497_depth=2.06x_circular=true | IMP-26  | 246497 | 861  | 145325 | 146185 | 861  | 100 | 100 |
| genome_008.fasta | 3_length=41186_depth=4.61x_circular=true  | NDM-1   | 41186  | 1013 | 23027  | 24039  | 1013 | 100 | 100 |
| genome_009.fasta | 4_length=41182_depth=4.10x_circular=true  | NDM-1   | 41182  | 1013 | 23023  | 24035  | 1013 | 100 | 100 |
| genome_010.fasta | 5_length=51479_depth=1.31x_circular=true  | OXA-181 | 51479  | 998  | 31280  | 32277  | 998  | 100 | 100 |
| genome_010.fasta | 3_length=41186_depth=4.61x_circular=true  | NDM-1   | 41186  | 1013 | 23027  | 24039  | 1013 | 100 | 100 |
| genome_012.fasta | 2_length=79441_depth=2.21x_circular=true  | KPC-2   | 79441  | 918  | 11390  | 12307  | 918  | 100 | 100 |
| genome_012.fasta | 2_length=79441_depth=2.21x_circular=true  | KPC-2   | 79441  | 918  | 3810   | 4727   | 918  | 100 | 100 |
| genome_013.fasta | 3_length=41186_depth=4.61x_circular=true  | NDM-1   | 41186  | 1013 | 23027  | 24039  | 1013 | 100 | 100 |
| genome_014.fasta | 4_length=41182_depth=4.10x_circular=true  | NDM-1   | 41182  | 1013 | 23023  | 24035  | 1013 | 100 | 100 |
| genome_015.fasta | 3_length=66727_depth=0.76x                | OXA-181 | 66727  | 998  | 49850  | 50847  | 998  | 100 | 100 |
| genome_015.fasta | 3_length=66727_depth=0.76x                | OXA-181 | 66727  | 998  | 43441  | 44438  | 998  | 100 | 100 |
| genome_015.fasta | 3_length=66727_depth=0.76x                | OXA-181 | 66727  | 998  | 37032  | 38029  | 998  | 100 | 100 |

##### **3) Finding cocarriage genes using `cocarriage()` command**

`cocarriage()` command finds if two or more CP genes exists in same contig or multiple contigs across all the input genome assemblies. This function can be used only after running `filt_blast()`. By default, parameters such as CP Gene Coverage and Percentage Identity are set to 100% (cpgcov=100, cpgpident=100) but can be adjusted as per requirement.

``` r
cocarriage(cpgcov = 100, cpgpident = 100)
```

##### **4) Finding CP gene profile using `cpprofile()` command**

`cpprofile()` creates a heatmap of CP gene profile across the input genome assemblies. By default, the command generates `png` image but user can also create image with other output formats (jpeg/tiff/pdf) and parameters such as width, height of image, label, titles and colors of the heatmap can be adjusted as per requirement.

``` r
cpprofile(outputType="png", width = 2000, height = 2000, res = 250, xlab="Carbapenamase Genes", ylab="Assembly", title="Carbapenamase Gene Profile Heatmap", titlesize=15, labelsize=12, colorcode_low = "#143D59", colorcode_high = "#F4B41A", cpgcov=100, cpgpident=100)
```
<p align="center">
<img src="https://user-images.githubusercontent.com/3212461/90124487-10cca700-dd93-11ea-9572-dfc44a190dd6.png" width="45%"></img> 
</p>

##### **5) Plot CP gene contig length distribution using `plot_conlen()` command**

`plot_conlen()` generates length distribution for all the CP gene contigs present across all the input genome assemblies. By default, the command generates `png` image but user can also create image with other output formats (jpeg/tiff/pdf) and parameters such as width, height of image, label, titles and colors of the heatmap can be adjusted as per requirement.

``` r
plot_conlen(outputType="tiff", width = 700, height = 700, res = 150, xlab="Contig Length", ylab="Number of Contigs", title=" Contig Length Distribution",element_text_angle=90,unit="KB", breaks=15, colorfill = "#F99245",cpgcov=100, cpgpident=100)
```
<p align="center">
<img src="https://user-images.githubusercontent.com/3212461/90124507-17f3b500-dd93-11ea-9f37-6167ec79b8a1.png" width="45%"></img> 
<img src="https://user-images.githubusercontent.com/3212461/90124510-188c4b80-dd93-11ea-8609-1d3fbfc3ef43.png" width="45%"></img>
</p>

##### **6) Generate assembly statistics using `assemblystat()` command**

`assemblystat()` generates basic assembly stats which includes N50 size, N90 size and Genome assembly size. This function also generates Assembly Size vs N50 & Assembly Size vs N90 plots. This function requires the location of fasta file directory. By default, the command generates `png` image plots.

``` r
assemblystat("/home/user/CPgeneProfiler/testData/fasta", outputType="png", width = 700, height = 700, res = 150, geom_point_size=3, n50colorfill = "#0072B2", n90colorfill = "#D55E00")
```
<p align="center">
<img src="https://user-images.githubusercontent.com/3212461/90954281-a825ae80-e4a5-11ea-863d-47678a00aba1.png" width="45%"></img> 
<img src="https://user-images.githubusercontent.com/3212461/90954280-a6f48180-e4a5-11ea-93ad-908e0e339674.png" width="45%"></img>
</p>

##### **7) Generate Set Intersection of CP genes using `upsetR_plot()` command**

`upsetR_plot()` generates set intersection plot of CP genes across all the input genome assemblies. By default, the command generates `png` image but user can change the output image type, width and height of image, label, titles and colors.

``` r
upsetR_plot(outputType="png", width = 2000, height = 2000, res = 250, xlab="Carbapenamase Gene Set Size", ylab="Number of genome assemblies",cpgcov=100, cpgpident=100, order.by = "degree",nsets = 40, number.angles = 0,point.size = 1.5, line.size = 1,sets.bar.color = "red")
```
<p align="center">
<img src="https://user-images.githubusercontent.com/3212461/90124536-1f1ac300-dd93-11ea-9acc-9435b79a7f1c.png" width="45%"></img> 
</p>

##### **8) Summarize all the results using `cp_summarize()` command**

`cp_summarize()` arranges all the output files generated from above commands into respective folders. This also creates a summary of all the plots from CPgeneProfiler output into a single PDF file. Users can specify the output directory name and summary pdf name and also can provide the location of where the output folder to be generated. Note: All the output image plots need to be in the same format i.e, either png/tiff/jpeg.

``` r
cp_summarize(outdir = "CPgeneProfiler_Output", report="Summary" , image = "png")
```

##### **9) Find Database summary details using `db_summary()` command**

`db_summary()` command displays the details of Database. This includes Database Name, Version, Total number of sequences in currently in CP gene Database, Last updated date, Reference web link from which database was downloaded.

``` r
db_summary()
[1] "DATABASE: NCBI Bacterial Antimicrobial Resistance Reference Gene Database"
[1] "VERSION: 2020-07-16.2"
[1] "SEQUENCES: 875"
[1] "DBTYPE: nucl"
[1] "DATE: 2020-Aug-23"
[1] "Reference Gene Catalog: ftp://ftp.ncbi.nlm.nih.gov/pathogen/Antimicrobial_resistance/AMRFinderPlus/database/3.8/"
```

##### **Output Files**

* A folder "CPgeneProfiler_Output" with the following files in respective directories

Command | File | Description
--------|------|--------------
cpblast() | blastResults.txt | Blast Results of contigs against the CP genes
filt_blast() | blastResults.filt.txt | Filtered blast results with contains contigs matching CP genes (default: 100% identity and 100% coverage)
cocarriage() | Cocarriage_Report.txt | Information of Number of assemblies with the co-carriage broken down to category
cocarriage() | Cocarriage_combinedResults.txt | Combined cocarriage details across all the assemblies
cocarriage() | DiffCP_DiffContig.txt | Information of assemblies with different CP genes present in different contigs
cocarriage() | DiffCP_SameContig.txt | Information of assemblies with different CP genes present in same contigs 
cocarriage() | SameCP_DiffContig.txt | Information of assemblies with same CP genes present in different contigs
cocarriage() | SameCP_SameContig.txt | Information of assemblies with same CP genes present in same contigs
cpprofile() | CPgeneProfile.png | Carbapenamase Gene Profile (default:png)
plot_conlen() | CPContigSizeDist.txt | Contig Size distribution
plot_conlen() | "CPGene"_Contig_Dist.png | CP gene contig length distribution (for each CP gene a separate distribution plot is generated. Default image format: png)
upsetR_plot() | cp_presence-absence_matrix.csv | Presence-absence matrix of CP genes across assemblies
upsetR_plot() | upset_plot.pdf | Set intersection plot of CP genes across all the input genome assemblies
assemblystat() | N50_N90.pdf | Assembly Size vs N50, N90 plots
assemblystat() | assemblyStats.txt | A simple text file with N50, N90, Assembly Size for each assembly
cp_summarize() | SummaryPlots.pdf | All the plots in a single pdf file

## A few example plots 

# `CP Gene Profile HeatMap`
<img src="https://user-images.githubusercontent.com/3212461/90596495-a946a980-e221-11ea-9904-88d5b5c66cc7.png" width="45%"></img>
<img src="https://user-images.githubusercontent.com/3212461/90596501-aba90380-e221-11ea-9cbb-062031eb8618.png" width="45%"></img> 
<img src="https://user-images.githubusercontent.com/3212461/90596505-ad72c700-e221-11ea-8340-db09e1061353.png" width="45%"></img> 
<img src="https://user-images.githubusercontent.com/3212461/90596508-aea3f400-e221-11ea-89a2-562aa408cbdf.png" width="45%"></img> 

# `Assembly Size vs N50 and N90 plots`

<img src="https://user-images.githubusercontent.com/3212461/90954281-a825ae80-e4a5-11ea-863d-47678a00aba1.png" width="45%"></img> 
<img src="https://user-images.githubusercontent.com/3212461/90954280-a6f48180-e4a5-11ea-93ad-908e0e339674.png" width="45%"></img> 
<img src="https://user-images.githubusercontent.com/3212461/90953985-dce43680-e4a2-11ea-91ba-750b72e731dd.png" width="45%"></img> 
<img src="https://user-images.githubusercontent.com/3212461/90953986-de156380-e4a2-11ea-8755-337b95ec4662.png" width="45%"></img> 

# `UpsetR plot` (orderby: freq vs degree)
<img src="https://user-images.githubusercontent.com/3212461/90954026-52500700-e4a3-11ea-9b1c-ad87b04c845b.png" width="45%"></img> 
<img src="https://user-images.githubusercontent.com/3212461/90124536-1f1ac300-dd93-11ea-9acc-9435b79a7f1c.png" width="45%"></img>

# `Contig Length Distribution Plots`
<img src="https://user-images.githubusercontent.com/3212461/90124507-17f3b500-dd93-11ea-9f37-6167ec79b8a1.png" width="30%"></img> 
<img src="https://user-images.githubusercontent.com/3212461/90124510-188c4b80-dd93-11ea-8609-1d3fbfc3ef43.png" width="30%"></img> 
<img src="https://user-images.githubusercontent.com/3212461/90954140-69dbbf80-e4a4-11ea-95ec-03c398269f3a.png" width="30%"></img> 
<img src="https://user-images.githubusercontent.com/3212461/90953981-d6ee5580-e4a2-11ea-97a4-fe30ddabbd77.png" width="30%"></img> 
<img src="https://user-images.githubusercontent.com/3212461/90953983-d81f8280-e4a2-11ea-81af-84668ff530a5.png" width="30%"></img>
<img src="https://user-images.githubusercontent.com/3212461/90953984-d8b81900-e4a2-11ea-9793-0e0026e7ba38.png" width="30%"></img> 

##### **Version**

version 2.1.1

- Modularised single function to multiple functions
- Added more flexibility to each function
- Changed the database from ARG-ANNOT to NCBI Bacterial AMR Reference Gene Database

version 2.1.0

- Changed the heatmap colors
- User can decide to download the ARG-annot database to desired location
- Both fasta folder and db location are to be provided for the package

# Community Guidelines

## How to Contribute

In general, you can contribute to this project by creating [issues](https://github.com/ramadatta/CPgeneProfiler/issues).
You are also welcome to contribute to the source code directly by forking the project, modifying the code, and creating [pull requests](https://github.com/ramadatta/CPgeneProfiler/pulls).
If you are not familiar with pull requests, check out [this post](https://guides.github.com/activities/forking/).
Please use clear and organized descriptions when creating issues and pull requests.

Please note that ``CPgeneProfiler`` is released with a [Contributor Code of Conduct](https://github.com/ramadatta/CPgeneProfiler/blob/master/Code_of_Conduct.md). By contributing to this project, you agree to abide by its terms.

## Bug Report and Support Request

You can use [issues](https://github.com/ramadatta/CPgeneProfiler/issues) to report bugs and seek support.
Before creating any new issues, please check for similar ones in the issue list first. 

## Citation

If you publish the results of CPgeneProfiler, please also cite the following software and the database:

Sridatta et al., (2020). CPgeneProfiler: A lightweight R package to profile the Carbapenamase genes from genome assemblies. Journal of Open Source Software, 5(54), 2473, https://doi.org/10.21105/joss.02473

Camacho, C., Coulouris, G., Avagyan, V., Ma, N., Papadopoulos, J., Bealer, K., & Madden, T. L. (2009). BLAST+: Architecture and applications. BMC Bioinformatics, 10(1), 421.doi:10.1186/1471-2105-10-421

Jake R Conway, Alexander Lex, Nils Gehlenborg, UpSetR: an R package for the visualization of intersecting sets and their properties, Bioinformatics, Volume 33, Issue 18, 15 September 2017, Pages 2938–2940, https://doi.org/10.1093/bioinformatics/btx364

NCBI Bacterial Antimicrobial Resistance Reference Gene Database (https://www.ncbi.nlm.nih.gov/bioproject/PRJNA313047)



