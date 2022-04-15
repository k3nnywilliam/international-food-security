library(plotly)

ui <- fluidPage(
  #titlePanel("International Food Security (Food availability)"),
  HTML(r"(
       <h2>International Food Security (Food availability)</h2>
       <br>
       <p><b>Dataset source:</b> <a href="https://data.nal.usda.gov/dataset/international-food-security-0">Link</a></p>
       <p>This dataset measures food availability and access for 76 low- and middle-income countries.</p>
       <p> The dataset includes annual country-level data on area, yield, production, nonfood use, trade, and consumption for grains and root and tuber crops (combined as R&T in the documentation tables), food aid, total value of imports and exports, gross domestic product, and population compiled from a variety of sources.</p>
       <p>This dataset is the basis for the International Food Security Assessment 2015-2025 released in June 2015.</p>
       <br>
  )"),
  sidebarLayout(
    sidebarPanel(
      selectInput("region", "Region", 
                  choices = c("Select", "IFSA Countries", 
                              "Asia", "Latin America and the Caribbean", 
                              "North Africa", "Sub-Saharan Africa")),

      ),
    mainPanel(
      #tableOutput("contents"),
      plotlyOutput("totalGrain2021_plot"),
      plotlyOutput("foodGrain2021_plot"),
      plotlyOutput("foodGrain2021_prod"),
      
      #plotOutput("totalGrain2021"),
      #plotOutput("totalGrain2031"),
    )
  )
)