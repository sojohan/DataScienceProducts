require(shiny)
#states<-as.character(unique(ozone_2015$State.Name))
fluidPage(bootstrapPage(
 #as.character(unique(ozone_2015$State.Name)
   headerPanel("Ozone Pollution"),
  sidebarPanel(
    h3('State'),
    
    selectInput('inputstate',"Select State",c("Alabama","Alaska","Arizona","Arkansas", "Arizona", "Colorado", "Connecticut", "Delaware","Florida")),
    selectInput('county', "Select County","")),
  mainPanel(
    h3('Results'),verbatimTextOutput("res"),verbatimTextOutput("cres"),plotOutput("plot")
)))