setwd("/Users/user/Documents/R_Madrid/App/")

library(shiny)
library(leaflet)
library(rgdal)


createMap <- function(){
  shapeData <- readOGR("/Users/user/Desktop/test/App/madridshapefile", "Distritos" )
  shapeData <- spTransform(shapeData, CRS("+proj=longlat +datum=WGS84 +no_defs"))
  
  map <- leaflet() %>% 
    addProviderTiles("Stamen.TerrainBackground") %>% 
    addPolygons(data=shapeData,weight=1,col = 'grey') %>% 
    setView(lng = -3.8196207,
            lat = 40.4678698,
            zoom = 10)
  return(map)
}


# Define UI for application that plots random distributions 
shinyUI(fluidPage(
  # Navbar
  navbarPage("Madrid - Air quality & traffic ",
  tabPanel("Map", 
    fluidRow(
      createMap(),
      
      checkboxInput(inputId = "traffic",
                    label = strong("Traffic"),
                    value = FALSE),
      checkboxInput(inputId = "air",
                    label = strong("Air Quality"),
                    value = FALSE)
    )
  ),
  tabPanel("Correlation"),
  tabPanel("blub")

)
)
)

