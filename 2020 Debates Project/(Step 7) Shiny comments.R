##Shiny comments data

library(shiny)
library(rsconnect)
library(readr)


shiny.debates.all.comment <- subset(all_debates_comments, select =  c(textOriginal, authorDisplayName, date_posted, channel, debate))

write.csv(shiny.debates.all.comment,"C:\\Users...\\all_comments_for_shiny.csv", row.names = TRUE)

shiny.debates.all.comment1 <- read.csv("all_comments_for_shiny.csv", comment.char="#")


# Define UI for dataset viewer app ----
ui <- fluidPage(
  
  # App title ---- create a panel
  titlePanel("Data for YouTube Videos on 2020 Debates"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Text for providing a caption ----
      # Note: Changes made to the caption in the textInput control
      # are updated in the output area immediately as you type
      textInput(inputId = "caption",
                label = "Caption:",
                value = "Comments"),
      
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "Debate",
                  label = " Choose a Debate",
                  choices = unique(shiny.debates.all.comment1$Debate)),
      
      #Second input#
      selectInput(inputId = "Channel",
                  label = " Choose a Channel",
                  choices = unique(shiny.debates.all.comment1$Channel),
                  multiple = FALSE)),
    #individual text entries that can be combined into making a variable
    
    #next part allows users to specify number of observations they want
    # Input: Numeric entry for number of obs to view ----
    numericInput(inputId = "obs",
                 label = "Number of observations to view:",
                 min=0,
                 value = 6)
    
  ),
  
  # Main panel for displaying outputs ----
  mainPanel(
    
    # Output: Formatted text for caption ---- ***Caption was specified above
    h3(textOutput("caption", container = span)),
    
    # Output: Verbatim text for data summary ---- ***verbatim is a function name; returns the summary
    verbatimTextOutput("summary"),
    
    # Output: HTML table with requested number of observations ----
    tableOutput("view")
    
  )
)


server <- function(input, output) {
  
  
  datasetInput <- reactive({
    Debatefilter <- shiny.debates.all.comment1[shiny.debates.all.comment1$Debate == input$Debate,]
    print('hello')
    Channelfilter <- Debatefilter[Debatefilter$Channel %in% input$Channel,]
  })
  
  # Create caption ----
  # The output$caption is computed based on a reactive expression
  # that returns input$caption. When the user changes the
  # "caption" field:
  #
  # 1. This function is automatically called to recompute the output
  # 2. New caption is pushed back to the browser for re-display
  #
  # Note that because the data-oriented reactive expressions
  # below don't depend on input$caption, those expressions are
  # NOT called when input$caption changes
  output$caption <- renderText({
    input$caption
  })
  
  
  # Show the first "n" observations ----
  # The output$view depends on both the databaseInput reactive
  # expression and input$obs, so it will be re-executed whenever
  # input$dataset or input$obs is changed
  output$view <- renderTable({
    req(input$Debate)
    head(datasetInput(), n = input$obs)
  })
  
}


# Create Shiny app ----
shinyApp(ui, server)
