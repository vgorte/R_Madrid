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
  
  madridOutline<- eventReactive(input$madrid, {
    madridShape <- readOGR("./madridshapefile/", "Distritos")
    madridShape <- spTransform(madridShape, CRS("+proj=longlat +datum=WGS84 +no_defs"))
    return(madridShape)
  })
    
  visibilityMadridOutlines<- eventReactive(input$madrid, {
    if(input$madrid == TRUE){
      print("on")
      return(0.1)
    }else{
      print("off")
      return(0)
    }
  })
    
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$CartoDB.Positron,
                       options = providerTileOptions(noWrap = )
      ) %>%
      addPolygons(data=direction(),weight=1,col = 'red') %>% 
      addPolygons(data=madridOutline(),weight=visibilityMadridOutlines(),col = 'black') %>% 
      
      setView(lng = -3.8196207,
              lat = 40.4678698,
              zoom = 10)
  
  })
})

