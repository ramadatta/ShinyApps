library(shiny)
library(data.table)
library(dplyr)
library(ggplot2)
library(gggenes)
library(RColorBrewer)
library(Cairo)

css <- "
#large .selectize-input { line-height: 40px; }
#large .selectize-dropdown { line-height: 30px; }"

ui <- shinyUI(fluidPage(
  theme = shinythemes::shinytheme("cerulean"),
  # Application title
  title = "gamR: Draw Gene Arrow Maps with gggenes",
  
  titlePanel(fluidRow(
    column(9, "gamR: Draw Gene Arrow Maps with gggenes package using R-Shiny"), #, style = "height:30px; background-color: skyblue;"
    # column(3, img(height = 105, width = 300, src = "logo_pcfruit.jpg")) # If adding any image
  )),
  
  tags$head(
    tags$meta(name="author", content="My Name"),
    tags$meta(name="creation_date", content="21/08/2020")),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      width = 3,
     
       # Horizontal line ----
      tags$hr(),
    
        # Input: Select a file ----
      fileInput(
        "file1",
        "Upload CSV File (see example file for format)",
        multiple = FALSE,
        accept = c("text/csv",
                   "text/comma-separated-values,text/plain",
                   ".csv")
      ),
      
      # Horizontal line ----
      tags$hr(),
      
      # Input: Select number of rows to display ----
      radioButtons(
        "disp",
        "Display",
        choices = c(
          Basic = "basic",
          "Align using a specific gene + add label" = "aligned",
          "Align using a specific gene + add label above" = "aligned_labelabv",
          "Align using a specific gene + add label above + order by gene pres/abs" = "aligned_labelabv_orderbysim",
          "Align using a specific gene + add label above + order by gene pres/abs + Distinctive Gene Set Structures" = "aligned_labelabv_orderbysim_uniqgeneset_gnomes"
        ),
        selected = "basic",
        inline = FALSE
      ),
      
      # Color Palette
      selectInput("colorselect", "Choose a Colorpalette (Custom: b25, c25, d25)", choices = c("b25", "c25", "d25","Accent", "Dark2", "Paired", "Pastel1", "Pastel2", "Set1", "Set2", "Set3")),
      
      
      # Horizontal line ----
      tags$hr(),
      
      textInput("textInputObject",
                c("Align by Gene Name"), value = "genD"),
      
      # Horizontal line ----
      tags$hr(),
      
      textInput(
        "textElementLine",
        c("choose \"skyblue\" or \"gray\" or \"lightgreen\" for Element Line"),
        value = "gray"
      ),
      
      # Horizontal line ----
      tags$hr(),
      
      # Input: Slider for the number of bins ----
      sliderInput(
        inputId = "labelsize",
        label = "Label Size",
        min = 1,
        max = 10,
        value = 3,
        step = 0.1
      ),
      
      # Horizontal line ----
      tags$hr(),
      
      # Input: Slider for the number of bins ----
      sliderInput(
        inputId = "arrowhead_height",
        label = "Arrowhead Height",
        min = 1,
        max = 10,
        value = 5,
        step = 0.1
      ),
      
      
      # Horizontal line ----
      tags$hr(),
      
      # Input: Slider for the number of bins ----
      sliderInput(
        inputId = "arrowhead_width",
        label = "Arrowhead Width",
        min = 1,
        max = 10,
        value = 3,
        step = 0.1
      ),
      
    # Button
    #  downloadButton("downloadData", "Download")
    #  downloadButton("downloadPlotpdf", "Download")
      
    ),    
    # Main panel for displaying outputs ----
    mainPanel(# Output: Data file ----

                fluidRow(
                  column(width = 9, tableOutput("contents")),
                  column(width = 3, h4("")),
                  column(width = 3, h4("")),
                  column(width = 3, h4("Error Message 1. Aesthetics must be either length 1 or the same as the data (1): y, xmin, xmax, fill and label --> Enter appropriate Gene Name in \"Align by Gene Name\"")),
                  column(width = 3, h4("Error Message 2. Viewport has zero dimension(s) --> Enter PDF Height, Width and Click Download button")),
                  column(width = 3, h4("Error Message 3. An error has occurred. Check your logs or contact the app author for clarification. --> Click Download button"))
                ),
              
                
                downloadButton('export'),
              # Horizontal line ----
              tags$hr(),
              fluidRow(column(width = 2, 
                              textInput("ggsaveHeight","Type PDF Height ",value = "11"),
              ),
              column(width = 2,
                              textInput("ggsaveWidth","Type PDF Width",value = "8.5")
                     )),
              
              plotOutput("gggenesPlot"),
              fluidRow(column(8, align = "left", h3("Download example dataset", a("here", href = "https://downgit.github.io/#/home?url=https://github.com/ramadatta/ShinyApps/blob/master/gggeneMapR/example_genes.csv"))))
              ),
    
),

 
))


