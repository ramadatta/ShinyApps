Tab1 <- tabPanel("First Tab",
                 selectInput("select",
                             "Choose one",
                             choices = letters[1:3],
                             selected = 'a'))

Tab2 <- tabPanel("Second Tab",
                 textOutput('mychoice'))