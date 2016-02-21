server <- function(input, output, session) {
    
    
    
    output$table_num <- DT::renderDataTable({
        df_meta_num() %>% 
            datatable(rownames=F,selection = 'single') %>% 
            formatRound('StdDev', 2)
    }, server = T)
    
    output$plot_hist <- renderPlot({
        s <- input$table_num_rows_selected
        if (length(s)==1) {
            sapply(df, is.numeric) %>% 
                which %>% .[s] %>% extract2(df, .) %>% 
                hist(main='')
        }
    })
    
    output$plot_hist_log <- renderPlot({
        s <- input$table_num_rows_selected
        if (length(s)==1) {
            x <- sapply(df, is.numeric) %>% which %>% .[s] %>% extract2(df, .)
            if(sum(x<=0,na.rm = T)==0) hist(log(x),main = '')
        }
    })
    
    output$table_char <- DT::renderDataTable({
        df_meta_char() %>% 
            datatable(rownames=F,selection = 'single')
    })
    
    observeEvent(input$done, {
        stopApp(TRUE)
    })
}
