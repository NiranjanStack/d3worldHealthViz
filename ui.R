library(shiny)

shinyUI=navbarPage("Title", 
                  tabPanel("Countries", 
                           fluidPage(
                             
                             # Load D3.js
                             tags$head(
                               tags$script(src = 'http://d3js.org/d3.v3.min.js')
                             ),
                             
                             # Application title
                             titlePanel('D3 Network of Countries'),
                             p('Visualization of Countries with their continents.'),
                             
                             # Sidebar with a slider input for node opacity
                             sidebarLayout(
                               sidebarPanel(
                                 sliderInput('slider', label = 'Node Opacity',
                                             min = 0, max = 1, step = 0.01, value = 0.75
                                 )
                               ),
                               
                               # Show network graph
                               mainPanel(
                                 htmlOutput('networkPlot')
                               )
                             )
                           )
                           ),
                  tabPanel("Adult Mortality Rate",
                           fluidPage(
                             titlePanel("Adult Mortality Rate"),
                             p(span("To see the code, data & visualize the plot online",style="color:red"),
                               a("click here.",href="https://plot.ly/~niranjana88/133/_3d-scatter-plot-population-proportion-vs-adult-mortality-rate-in-various-countri/")),
                             
                             mainPanel(
                               plotlyOutput("dist2Plot")
                             )
                           )
                  ),
                  tabPanel("Tuberclosis Incidents",
                           fluidPage(
                             titlePanel("Tuberculosis Incidents"),
                             p(span("To download the visualization code",style="color:red"),
                               a("click here.",href="https://plot.ly/135/~niranjana88/")),
                             
                             mainPanel(
                                 plotlyOutput("distPlot")
                               )
                           ))
                  
                   )