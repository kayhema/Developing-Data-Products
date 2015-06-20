library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Baby Growth Pattern"),
  
  
  sidebarLayout(
    sidebarPanel(
      p("This is a tool to plot the baby growth (Height/Weight) as per WHO standards."), 
      p("Since this is for infants Input should be in the following limits."),
                                   p("Age of the Baby = 1  - 36 months"),
                                   p("Height of Baby  = 45 - 100 cm."),
                                   p("Weight of Baby  = 3  - 16 kg ."),
      selectInput("Gender", label= "Select Baby Gender", choices= c("Boy", "Girl"), selected="Boy"),
      
     
      sliderInput("Height", "Baby Height in cm", min=45, max=100, value = 75),
      
      sliderInput("Weight", "Baby Weight in Kilograms",min=3,max=16, value = 12),
      
      textInput("Age",  "Baby's age in months:",value = 25),
      
      submitButton("Update Results"),
      
   
      br(),
      br(),
    p("Since height and weight are measured in inches and lbs in US, here are the Converters"),
   
    numericInput('value1',label=h4("Inch"),1, min=0),
    submitButton('Convert!'),
    h4('Centimetre'), 
    verbatimTextOutput("result1") ,
    
    numericInput('value2',label=h4("lb"),1, min=0),
    submitButton('Convert!'),
    h4('kilograms'), 
    verbatimTextOutput("result2") 
    ),
    # Show a plot of the generated distribution
    mainPanel(
                           helpText("Baby growth charts as per WHO/CDC are shown below.Redline is the 50th percentile line."),
                           helpText("The selected baby details are plotted on growth charts as blue points."),
                           p("If these points lies near the red line, the child has normal growth for the given age."),
                           br(),
                           br(),
                           h4("1) Height Vs Age chart"),
                           plotOutput("HeightPlot"),
                           br(),
                           h4("2) Weight Vs Age chart"),
                           plotOutput("WeightPlot"),
                           br(),
                           br(),
                           h5("Data Source:"),
                           helpText("http://www.cdc.gov/growthcharts/data/zscore/lenageinf.csv"),
                           helpText("http://www.cdc.gov/growthcharts/data/zscore/wtageinf.csv")
                          )
      )
    


))