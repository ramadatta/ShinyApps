#### This app takes in assemblies and check for replicon types and CP genes, ESBL genes and draw the replicon co-occurence network

#### Steps
  * Run Mob typer on each of the nanopore assembled contigs
  * Run BLAST of the assembled contigs on CP genes, ESBL gene database from resfinder
  * Combine both reports - sampleName - ContigName - Replicon - Replicase - Mobility - CP gene - ESBL gene 
  * Upset Plot CP genes, ESBL genes 
  * ggplot the co-occurence network of replicons in CP gene plasmids, ESBL gene plasmids
  * ggplot the cp gene facet grid
  * ggplot the esbl gene facet grid


