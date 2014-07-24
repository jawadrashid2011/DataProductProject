library(shiny)
data(mtcars)

getEngineType <- function(engine) {
        engineType <- list("V Engine", "Straight Engine")
        return(engineType[[as.integer(engine)+1]])
}

getTransmissionType <- function(transmission) {
        transmissionType <- list("Automatic", "Manual")
        return(transmissionType[[as.integer(transmission)+1]])
}

predictionDataFrame <- function(input) {
        data.frame(cyl = as.integer(input$cylinders), vs = as.integer(input$enginetype), am = as.integer(input$transmission), gear = as.integer(input$forwardgears), carb = as.integer(input$carburetors))
}

allModel <- lm(mpg ~ cyl + vs + am + gear + carb, mtcars)
threeModel <- lm(mpg ~ cyl + vs + am , mtcars)
cylOnly <- lm(mpg ~ cyl, mtcars)
vsOnly <- lm(mpg ~ vs, mtcars)
gearOnly <- lm(mpg ~ gear, mtcars)
carbOnly <- lm(mpg ~ carb, mtcars)
amOnly <- lm(mpg ~ am, mtcars)

shinyServer(
        function(input, output) {
#                 output$inputvalues <- renderText({paste("You selected <strong>", input$cylinders,"cylinders</strong>")})
                output$inputvalues <- renderUI({
                        HTML(paste("You selected ", 
                                   strong(input$cylinders),
                                   " cylinders,",
                                   strong(getEngineType(input$enginetype)),
                                   ",",
                                   strong(getTransmissionType(input$transmission)),
                                   "transmission , ",
                                   strong(input$forwardgears),
                                   "forward gears and",
                                   strong(input$carburetors),
                                   "carburetors."
                                   ))
                        })
                
                output$allModelPrediction <- renderText({
                        paste(round(predict(allModel, newdata=predictionDataFrame(input) ),2),"Miles/gallon")
                })
                
                output$threeModelPrediction <- renderText({
                        paste(round(predict(threeModel, newdata=predictionDataFrame(input) ),2),"Miles/gallon")
                })
                
                output$cylOnlyModel <- renderText({
                        paste(round(predict(cylOnly, newdata=predictionDataFrame(input) ),2),"Miles/gallon")
                })
                
                output$vsOnlyModel <- renderText({
                        paste(round(predict(vsOnly, newdata=predictionDataFrame(input) ),2),"Miles/gallon")
                })
                
                output$amOnlyModel <- renderText({
                        paste(round(predict(amOnly, newdata=predictionDataFrame(input) ),2),"Miles/gallon")
                })
                
                output$gearOnlyModel <- renderText({
                        paste(round(predict(gearOnly, newdata=predictionDataFrame(input) ),2),"Miles/gallon")
                })
                
                output$carbOnlyModel <- renderText({
                        paste(round(predict(carbOnly, newdata=predictionDataFrame(input) ),2),"Miles/gallon")
                })
                
               output$summaryTable <- renderDataTable({
                       allPrediction <- round(predict(allModel, newdata=predictionDataFrame(input) ),2)
                        threePrediction <- round(predict(threeModel, newdata=predictionDataFrame(input) ),2)
                        cylPrediction <- round(predict(cylOnly, newdata=predictionDataFrame(input) ),2)
                        gearPrediction <- round(predict(gearOnly, newdata=predictionDataFrame(input) ),2)
                        carbPrediction <- round(predict(carbOnly, newdata=predictionDataFrame(input) ),2)
                        amPrediction <- round(predict(amOnly, newdata=predictionDataFrame(input) ),2)
                        vsPrediction <- round(predict(vsOnly, newdata=predictionDataFrame(input) ),2)

                        myFrame <- data.frame("Model" = c("Cylinder + Engine Type + Transmission + Gears + Carburetors", "Cylinder + Engine Type + Transmission", "Number of Cylinder", "Transmission Type", "Engine Type", "Number of carburetors", "Number of Gears"), "Miles/Gallon" = c(allPrediction, threePrediction, cylPrediction, amPrediction, vsPrediction, carbPrediction, gearPrediction))
                        myFrame
               }, options(bPaginate = FALSE,bFilter = FALSE))
                
                
        }
)