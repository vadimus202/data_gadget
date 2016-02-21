library(shiny)
library(miniUI)
library(magrittr)
library(dplyr)
library(DT)

options(DT.options = list(pageLength = 10), dom = 'tfip')

source('code/01a_get_data_frame.R')
source('code/01b_helper_functions.R')

source('code/02a_ui.R')
source('code/02b_server.R')

runGadget(ui, server, viewer = dialogViewer("Variables", 1000, 800))
