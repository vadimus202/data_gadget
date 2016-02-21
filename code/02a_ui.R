ui <- 
    miniPage(
        gadgetTitleBar("Data Variables" %>% paste(dim(df) %>% paste(collapse = ' x '))),
        miniTabstripPanel(
            miniTabPanel("Numeric", icon = icon("list-ol"),
                         fillRow(
                             DT::dataTableOutput("table_num", height = "100%"), 
                             fillCol(
                                 plotOutput("plot_hist", height = "100%"),
                                 plotOutput("plot_hist_log", height = "100%")
                             ),
                             flex = c(3, 2), width = "100%", height = "100%"),
                         miniButtonBlock(
                             actionButton("Trans", "Transform")
                         )
                         
            ),
            miniTabPanel("Character", icon = icon("sort-alpha-asc"),
                         DT::dataTableOutput("table_char")
            )
        )
    )
