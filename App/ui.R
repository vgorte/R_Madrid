library(shiny)
library(leaflet)
shinyUI(
  fluidPage(
    leafletOutput("mymap"),
    checkboxInput(inputId = "direction",
                  label = strong("Traffic Directions"),
                  value = FALSE),
    checkboxInput(inputId = "madrid",
                  label = strong("Madrid Outlines"),
                  value = FALSE)
  )
)

