server <- function(input, output, session) {
    
    df_num <- get_df_num(df_raw)
    df_char <- get_df_char(df_raw)
    df_fctr <- get_df_fctr(df_raw)
    
    ###### Numeric #######
    output$table_num <- DT::renderDataTable({
        df_raw %>% get_meta_num() %>% 
            datatable(rownames=F,selection = 'single') %>% 
            formatRound('StdDev', 2)
    }, server = T)
    
    output$plot_hist <- renderPlot({
        s <- input$table_num_rows_selected
        if (length(s)==1) {
            df_x <- 
                df_num %>% extract(s)
            
            hist(df_x %>% extract2(1), 
                 xlab = names(df_x), main='')
        }
    })
    
    output$plot_hist_log <- renderPlot({
        s <- input$table_num_rows_selected
        if (length(s)==1) {
            
            df_x <- 
                df_num %>% extract(s)
            
            x <- 
                df_x %>% extract2(1)
            
            if(sum(x<=0,na.rm = T)==0) 
                hist(log(x), 
                     xlab = paste('Log of', names(df_x)),
                     main = '')
        }
    })
    
    
    ###### Character #######
    output$table_char <- DT::renderDataTable({
        df_raw %>% get_meta_char() %>%  
            datatable(rownames=F,selection = 'single')
    })
    
    
    ###### Character #######
    output$table_fctr <- DT::renderDataTable({
        df_raw %>%  get_meta_fctr() %>% 
            datatable(rownames=F,selection = 'single')
    })
    
    
    
    
    observeEvent(input$done, {
        stopApp(TRUE)
    })
}
