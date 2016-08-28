require(dplyr)
require(ggplot2)
require(lubridate)
library(shiny)
ozone_2015 <- read.csv("Astates.csv")
#Astates<-filter(ozone_2015,State.Name==c("Alabama","Alaska","Arizona","Arkansas", "Arizona", "Colorado", "Connecticut", "Delaware","Florida"))
#write.csv(Astates,"C:/projects/coursera/DataScienceProducts/deployment/Astates.csv")
ozone_2015$Date.GMT<-ymd(ozone_2015$Date.GMT)
#ozone_2015$Time.GMT<-hm(ozone_2015$Time.GMT)
#ozone_2015$DateTime<-ozone_2015$Date.GMT+ozone_2015$Time.GMT

shinyServer(
  function(input, output,session) {
  stat_state <- reactive({filter(ozone_2015,State.Name==input$inputstate)})
   
  observe({updateSelectInput(session,"county",choices= unique(as.character(stat_state()$County.Name)))})
  
  
  output$res<- renderPrint(summary(stat_state()$Sample.Measurement))
  stat_county<-reactive({filter(stat_state(),County.Name==input$county)})
  
  output$cres<-renderPrint(summary(stat_county()$Sample.Measurement))
  
  
  output$plot <- renderPlot({
    p<-ggplot(stat_county(),aes(stat_county()$Date.GMT,stat_county()$Sample.Measurement))
    p<- p+geom_point()+geom_smooth(method="lm")+xlab("Time")+ylab("Ozone level parts per million")
    print(p)
  }, height=500)
  
  
  
   }
)
