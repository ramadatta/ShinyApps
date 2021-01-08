#' Basic Plot function
#'
#' This function plots the most basic plot of the input data with gene arrows + directionality
#' @export
#'

basic <- function(colpal= "c25", arrowhead_height="5", arrowhead_width="3", element_line="gray", labelsize="3"){
 
  # ggplot(data(),aes(xmin = start,xmax = end,y = molecule,fill = gene)) +
  # geom_gene_arrow(arrowhead_height = unit(input$arrowhead_height, "mm"),
  #                 arrowhead_width = unit(input$arrowhead_width, "mm")) +
  # facet_wrap( ~ molecule, scales = "free", ncol = 1) +
  # scale_fill_brewer(palette = "Set3") +
  # theme_genes() + theme(panel.grid.major.y = element_line(colour = input$textElementLine))
  
if (colpal=="b25")
  {
    
    # b25 <- c("dodgerblue2", "#E31A1C","green4", "#6A3D9A","#FFFFE0","#FFFACD","#FAFAD2","#FFEFD5","#FFE4B5","#FFDAB9",
    #          "#EEE8AA","#F0E68C","#BDB76B","#FFFF00","#F08080","#FA8072", "darkturquoise", "green1", "yellow4", "yellow3", 
    #          "darkorange4", "brown", "#C0C0C0","#808080","#FF0000")
  
  # Define the number of colors you want
  nb.cols <- 300
  b25 <- colorRampPalette(brewer.pal(8, "Set3"))(nb.cols)
    
    ggplot(data(), aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(input$arrowhead_height, "mm"),
                      arrowhead_width = unit(input$arrowhead_width, "mm")) +
      facet_wrap(~ molecule, scales = "free", ncol = 1) +
      scale_fill_manual(values = b25) +
      theme_genes() + theme(panel.grid.major.y = element_line(colour = input$textElementLine))
  }
  else if (colpal=="d25")
      {
    
    d25 <- c("#FFFFFF","#C0C0C0","#808080","#FF0000","#800000","#FFFF00","#808000","#00FF00","#008000","#00FFFF","#008080",
             "#FFFFE0","#FFFACD","#FAFAD2","#FFEFD5","#FFE4B5","#FFDAB9","#EEE8AA","#F0E68C","#BDB76B","#FFFF00","#F08080","#FA8072",
             "#E9967A","#FFA07A","#FF7F50","#FF6347","#FF4500","#FFD700","#FFA500") 
    
    ggplot(data(), aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
      geom_gene_arrow(arrowhead_height = unit(input$arrowhead_height, "mm"),
                      arrowhead_width = unit(input$arrowhead_width, "mm")) +
      facet_wrap(~ molecule, scales = "free", ncol = 1) +
      scale_fill_manual(values = d25) +
    theme_genes() + theme(panel.grid.major.y = element_line(colour = input$textElementLine))
    }
else if (colpal=="c25")
  { 
  
  c25 <- c("dodgerblue2", "#E31A1C","green4", "#6A3D9A", "#FF7F00", "LavenderBlush4", "gold1", "skyblue2", 
           "#FB9A99", "palegreen2", "#CAB2D6", "#FDBF6F", "gray70", "khaki2", "maroon", "orchid1", 
           "deeppink1", "blue1", "steelblue4", "darkturquoise", "green1", "yellow4", "yellow3", "darkorange4", "brown" )
  
  ggplot(data(), aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
    geom_gene_arrow(arrowhead_height = unit(input$arrowhead_height, "mm"),
                    arrowhead_width = unit(input$arrowhead_width, "mm")) +
    facet_wrap(~ molecule, scales = "free", ncol = 1) +
    scale_fill_manual(values = c25) +
  theme_genes() + theme(panel.grid.major.y = element_line(colour = input$textElementLine))
  }
  else {
  ggplot(data(), aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = strand)) +
    geom_gene_arrow(arrowhead_height = unit(input$arrowhead_height, "mm"),
                    arrowhead_width = unit(input$arrowhead_width, "mm")) +
    facet_wrap(~ molecule, scales = "free", ncol = 1) +
    scale_fill_brewer(palette = colpal) +
    theme_genes() + theme(panel.grid.major.y = element_line(colour = input$textElementLine))
  }
}