## Authorname: Prakki Sai Rama Sridatta
# Date: 23/12/2019

# This Shiny web app, filters the vcf file using Quality column as a slider input and outputs:
  # 1) Number of Indels + SNPs at particular position
  # 2) Number of SNPs at particular position
  # 3) A table of SNPs filtered according to Quality 

# Warning: Bigger VCF File sizes are processed slowly.

library(shiny)
library(data.table)
library(ggplot2)
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr)    # alternatively, this also loads %>%
library(vcfR)
library(stringr)

# Define UI for data upload app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Plot INDEL & SNP count in histogram sliding the BASE QUALITY Score below"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
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
      
      sliderInput("QUALInput",
                  "QUAL",
                  min = 1,
                  max = 10000,
                  value = c(25, 100))
      
    ),

    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Data file ----
      plotOutput("distPlot"),
      
      plotOutput("distPlot2"),
      
      tableOutput("contents")
      
    )
    
  )
)
options(shiny.maxRequestSize=100*1024^2)
# Define server logic to read selected file ----
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    req(input$file1)
    vcf <- fread(input$file1$datapath)
    
    filtered <-
      vcf %>%
      filter(QUAL >= input$QUALInput[1],
             QUAL <= input$QUALInput[2]
      )
    #   filtered
    ggplot(filtered, aes(POS)) + geom_histogram(bins=30) + ggtitle("SNPs + Indels")
  })
  
  # Plotting SNPs in VCF with Quality as a slider
  output$distPlot2 <- renderPlot({
    
    req(input$file1)
    vcf <- fread(input$file1$datapath)
    
    filtered <-
      vcf %>%
      filter(str_detect(INFO, "snp"),
             QUAL >= input$QUALInput[1],
             QUAL <= input$QUALInput[2]
      )
    #   filtered
    ggplot(filtered, aes(POS)) + geom_histogram(bins=30) + ggtitle("Only SNPs")
  })
 
  output$contents <- renderTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, head of that data file by default,
    # or all rows if selected, will be shown.
    
    req(input$file1)
    
    # when reading semicolon separated files,
    # having a comma separator causes `read.csv` to error
    tryCatch(
      {
        df <- fread(input$file1$datapath)
        filtered <-
          df %>%
          filter(QUAL >= input$QUALInput[1],
                 QUAL <= input$QUALInput[2]
          )
        filtered
      },
      error = function(e) {
        # return a safeError if a parsing error occurs
       stop(safeError(e))
      }
    )
    
    if(input$disp == "head") {
      return(head(filtered))
    }
    else {
      return(filtered)
    }
    
  })
  
}

# Create Shiny app ----
shinyApp(ui, server)
