##Shiny debate data

library(shiny)
library(rsconnect)
library(readr)


##Put the data into csv for upload with shiny
df.all.d1.table <- subset(df.all.d1, select =  -c(Video_ID, Description.1, type, debate))

df.all.d1.table$View_Count <- as.numeric(df.all.d1.table$View_Count)
df.all.d1.table$Like_Count <- as.numeric(df.all.d1.table$Like_Count)
df.all.d1.table$Dislike_Count <- as.numeric(df.all.d1.table$Dislike_Count)
df.all.d1.table$Comment_Count <- as.numeric(df.all.d1.table$Comment_Count)


df.all.d2.table <- subset(df.all.d2, select =  -c(Video_ID, Description.1, type, debate))

df.all.d2.table$View_Count <- as.numeric(df.all.d2.table$View_Count)
df.all.d2.table$Like_Count <- as.numeric(df.all.d2.table$Like_Count)
df.all.d2.table$Dislike_Count <- as.numeric(df.all.d2.table$Dislike_Count)
df.all.d2.table$Comment_Count <- as.numeric(df.all.d2.table$Comment_Count)

df.all.vp.table <- subset(df.all.vp, select =  -c(Video_ID, Description.1, type, debate))

df.all.vp$View_Count <- as.numeric(df.all.vp$View_Count)
df.all.vp$Like_Count <- as.numeric(df.all.vp$Like_Count)
df.all.vp$Dislike_Count <- as.numeric(df.all.vp$Dislike_Count)
df.all.vp$Comment_Count <- as.numeric(df.all.vp$Comment_Count)

write.csv(df.all.d1.table,"C\\users:....\\debate1_for_shiny.csv", row.names = TRUE)
debate1_for_shiny <- read.csv("debate1_for_shiny.csv", comment.char="#")

write.csv(df.all.d2.table,"C\\users:....\\debate2_for_shiny.csv", row.names = TRUE)
debate2_for_shiny <- read.csv("debate2_for_shiny.csv", comment.char="#")

write.csv(df.all.vp.table,"C\\users:....\\debate_vp_for_shiny.csv", row.names = TRUE)
debate_vp_for_shiny <- read.csv("debate_vp_for_shiny.csv", comment.char="#")


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
                value = "Details"),
      
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "dataset",
                  label = "Choose a dataset:",
                  choices = c("1st Presidential Debate", "Vice Presidential Debate", 
                              "2nd Presidential Debate")),
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
)

#Make sure inputs match output (i.e. "obs" in inputID is what it is called in output below)
# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  
  # Return the requested dataset ----
  # By declaring datasetInput as a reactive expression we ensure
  # that:
  #
  # 1. It is only called when the inputs it depends on changes
  # 2. The computation and result are shared by all the callers,
  #    i.e. it only executes a single time
  datasetInput <- reactive({
    switch(input$dataset,
           "1st Presidential Debate" =debate1_for_shiny,
           "Vice Presidential Debate"=debate_vp_for_shiny,
           "2nd Presidential Debate"=debate2_for_shiny)
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
    req(input$dataset)
    head(datasetInput())
  })
  
}


# Create Shiny app ----
shinyApp(ui, server)


