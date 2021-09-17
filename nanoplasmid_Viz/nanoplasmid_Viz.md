### Visualize the nanopore plasmids by their size and specific antibiotic specific gene classification

In AMR research, plasmid study is crucial to understand the mechanism of transfer of various antibiotic resistant genes. 
Especially, in a study where multiple species of bacteria are involved, rapid visusalization of the antibiotic resistant genes from the genomic assembly is often crucial. To this end, many tools exist to generate heatmap plots of resistant genes such as ....... 

But these packages are not designed for specifically visualizing the universe of circular plasmids and do not visualize plasmids with the specific resistant gene category. Additionally, the package has wraps the output from various tools so that the data can be visualized simply in a shiny app which makes first of its kind for viewing nanopore plasmids.

### Steps
  * pass fasta assemblies to do species assignment
  * run a mob_typer to know if the plasmid contains a replicon 
  * extract plasmid sequences between size (3Kb-1Mb)
  * plot according to specific category of resistant gene (Carbapenemases, ESBL, Disinfectants, Aminoglocides) with plasmid sizes on X axis and samples on Y axis
  * Give options in the shiny app to choose specific category of AMR genes
