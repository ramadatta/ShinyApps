#' labelabv function
#'
#' This function plots the gene arrow map with directionality, aligns the genes and add labels above the gene arrow as per the user selection
#' @export
#'

labelabv <- function(colpal="c25", geneName="genD", arrowhead_height="5", arrowhead_width="3", element_line="gray", labelsize="3"){
  
dummies <- make_alignment_dummies(data(),aes(xmin = start, xmax = end, y = molecule,id = gene),on = geneName)
  
  if (colpal=="c25") {
    
    c25 <- c("dodgerblue2", "#E31A1C","green4", "#6A3D9A", "#FF7F00", "LavenderBlush4", "gold1", "skyblue2", 
             "#FB9A99", "palegreen2", "#CAB2D6", "#FDBF6F", "gray70", "khaki2", "maroon", "orchid1", 
             "deeppink1", "blue1", "steelblue4", "darkturquoise", "green1", "yellow4", "yellow3", "darkorange4", "brown" )
    
    p_aligned_labelabv <- ggplot(data(), aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_manual(values = c25) +
      theme_genes() + theme(panel.grid.major.y = element_line(colour = element_line), legend.position = "none") +
      geom_text(data = data() %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4, size = labelsize)
    
  }
  else if (colpal=="b25") {
    
    # b25 <- c("dodgerblue2", "#E31A1C","green4", "#6A3D9A","#FFFFE0","#FFFACD","#FAFAD2","#FFEFD5","#FFE4B5","#FFDAB9",
    #          "#EEE8AA","#F0E68C","#BDB76B","#FFFF00","#F08080","#FA8072", "darkturquoise", "green1", "yellow4", "yellow3", 
    #          "darkorange4", "brown", "#C0C0C0","#808080","#FF0000")
    
    # Define the number of colors you want
    nb.cols <- 300
    b25 <- colorRampPalette(brewer.pal(8, "Set3"))(nb.cols)
    
    p_aligned_labelabv <- ggplot(data(), aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_manual(values = b25) +
      theme_genes() + theme(panel.grid.major.y = element_line(colour = element_line), legend.position = "none") +
      geom_text(data = data() %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  }
  else if (colpal=="d25") {
    
    d25 <- c("#FFFFFF","#C0C0C0","#808080","#FF0000","#800000","#FFFF00","#808000","#00FF00","#008000","#00FFFF","#008080",
             "#FFFFE0","#FFFACD","#FAFAD2","#FFEFD5","#FFE4B5","#FFDAB9","#EEE8AA","#F0E68C","#BDB76B","#FFFF00","#F08080","#FA8072",
             "#E9967A","#FFA07A","#FF7F50","#FF6347","#FF4500","#FFD700","#FFA500") 
    
    p_aligned_labelabv <- ggplot(data(), aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_manual(values = d25) +
      theme_genes() + theme(panel.grid.major.y = element_line(colour = element_line), legend.position = "none") +
      geom_text(data = data() %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  }
  
  else if (colpal=="Set3") {
    
    p_aligned_labelabv <- ggplot(data(), aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_brewer(palette = "Set3") +
      theme_genes() + theme(panel.grid.major.y = element_line(colour = element_line), legend.position = "none") +
      geom_text(data = data() %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  }
  else if (colpal=="Set2") {
    
    p_aligned_labelabv <- ggplot(data(), aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_brewer(palette = "Set2") +
      theme_genes() + theme(panel.grid.major.y = element_line(colour = element_line), legend.position = "none") +
      geom_text(data = data() %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  }
  else if (colpal=="Set1") {
    
    p_aligned_labelabv <- ggplot(data(), aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_brewer(palette = "Set1") +
      theme_genes() + theme(panel.grid.major.y = element_line(colour = element_line), legend.position = "none") +
      geom_text(data = data() %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  }
  else if (colpal=="Accent") {
    
    p_aligned_labelabv <- ggplot(data(), aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_brewer(palette = "Accent") +
      theme_genes() + theme(panel.grid.major.y = element_line(colour = element_line), legend.position = "none") +
      geom_text(data = data() %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  }
  else if (colpal=="Dark2") {
    
    p_aligned_labelabv <- ggplot(data(), aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_brewer(palette = "Dark2") +
      theme_genes() + theme(panel.grid.major.y = element_line(colour = element_line), legend.position = "none") +
      geom_text(data = data() %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  }
  else if (colpal=="Paired") {
    
    p_aligned_labelabv <- ggplot(data(), aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_brewer(palette = "Paired") +
      theme_genes() + theme(panel.grid.major.y = element_line(colour = element_line), legend.position = "none") +
      geom_text(data = data() %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  } 
  else if (colpal=="Pastel1") {
    
    p_aligned_labelabv <- ggplot(data(), aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_brewer(palette = "Pastel1") +
      theme_genes() + theme(panel.grid.major.y = element_line(colour = element_line), legend.position = "none") +
      geom_text(data = data() %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  } 
  else if (colpal=="Pastel2") {
    
    p_aligned_labelabv <- ggplot(data(), aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(arrowhead_height, "mm"), arrowhead_width = unit(arrowhead_width, "mm")) +
      geom_blank(data = dummies, aes(forward = 1)) +
      facet_wrap( ~ molecule, scales = "free", ncol = 1) +
      scale_fill_brewer(palette = "Pastel2") +
      theme_genes() + theme(panel.grid.major.y = element_line(colour = element_line), legend.position = "none") +
      geom_text(data = data() %>% mutate(start = (start + end) / 2), aes(x = start, label = gene), nudge_y = 0.4,size = labelsize)
    
  } 
  
  
  
}