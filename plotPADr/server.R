#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

source("Global.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  options(shiny.maxRequestSize = 50*1024^2) #would increase the limit to 50MB.
  
  source('roarypca.R',local = TRUE) 
  

    data_input <- reactive({
    req(input$data_tab_input)
    fread(input$data_tab_input$datapath)
  })
    
    metadata_input <- reactive({
      req(input$metadata_tab_input)
      fread(input$metadata_tab_input$datapath)
    })
    
    observeEvent(metadata_input(),{
      choices <- c("Not Selected",names(metadata_input()))
      updateSelectInput(inputId = "datapoint_shape", choices = choices)
      updateSelectInput(inputId = "datapoint_color", choices = choices)
    })
    
    # first 10 lines of rawdata 
    table_1 <- eventReactive(input$run_button,{
      data_input() %>% head()
      })
    
    output$table_1 <- renderTable(table_1())
    
    # first 10 lines of metadata 
    table_2 <- eventReactive(input$run_button,{
      metadata_input() %>% head()
    })
    
    output$table_2 <- renderTable(table_2())
    
# Note to self: When giving input as choices from the GUI, passing TRUE/FALSE will result in an error because they are passed in as strings with quotes "TRUE"/"FALSE" in the above case. Whereas we need to pass TRUE or FALSE as boolean values.
   
    #plot
    plot_1 <- eventReactive(input$run_button,{
      roarypca(data_input(), metadata_input(), 
               input$pc_1, input$pc_2,
               input$datapoint_shape, input$datapoint_color, input$datapoint_alpha, 
               #pca_scale
               as.logical(as.numeric(input$pca_scale)) )
      })
    
    output$plot_1 <- renderPlot(plot_1())
    output$plot_2 <- renderPlotly(plot_1())
    
    
    

    
})
