# Define server logic required to draw a histogram
server <- function(input, output) {

   options(shiny.maxRequestSize = 50*1024^2) #would increase the limit to 30MB.
  
  source('basic.R',local = TRUE)  
  source('alignbygene.R',local = TRUE)  
  source('labelabv.R',local = TRUE) 
  source('orderbysim.R',local = TRUE) 
  source('uniqgenesets.R',local = TRUE) 
 # source('colorpalette.R',local = TRUE) 
  
  
  options(shiny.usecairo = TRUE)
  
  data <- reactive({
    req(input$file1) ## ?req #  require that the input is available
    
    df <- fread(input$file1$datapath)
    df$strand <- df$strand == "forward"
    return(df)
  })
  
  output$contents <- renderTable({
       head(data())
    
  })
  
  output$gggenesPlot <- renderPlot({
    if (input$disp == "basic") {
      p_basic <- basic(colpal= input$colorselect, arrowhead_height = input$arrowhead_height, arrowhead_width = input$arrowhead_width,  element_line = input$textElementLine)
      return(p_basic)
    }
    else if (input$disp == "aligned") {
    
      p_aligned1 <- alignbygene(colpal= input$colorselect, gene = input$textInputObject, 
                                arrowhead_height = input$arrowhead_height, arrowhead_width = input$arrowhead_width,
                                element_line = input$textElementLine) # pass color palette, genetoalign, arrowhead_height, arrowhead_width, element line
      return(p_aligned1)
      
    }
    else if (input$disp == "aligned_labelabv") {
      
      p_aligned_labelabv <- labelabv(colpal= input$colorselect, gene = input$textInputObject, arrowhead_height = input$arrowhead_height, 
                                     arrowhead_width = input$arrowhead_width, element_line = input$textElementLine, labelsize = input$labelsize ) # pass color palette, genetoalign, arrowhead_height, arrowhead_width, element line
      return(p_aligned_labelabv)
    }
    else if (input$disp == "aligned_labelabv_orderbysim") {
      
      p_aligned_labelabv_orderbysim <- orderbysim(colpal= input$colorselect, gene = input$textInputObject, 
                                     arrowhead_height = input$arrowhead_height, arrowhead_width = input$arrowhead_width,
                                     element_line = input$textElementLine, labelsize = input$labelsize ) 
      
      return(p_aligned_labelabv_orderbysim)
    }
    else if (input$disp == "aligned_labelabv_orderbysim_uniqgeneset_gnomes") {
      
      p_aligned_labelabv_orderbysim_uniqgeneset_gnomes <- uniqgenesets(colpal= input$colorselect, gene = input$textInputObject, 
                                                  arrowhead_height = input$arrowhead_height, arrowhead_width = input$arrowhead_width,
                                                  element_line = input$textElementLine, labelsize = input$labelsize ) 
      
      return(p_aligned_labelabv_orderbysim_uniqgeneset_gnomes)
    
    }
  })
  
  # Downloadable csv of selected dataset ----
  
  # output$downloadData <- downloadHandler(
  #   filename = function() {
  #     paste('data-', Sys.Date(), '.txt', sep = '')
  #   },
  #   content = function(file) {
  #     write.table(sample_data(), file, sep = "\t", row.names = FALSE)
  #   }
  # )
  
  # Downloadable image of the gene map ----
  
  output$export = downloadHandler(
    filename = function() {"plots.pdf"},
    content = function(file) {
     # ggsave(file, device = "pdf", width=input$ggsaveWidth, height=input$ggsaveHeight)
      ggsaveWidth=as.numeric(input$ggsaveWidth)
      ggsaveHeight=as.numeric(input$ggsaveHeight)
      ggsave(file, device = "pdf", width=ggsaveWidth, height=ggsaveHeight, limitsize = FALSE)
      }
  )

}
