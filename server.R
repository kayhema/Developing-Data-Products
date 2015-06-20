library(shiny)
library(RCurl)
library(HistData)
library(Hmisc)


shinyServer(function(input, output) {
  ht <<- NA
  wt <<- NA
  
  
  getDatatables <- function(type='Height'){
    
    
      if(type=="Height"){
           if(any(is.na(ht)) ){
          uri <- "http://www.cdc.gov/growthcharts/data/zscore/lenageinf.csv"
          ht <- read.table(textConnection(getURL(uri,
                                                 userpwd = "user:pass")), sep=",", header=TRUE, stringsAsFactors=F)
          ht <- ht[-38,]
          ht <- apply(ht, 2, as.numeric)
          ht <<- data.frame(ht)
          return(ht)
        }else{
          return(ht)
        }
      }else if(type=="Weight"){ 
        if(any(is.na(wt)) ){
          uri <- "http://www.cdc.gov/growthcharts/data/zscore/wtageinf.csv"
          wt <<- read.table(textConnection(getURL(uri,
                                                  userpwd = "user:pass")), sep=",", header=TRUE, stringsAsFactors=FALSE)
          return(wt)
        }else{
          return(wt)
        }
      }
    
  }
    
    output$HeightPlot <- renderPlot({
      ## Length for age charts
      ht <- getDatatables("Height")
      if(class(ht) == "matrix") ht <- data.frame(ht)
      if(input$Gender=="Boy") selectgender <- 1
      if(input$Gender=="Girl") selectgender <- 2
      plot(ht$Agemos[ht$Sex==selectgender], ht$P50[ht$Sex==selectgender], col="red", ylim=c(45,105),lty=1,
           type='l', main=paste(input$Gender, "Height"), xlab="Age in months", ylab="Baby Height in centimeters")
      ## M = P50
      lines(ht$Agemos[ht$Sex==selectgender], ht$P25[ht$Sex==selectgender], col="green", lty=4)
      lines(ht$Agemos[ht$Sex==selectgender], ht$P75[ht$Sex==selectgender], col="green", lty=4)
      lines(ht$Agemos[ht$Sex==selectgender], ht$P10[ht$Sex==selectgender], col='grey54', lty=4)
      lines(ht$Agemos[ht$Sex==selectgender], ht$P90[ht$Sex==selectgender], col='grey54', lty=4)
      grid(nx = 36)
      legend("topleft", c("P90","P75","P50", "P25","P10"), lty=c(2,2,1,2,2), col=c("grey54","green","red", "green", "grey54"))
      points( input$Age, input$Height, pch=13, col="blue")
    })
    
    output$WeightPlot <- renderPlot({
    
      wt <- getDatatables("Weight") 
      if(input$Gender=="Boy") selectgender <- 1
      if(input$Gender=="Girl") selectgender <- 2
      plot(wt$Agemos[wt$Sex==selectgender], wt$P50[wt$Sex==selectgender], col="red", ylim=c(3,16),
           main=paste(input$Gender, "Weight"), type='l', xlab="Age in months", ylab="Baby weight in kilograms")
      
      lines(wt$Agemos[wt$Sex==selectgender], wt$P25[wt$Sex==selectgender], col="green", lty=4)
      lines(wt$Agemos[wt$Sex==selectgender], wt$P75[wt$Sex==selectgender], col="green", lty=4)
      
      grid(nx = 36)
      lines(wt$Agemos[wt$Sex==selectgender], wt$P10[wt$Sex==selectgender], col='grey54', lty=4)
      lines(wt$Agemos[wt$Sex==selectgender], wt$P90[wt$Sex==selectgender], col='grey54', lty=4)
      legend("topleft", c("P90","P75","P50", "P25","P10"), lty=c(2,2,1,2,2), col=c("grey54","green","red","green", "grey54"))
      points( input$Age, input$Weight, pch=13, col="blue")
    })
   
     output$result1 <- renderPrint ({ input$value1*2.54 })
     output$result2 <- renderPrint ({ input$value2*0.4536 })
  })
    