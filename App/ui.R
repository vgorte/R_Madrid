setwd("/Users/user/Documents/R_Madrid/App/")
library(sp)
library(shiny)
library(leaflet)
library(rgdal)

createMap <- function(){
  ##SHAPEFILES
  madridShape <- readOGR("./madridshapefile/", "Distritos")
  directions <- readOGR("./directions/", "directions")
  
  

  ##TRANSFORMATIONS
  #Madrid (Outlines)
  madridShape <- spTransform(madridShape, CRS("+proj=longlat +datum=WGS84 +no_defs"))
  #Traffic directions
  proj4string(directions) <- CRS("+proj=utm +zone=30 +ellps=GRS80 +units=m +no_defs")
  directions_longlat <- spTransform(directions, CRS("+proj=longlat +datum=WGS84 +no_defs"))
  
  map <- leaflet() %>% 
    addProviderTiles("CartoDB.Positron") %>% 

    addPolygons(data=madridShape,weight=1,col = 'black') %>% 
    addPolygons(data = directions_longlat, weight=1, col = 'red') %>% 
    
    
    setView(lng = -3.8196207,
            lat = 40.4678698,
            zoom = 10)
  return(map)
}


# Define UI for application that plots random distributions 
shinyUI(
  fluidPage(
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

