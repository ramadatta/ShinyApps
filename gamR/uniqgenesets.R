#' uniqgenesets function
#'
#' This function plots the gene arrow map with directionality, aligns the genes, add labels above the gene arrow,
#' order gene sets based on presence/absence and generate a gene arrow map for distinct gene sets
#' @export
#'

uniqgenesets <- function(colpal, geneName, arrowhead_height, arrowhead_width, element_line, labelsize){
  
  dummies <- make_alignment_dummies(data(),aes(xmin = start, xmax = end, y = molecule, id = gene ), on = geneName)
  
  updown_stream_coords <- data()
  
  # Creating a presence/absence matrix for example genes
  PA_matrix <-
    as.data.frame(with(updown_stream_coords, table(molecule, gene)) > 0L) +
    0L
  PA_matrix
  
  # Sorting the presence/absence matrix for example genes
  sorted_PA_matrix <-
    PA_matrix[do.call(order, as.data.frame(PA_matrix)), ]
  sorted_PA_matrix
  sorted_genomes <- row.names(sorted_PA_matrix)
  sorted_genomes
  
  distinct_sorted_PA_matrix <- distinct(sorted_PA_matrix)
  distinct_sorted_PA_matrix
  sorted_genomes <- row.names(distinct_sorted_PA_matrix)
  sorted_genomes
  
  # Creating sorted_dummies and sorted_example_genes which the final output figure should reflect
  #sorted_dummies <- dummies[order(unlist(sapply(dummies$molecule, function(x) which(sorted_genomes == x)))),]
  sorted_dummies <-
    dummies[dummies$molecule %in% sorted_genomes, ]
  sorted_dummies
  dummies
  
  #sorted_example_genes <- example_genes[order(unlist(sapply(example_genes$molecule, function(x) which(sorted_genomes == x)))),]
  #sorted_example_genes <- example_genes[example_genes$molecule %in% sorted_genomes, ]
  
  sorted_example_genes <- updown_stream_coords[updown_stream_coords$molecule %in% sorted_genomes, ]
  sorted_example_genes
  
  # Convert molecule variable to a factor -- author
  sorted_example_genes$molecule <-
    factor(sorted_example_genes$molecule,
           levels = unique(sorted_example_genes$molecule))
 # sorted_example_genes
  sorted_dummies$molecule <-
    factor(sorted_dummies$molecule,
           levels = unique(sorted_dummies$molecule))
 # sorted_dummies
  
  # p_aligned_labelabv_orderbysim_uniqgeneset_gnomes <-
  #   ggplot(sorted_example_genes, aes(xmin = start, xmax = end, y = factor(molecule), fill = gene)) +
  #   geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
  #   geom_blank(data = sorted_dummies) +
  #   facet_wrap( ~ molecule, scales = "free", ncol = 1) +
  #   scale_fill_manual(values = c25) +
  #   theme_genes()  %+replace% theme(panel.grid.major.y = element_line(colour = input$textElementLine), legend.position = "none") +
  #   geom_text(data = sorted_example_genes %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4, size = labelsize )
  
  # print(p_aligned_labelabv_orderbysim_uniqgeneset_gnomes)
  
  #sorted_example_genes$strand <- sorted_example_genes$strand == "forward"
  
  
  if (colpal=="c25") {
    
    c25 <- c("dodgerblue2", "#E31A1C","green4", "#6A3D9A", "#FF7F00", "LavenderBlush4", "gold1", "skyblue2", 
             "#FB9A99", "palegreen2", "#CAB2D6", "#FDBF6F", "gray70", "khaki2", "maroon", "orchid1", 
             "deeppink1", "blue1", "steelblue4", "darkturquoise", "green1", "yellow4", "yellow3", "darkorange4", "brown" )
    
    p_aligned_labelabv_orderbysim_uniqgeneset_gnomes <- ggplot(sorted_example_genes, aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = sorted_dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_manual(values = c25) +
      theme_genes()  %+replace% theme(panel.grid.major.y = element_line(colour = input$textElementLine), legend.position = "none") +
      geom_text(data = sorted_example_genes %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4, size = labelsize)
    
  }
  else if (colpal=="b25") {
    
    # b25 <- c("dodgerblue2", "#E31A1C","green4", "#6A3D9A","#FFFFE0","#FFFACD","#FAFAD2","#FFEFD5","#FFE4B5","#FFDAB9",
    #          "#EEE8AA","#F0E68C","#BDB76B","#FFFF00","#F08080","#FA8072", "darkturquoise", "green1", "yellow4", "yellow3", 
    #          "darkorange4", "brown", "#C0C0C0","#808080","#FF0000")
   
    
     # Define the number of colors you want
    nb.cols <- 300
    b25 <- colorRampPalette(brewer.pal(8, "Set3"))(nb.cols)
    
    p_aligned_labelabv_orderbysim_uniqgeneset_gnomes <- ggplot(sorted_example_genes, aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = sorted_dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_manual(values = b25) +
      theme_genes()  %+replace% theme(panel.grid.major.y = element_line(colour = input$textElementLine), legend.position = "none") +
      geom_text(data = sorted_example_genes %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  }
  else if (colpal=="d25") {
    
    d25 <- c("#FFFFFF","#C0C0C0","#808080","#FF0000","#800000","#FFFF00","#808000","#00FF00","#008000","#00FFFF","#008080",
             "#FFFFE0","#FFFACD","#FAFAD2","#FFEFD5","#FFE4B5","#FFDAB9","#EEE8AA","#F0E68C","#BDB76B","#FFFF00","#F08080","#FA8072",
             "#E9967A","#FFA07A","#FF7F50","#FF6347","#FF4500","#FFD700","#FFA500") 
    
    p_aligned_labelabv_orderbysim_uniqgeneset_gnomes <- ggplot(sorted_example_genes, aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = sorted_dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_manual(values = d25) +
      theme_genes()  %+replace% theme(panel.grid.major.y = element_line(colour = input$textElementLine), legend.position = "none") +
      geom_text(data = sorted_example_genes %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  }
  
  else if (colpal=="Set3") {
    
    p_aligned_labelabv_orderbysim_uniqgeneset_gnomes <- ggplot(sorted_example_genes, aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = sorted_dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_brewer(palette = "Set3") +
      theme_genes()  %+replace% theme(panel.grid.major.y = element_line(colour = input$textElementLine), legend.position = "none") +
      geom_text(data = sorted_example_genes %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  }
  else if (colpal=="Set2") {
    
    p_aligned_labelabv_orderbysim_uniqgeneset_gnomes <- ggplot(sorted_example_genes, aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = sorted_dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_brewer(palette = "Set2") +
      theme_genes()  %+replace% theme(panel.grid.major.y = element_line(colour = input$textElementLine), legend.position = "none") +
      geom_text(data = sorted_example_genes %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  }
  else if (colpal=="Set1") {
    
    p_aligned_labelabv_orderbysim_uniqgeneset_gnomes <- ggplot(sorted_example_genes, aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = sorted_dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_brewer(palette = "Set1") +
      theme_genes()  %+replace% theme(panel.grid.major.y = element_line(colour = input$textElementLine), legend.position = "none") +
      geom_text(data = sorted_example_genes %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  }
  else if (colpal=="Accent") {
    
    p_aligned_labelabv_orderbysim_uniqgeneset_gnomes <- ggplot(sorted_example_genes, aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = sorted_dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_brewer(palette = "Accent") +
      theme_genes()  %+replace% theme(panel.grid.major.y = element_line(colour = input$textElementLine), legend.position = "none") +
      geom_text(data = sorted_example_genes %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  }
  else if (colpal=="Dark2") {
    
    p_aligned_labelabv_orderbysim_uniqgeneset_gnomes <- ggplot(sorted_example_genes, aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = sorted_dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_brewer(palette = "Dark2") +
      theme_genes()  %+replace% theme(panel.grid.major.y = element_line(colour = input$textElementLine), legend.position = "none") +
      geom_text(data = sorted_example_genes %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  }
  else if (colpal=="Paired") {
    
    p_aligned_labelabv_orderbysim_uniqgeneset_gnomes <- ggplot(sorted_example_genes, aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = sorted_dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_brewer(palette = "Paired") +
      theme_genes()  %+replace% theme(panel.grid.major.y = element_line(colour = input$textElementLine), legend.position = "none") +
      geom_text(data = sorted_example_genes %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  } 
  else if (colpal=="Pastel1") {
    
    p_aligned_labelabv_orderbysim_uniqgeneset_gnomes <- ggplot(sorted_example_genes, aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = sorted_dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_brewer(palette = "Pastel1") +
      theme_genes()  %+replace% theme(panel.grid.major.y = element_line(colour = input$textElementLine), legend.position = "none") +
      geom_text(data = sorted_example_genes %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  } 
  else if (colpal=="Pastel2") {
    
    p_aligned_labelabv_orderbysim_uniqgeneset_gnomes <- ggplot(sorted_example_genes, aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = sorted_dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_brewer(palette = "Pastel2") +
      theme_genes()  %+replace% theme(panel.grid.major.y = element_line(colour = input$textElementLine), legend.position = "none") +
      geom_text(data = sorted_example_genes %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  } 
  
  
  
}