# Author : Prakki Sai Rama Sridatta
# Date: December 27th, 2019
# This is a Shiny web application to find various Mean (arithmatic, geometric and harmonic) and Median 

library(shiny)
library(data.table)
library(dplyr)
library(psych)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Find Arithmatic, Geometric, Harmonic Mean and Median at one shot"),

      # Sidebar layout with input and output definitions ----
   sidebarLayout(
     
     # Sidebar panel for inputs ----
     sidebarPanel(
       
       # Horizontal line ----
       tags$hr(),
       # Input: Select a file ----
       fileInput("file1", "Choose CSV File",
                 multiple = FALSE,
                 accept = c("text/csv",
                            "text/comma-separated-values,text/plain",
                            ".csv")),
       
       # Horizontal line ----
       tags$hr(),
       
       # Input: Select number of rows to display ----
       radioButtons("disp", "Display",
                    choices = c(Head = "head",
                                All = "all"),
                    selected = "head", inline = TRUE),
       
       # Horizontal line ----
       tags$hr(),
       
       # Button
       downloadButton("downloadData", "Download")
       
     ),
     
     # Main panel for displaying outputs ----
     mainPanel(
       
       # Output: Data file ----
    #   plotOutput("distPlot"),
       
     #  plotOutput("distPlot2"),
       
       tableOutput("contents")
       
     )
   ),

   fluidRow(column(8, align="left",h3("example dataset", a("here", href="https://github.com/ramadatta/ShinyApps/blob/master/HAG_Mean_Med/test.txt")))) 

)
# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$contents <- renderTable({
    
    req(input$file1)
    
    dd <- fread(input$file1$datapath)

      summarydf <- 
      dd %>% 
      group_by(V1) %>% 
      summarise(Arith.Mean=mean(V2), Geom.Mean=exp(mean(log(V2))), Harmonic.Mean=harmonic.mean(V2), Median=median(V2))
      
       if(input$disp == "head") {
        return(head(summarydf))
      }
      else {
        return(summarydf)
      }
      })
  
  sample_data <- reactive({
    
    req(input$file1)
    
    dd <- fread(input$file1$datapath)
    
    summarydf <- 
      dd %>% 
      group_by(V1) %>% 
      summarise(Arith.Mean=mean(V2), Geom.Mean=exp(mean(log(V2))), Harmonic.Mean=harmonic.mean(V2), Median=median(V2))
    })
  # Downloadable csv of selected dataset ----
 
  output$downloadData <- downloadHandler(
    filename = function() {
      paste('data-', Sys.Date(), '.txt', sep='')
    },
    content = function(file) {
      write.table(sample_data(), file, sep = "\t", row.names = FALSE)
    }
  )
  
}

# Run the application 
shinyApp(ui = ui, server = server)

