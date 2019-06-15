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


# Source functions --------------------------------------------------------

data_test <- data.table(
  players = c("Federer", "Nadal", "Auger", "Agassi"),
  age = c(18, 30, 22.3, 19.2),
  rank = c(30, 2, 14, 25)
)


# Run app -----------------------------------------------------------------

runApp("src/shiny-app")
