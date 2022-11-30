

# Reference
# https://github.com/MatePocs/rshiny_apps/blob/main/data_analyser/app.R

not_sel <- "Not Selected"

main_page <- tabPanel(
  title = "PCA",
  titlePanel("Control Panel"),
  sidebarLayout(
    sidebarPanel(
      title = "Inputs",
      fileInput("data_tab_input", "Upload Roary .Rtab file (size limit: 50Mb)", accept = c("text/csv",
                                                                                           "text/comma-separated-values,text/plain",
                                                                                           ".csv")),
      fileInput("metadata_tab_input", "Upload Metadata", accept = c("text/csv",
                                                                      "text/comma-separated-values,text/plain",
                                                                      ".csv")),
      selectInput("pc_1","Select a Principal Component 1", choices = c(1:6), selected=1),
      selectInput("pc_2","Select a Principal Component 2", choices = c(1:6), selected=2),
      selectInput("datapoint_shape","Select a Column for Shape", choices = c(not_sel)),
      selectInput("datapoint_color","Select a Column for Color", choices = c(not_sel)),
      sliderInput("datapoint_alpha", "Alpha", min = 0.1, max = 1, value = 0.3, step = 0.1),
      radioButtons("pca_scale", label = "Scale", inline = TRUE, choices = c("TRUE"=1, "FALSE"=0), selected = "FALSE"),
      actionButton("run_button", "Run Analysis", icon = icon("play"))
    ),
    mainPanel(
      tabsetPanel(
        tabPanel(
          title = "Roary Data",
          tableOutput("table_1")
        ),
          tabPanel(
            title = "Roary MetaData",
            tableOutput("table_2")
          ),
      tabPanel(
          title = "Static PCA Plot",
          plotOutput("plot_1")
        ),
      tabPanel(
        title = "Interactive PCA Plot",
        plotlyOutput("plot_2")
      )
      )
    )
  )
)  
  

about_page <- tabPanel(
  title = "About",
  titlePanel("About"),
  "Author: Prakki Sai Rama Sridatta",
  br(),
  "Senior Bioinformatician",
  br(),
  "National Center for Infectious Diseases",
  br(),
  "Tan Tock Seng Hospital",
  br(),
  "Singapore",
  br(),
  br(),
  br(),
  "Created this app using R Shiny",
  br(),
  "September 17th 2021"
)

navbarPage(
  title = "RoaryPCA",
  theme = shinytheme('united'),
  main_page,
  about_page
  
  
)
