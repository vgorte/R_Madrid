library(shiny)
library(leaflet)
shinyUI(
  fluidPage(
    navbarPage("Madrid - Air quality & traffic ",
      tabPanel("Map", 
        fluidRow(
          leafletOutput("mymap"),
          checkboxInput(inputId = "direction",
                        label = strong("Traffic Directions"),
                        value = FALSE)
        )
      ),
      tabPanel("Other")
    )
  )
)

