library(shiny)

shinyUI(pageWithSidebar(

                                          # Application title
    headerPanel("Foldchange Boxplots, 25kb 5' and 3' of all centromeres"),

                                          # Sidebar with a slider input for number of observations
    sidebarPanel(

      selectInput("dataset1", "Select a  Dataset",
                  choices = c(
                    "PCR WT"="pw",
                    "NO PCR WT"="rw"
                    )),

      checkboxInput(inputId = "IN",  label = "Overlay Mutant?",  value = FALSE)

      ),
  
                                        # Show a plot of the generated distribution
  mainPanel(
    plotOutput("boxPlot1")
#    plotOutput("boxPlot2")
    )
  ))
