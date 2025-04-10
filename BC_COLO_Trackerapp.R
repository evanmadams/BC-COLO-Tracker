#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

require(tidyverse)
require(leaflet)
require(sf)
require(htmltools)
require(rebird)

  ui <- fluidPage(
    titlePanel("BC COLO Tracker"),
    
    leafletOutput("map"),
    
    p(),
    
    sliderInput("days", "Days Back:",
                min = 1, max = 10,
                value = 1)
    )
  
  server = function(input, output, session){
    

    
    output$map <- renderLeaflet({
      
        source('colo_ebird_collector.R')
        obs.all <- ebird_comp(days = input$days)
        
        leaflet() |> 
        addTiles() |> 
        setView(lng = mean(obs.all$lng), lat = mean(obs.all$lat), zoom = 7) |> 
        addMarkers(data = obs.all,
                   lng = jitter(obs.all$lng, 0.001),
                   lat = jitter(obs.all$lat, 0.001), 
                   popup = ~paste('Species:', comName, '<br>',
                                  'Number:', howMany, '<br>',
                                  'Date:', obsDt, '<br>',
                                   ebirdlink))
    })
    
  }

# Run the application 
shinyApp(ui = ui, server = server)


####END####