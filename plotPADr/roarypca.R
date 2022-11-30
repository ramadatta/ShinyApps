#' PCA Plot function
#'
#' This function plots the most basic plot of the input data with gene arrows + directionality
#' @export
#'

roarypca <- function(dataset,meta_dataset,pc_1,pc_2,datapoint_shape,datapoint_color,datapoint_alpha,pca_scale){
  
  Annotated_Gene_PA_df_t <- dataset %>% 
    remove_rownames %>% 
    column_to_rownames(var="Gene") %>% as.data.frame() %>% t()
  
  options(ggrepel.max.overlaps = 10)
  
  res.pca.scaleF <- prcomp(Annotated_Gene_PA_df_t, scale = pca_scale)
  
  # With the fviz_pca_ind function, we cannot have two categorical variables: one point shape and one fill color.
  # So we modify the output from fviz_pca_ind(), so you would need to take out the data from the results, and 
  # plot it again using ggplot2:
  
  #######------------Multiple labels---------###########
  
  pc_1 <- as.numeric(pc_1)
  pc_2 <- as.numeric(pc_2)
  
  basic_plot <- fviz_pca_ind(res.pca.scaleF, label="var", axes=c(pc_1, pc_2)) # Adding var gives nicer legend symbols than none
  
  # Combine the Matrix with Metadata
  basic_plot_with_meta <- left_join(basic_plot$data, meta_dataset, by = c("name" = "Sample"))
  #View((basic_plot_with_meta))
  
  basic_plot_with_meta_edited <- basic_plot_with_meta %>% select(-coord,-cos2,-contrib)
  
  #d <- highlight_key(basic_plot_with_meta_edited , ~name)  
  
  ggplot(basic_plot_with_meta_edited,
                  aes_string(x="x",y="y",col=datapoint_color,shape=datapoint_shape)) +
             geom_point(size=2, alpha = datapoint_alpha) +
             theme_bw() +
             # stat_ellipse(level=0.99,linetype=2) +
             ggtitle(paste0("PCA plot of Samples based on gene presence/absence")) +
              xlab(paste0("PC",pc_1)) +
              ylab(paste0("PC",pc_2)) 
}