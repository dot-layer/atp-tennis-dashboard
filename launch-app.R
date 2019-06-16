# -------------------------------------------------------------------------
# Title: launch-app
# Goal: Launching file for the Shiny App
# Date: June 15th 2019
# Author: .Layer
# -------------------------------------------------------------------------


# Load packages -----------------------------------------------------------

library(shiny)
library(shinydashboard)
library(data.table)
library(DT)
library(fst)
library(plotly)
library(RCurl)


# Source functions --------------------------------------------------------

#data_ranking <- data.table(read_fst(getURL("https://raw.githubusercontent.com/dot-layer/atp-tennis-dashboard/tree/master/data/data_ranking.fst")))
data_ranking <- data.table(read_fst("data/data_ranking.fst"))
data_ranking[, full_name := paste(name_first, name_list)]
data_ranking[, age := round(age, 2)]


# Run app -----------------------------------------------------------------

runApp("src/shiny-app")
