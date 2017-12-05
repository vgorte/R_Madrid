library(shiny)
library(rgdal)

shinyServer(function(input, output, session) {
  ##SHAPEFILES

  direction <- eventReactive(input$direction, {
    directions <- readOGR("./directions/", "directions")
    proj4string(directions) <- CRS("+proj=utm +zone=30 +ellps=GRS80 +units=m +no_defs")
    directions_longlat <- spTransform(directions, CRS("+proj=longlat +datum=WGS84 +no_defs"))
    return(directions_longlat)
  })
  
    madridShape <- readOGR("./madridshapefile/", "Distritos")
    madridShape <- spTransform(madridShape, CRS("+proj=longlat +datum=WGS84 +no_defs"))

    
  visibilityDirections<- eventReactive(input$direction, {
    if(input$direction == TRUE){
      return(1)
    }else{
      return(0)
    }
  })
    
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$CartoDB.Positron,
                       options = providerTileOptions(noWrap = )
      ) %>%
      addPolygons(data=direction(),weight=visibilityDirections(),col = 'red') %>% 
      addPolygons(data=madridShape,weight=0.6,col = 'black') %>% 
      setView(lng = -3.8196207,
              lat = 40.4678698,
              zoom = 10)
  
  })
})

