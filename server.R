# Load packages
library(RCurl)
library(d3Network)
library("ggplot2")
library("plotly")
library("plyr")
library("gdata")

# Load data once
#URL <- "https://raw.githubusercontent.com/NiranjanStack/d3worldHealthViz/master/10countries.json"
MisJson <- getURL(URL, ssl.verifypeer = FALSE)

#df <- read.table("dataset_who.csv", header=TRUE, sep=",")

# Convert JSON arrays into data frames
MisLinks <- JSONtoDF(jsonStr = MisJson, array = "links")
MisNodes <- JSONtoDF(jsonStr = MisJson, array = "nodes")

# Create individual ID
MisNodes$ID <- 1:nrow(MisNodes)

#### Shiny ####
shinyServer(function(input, output) {
  
  output$networkPlot <- renderPrint({
    d3ForceNetwork(Nodes = MisNodes,
                   Links = MisLinks,
                   Source = "source", Target = "target",
                   Value = "value", NodeID = "name",
                   Group = "group", width = 800, height = 450,
                   opacity = input$slider, standAlone = FALSE,
                   parentElement = '#networkPlot')
  })
  
  output$distPlot <- renderPlotly({
    q <- ggplot(data=df, aes(x = Deaths_due_to_tuberculosis.per_100k., 
                             y = Tuberculosis_Incidence.per_100k_per_yr.)) +
      geom_point(aes(text = paste("Continent", df$Continent)), size = 1.5) +
      geom_smooth(aes(colours = Continent)) +
      facet_wrap(~ Continent) + xlab("Tuberclosis death per 100,000") + 
      ylab("Tuberclosis Incidents per 100,000")
    gg <- ggplotly(q)
    gg
  
  })
  
  output$dist2Plot <- renderPlotly({
       p2 <- plot_ly(df, x = df$Pop_proportion_over_60..., y = df$Adult_mortality_rate.15_to_60_yrs_per_1000.,
                  z = Country, type = "scatter3d", mode = "markers",
                  color = Continent) %>%   
      layout(title = "3d Plot-Population proportion vs Adult Mortality in various Countries",
             scene = list(
               xaxis = list(title = "Population proportion"), 
               yaxis = list(title = "Adult Mortality Rate")
                                           ))
    p2
      })
})

