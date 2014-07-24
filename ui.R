library(shiny)
data(mtcars)

shinyUI (
        pageWithSidebar(
                headerPanel("Car Mileage Prediction"),
                
                sidebarPanel(
                        selectInput("cylinders", label=h4("Number of Cylinders"),sort(unique(mtcars$cyl), decreasing = FALSE) ),
                        radioButtons("enginetype", label=h4("Engine Type"),choices=list("V Engine" = 0, "Straight Engine" = 1)) ,
                        radioButtons("transmission", label=h4("Transmission Type"),choices=list("Automatic" = 0, "Manual" = 1)) ,
                        selectInput("forwardgears", label=h4("Number of Forward Gears"),choices=sort(unique(mtcars$gear),decreasing=FALSE)),
                        sliderInput("carburetors", label=h4("Number of carburetors"),min=min(mtcars$carb),max=max(mtcars$carb),step=1,value=min(mtcars$carb)),
                        submitButton("Submit")
                ),
                
                mainPanel(
                        tabsetPanel(
                                tabPanel("Main Page",
                                        h2("Results of Prediction"),
                                        p("You can find summary, documentation and instructions for the applocation in the instructions tab above. Select your values from the sidebar on the left and click submit to get a prediction of Miles/gallon estimate."),
                                        br(),
                                        h3("Input Values "),
#                                         verbatimTextOutput("inputvalues"),
                                        htmlOutput("inputvalues"),
                                        br(),
                                        h3("Prediction for Mileage in Miles/gallon"),
                                        h4("For model with all input used for prediction i.e. Cyinders, Engine Type, Transmission, Forward Gears and carburetors."),
                                        code("lm(mpg ~ cyl + vs + am + gear + carb, mtcars)"),
                                        textOutput("allModelPrediction"),
                                        h4("For model with cylinder, engine type, and transmission type used for prediction "),
                                        code("lm(mpg ~ cyl + vs + am, mtcars)"),
                                        textOutput("threeModelPrediction"),
                                        h4("For single variable for prediction."),
                                        h6("Number of Cylinders Only Model."),
                                        textOutput("cylOnlyModel"),
                                        h6("Number of Engine Type Only Model."),
                                        textOutput("vsOnlyModel"),
                                        h6("Number of Transmission Only Model."),
                                        textOutput("amOnlyModel"),
                                        h6("Gear Only Model."),
                                        textOutput("gearOnlyModel"),
                                        h6("Carburetors Only Model."),
                                        textOutput("carbOnlyModel"),
                                        br(),
                                        h3("Summary of Results"),
                                        dataTableOutput("summaryTable"),
                                        br(),
                                        br()
                                        
                                ),
                                tabPanel("Instructions",
                                        h6("Created by: Jawad Rashid"),
                                        h2("Instructions & Summary"),
                                        h3("Details of the product:"),
                                        p("This product uses the cars dataset in cars which measured miles/gallon and number of cylinders, transmission type, number of forward gears, number of carburetors and engine type."),
                                        p("In this product you will input your car attributes on the sidebar on the left, submit and will get a prediction of your mileage in Miles/gallon for your given values. This product will show you that including and excluding different attribute for prediction using linear model will result in very different results for the mileage. Using all attributes will give better results but including only single value will maybe not give good enough results."),
                                        p("This is only to show the capability of prediction based on different attributes and not a formal study so i have not reported any accuracy or done in depth analysis of the output."),
                                        
                                        h3("Attribute Details"),
                                        p("This section gives the overview of what each attribute means which are used in the prediction algorithm"),
                                        tags$ul(
                                                tags$li("mpg is miles/gallon and is the value we are trying to predict"),
                                                tags$li("cyl is number of cylinders in the car"),
                                                tags$li("vs is the engine type.In vs v is for v type engine and s for straight engine"),
                                                tags$li("am is transmission type. In am a is automatic and m is manual"),
                                                tags$li("gear is number of forward gears"),
                                                tags$li("carb is number of carburetors")
                                        ),
                                        
                                        h3("Instructions: "),
                                        tags$ul(
                                                tags$li("First make sure that Main page tab is selected"),
                                                tags$li("From the dropdown select number of cylinders"),
                                                tags$li("Select engine type as either V type or straight type"),
                                                tags$li("Select transmission type as either automatic or manual"),
                                                tags$li("Select number of gears"),
                                                tags$li("Select number of carburetors from slider"),
                                                tags$li("Finally click submit button to make the prediction"),
                                                tags$li("When you click submit the input values heading will change with the updated values and the different model will be used to predict mileage/gallon"),
                                                tags$li("The first model uses all attributes, the second one uses number of cylinders, transmission  and engine type and the last 5 use only single attribute for prediction")
                                                
                                        ),
                                        h3("Source"),
                                        p("The data for the prediction is taken from R mtcars dataset. Click on the link below for the documentation of the dataset"),
                                        a(href="http://stat.ethz.ch/R-manual/R-devel/library/datasets/html/mtcars.html", "R mtcars Documentation"),
                                        br(),
                                        br()
                                )
                        )
                )
        )
)
