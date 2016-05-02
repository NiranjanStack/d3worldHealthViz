library(RCurl)
library(d3Network)
library("ggplot2")
library("plotly")
library("plyr")
library("gdata")
df <- read.table("dataset_who.csv", header=TRUE, sep=",")
URL <- "https://raw.githubusercontent.com/NiranjanStack/d3worldHealthViz/master/10countries.json"