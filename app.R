library(shiny)
library(ggplot2)

ui <- fluidPage(
  #App title
  titlePanel("Investing Scenarios from Warmup 6"),
  
  fluidRow(
    #Invested Initial Amount
    column(4, 
           sliderInput(inputId = "initial", 
                       label = "Initial Amount",
                       min = 1, max = 100000, 
                       step = 50,
                       value = 1000, 
                       pre = "$", 
                       sep = ","),
           
           sliderInput(inputId = "annual",
                       label = "Annual Contribution",
                       min = 0, 
                       max = 50000, 
                       step = 500,
                       value = 2000,
                       pre = '$',
                       sep = ',')
           ),
    
    column(4, 
           sliderInput(inputId = "return", 
                       label = "Return Rate (in %)",
                       min = 0, 
                       max = 20, 
                       step = 0.1,
                       value = 5),
           
           sliderInput(inputId = "growth", 
                       label= "Growth Rate (in %)",
                       min = 0, 
                       max = 20, 
                       step = 0.1,
                       value = 2 )
           ), 
    
    column(4, 
           sliderInput(inputId = "years",
                       label ="Years",
                       min = 0, 
                       max = 50, 
                       step = 1,
                       value = 20),
           selectInput(inputId = "facet", 
                       label ="Facet?", 
                       choices = c("No", "Yes"))
       )
     ),
  mainPanel(
  h4("Timelines"),
  plotOutput("timeplot"),
  h4("Balances"),
  tableOutput("table")
    )
  )


server <- function(input, output) {
  
  modalities <- reactive({
    
  future_value <- function(amount, rate, years) {
    return(amount*(1+rate/100)^years)
  }
  annuity <- function(contrib, rate, years) {
    return(contrib*((1+rate/100)^years-1)/rate * 100)
  }
  growing_annuity <- function(contrib, rate, growth, years) {
    return(contrib*((1+rate/100)^years - (1+growth/100)^years)/ (rate /100 - growth/100))
  }
  
  total_years <- input$years
  
  #no contribution
  no_contrib <- rep(0 , total_years + 1)
  for (i in 0:total_years){
    no_contrib[i + 1] <- future_value(input$initial, input$return, i)
  }
  
  #fixed contribution
  fixed_contrib <- rep(0, total_years + 1)
  for(i in 0:total_years){
    fixed_contrib[i + 1] <- future_value(input$initial, input$return, i) + annuity(input$annual, input$return, i)
  }
  
  #growing contribution
  growing_contrib <- rep(0, total_years + 1)
  for(i in 0:total_years){
    growing_contrib[i + 1] <- future_value(input$initial, input$return,i) + growing_annuity(input$annual,input$return,input$growth,i)
  }
  
  year <- 0:total_years
 
  return(data.frame(year, no_contrib, fixed_contrib, growing_contrib))
})
  
  
  modality <- reactive({
    df <- modalities()
    al <- c(df$no_contrib,df$fixed_contrib,df$growing_contrib)
    year <- rep(0:input$years,times=3)
    mode <- factor(rep(c("no_contrib","fixed_contrib","growing_contrib"), 
                         each = input$years + 1)
                     ,levels = c("no_contrib","fixed_contrib","growing_contrib"))
    mod2 <- data.frame(year, mode, al)
    return(mod2)
  })
  
  output$timeplot <- renderPlot({
    if(input$facet == "No"){
      ggplot(data = modalities(),color = "investments") +
        geom_line(aes(x = year, y = no_contrib,color="no_contrib")) +
        geom_line(aes(x = year, y = fixed_contrib,color="fixed_contrib")) +
        geom_line(aes(x = year, y = growing_contrib,color="growing_contrib"))  +
        labs(x="years",y="dollars",title="3 different investment growths",color='Investments')
      } 
    else {
      
      ggplot(data = modality()) +
        facet_grid(~mode) +
        geom_area(aes(x = year, y = al,fill = mode, alpha = 0.7))+
        geom_point(aes(x = year, y = al, color = mode)) + 
        geom_line(aes(x = year, y = al, color = mode)) + 
        guides(alpha = FALSE,color = FALSE)+
        
        labs(x="years",y="dollars",title="3 different investment growths", color='Investments')
    }
    
  })
  
  output$table <- renderTable({
    modalities()
  })
}
  
  #Run application
  shinyApp(ui = ui, server = server)
  
