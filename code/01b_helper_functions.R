
stopifnot(!is.null(df_raw))


get_df_num <- 
    function(df) df[, sapply(df, is.numeric), drop=F]

get_df_char <- 
    function(df) df[, sapply(df, is.character), drop=F]

get_df_fctr <- 
    function(df) df[, sapply(df, is.factor), drop=F]


get_meta <- 
    function(df)
        data_frame(
            var = names(df),
            class = sapply(df,class),
            NAs = sapply(df, function(x) sum(is.na(x)))
        )


get_meta_num <- 
    function(df){
        df <- 
            get_df_num(df)
        
        data_frame(
            Name = names(df),
            Class = sapply(df,class) %>% substr(1,1),
            NAs = sapply(df, function(x) sum(is.na(x))),
            Min = sapply(df, min, na.rm = T),
            Med = sapply(df, median, na.rm = T),
            Max = sapply(df, max, na.rm = T),
            StdDev =  sapply(df, sd, na.rm = T)
        )
    }

get_meta_char <- 
    function(df){
        df <- 
            get_df_char(df)
        
        data_frame(
            Variable = names(df),
            Example = sapply(df, function(x) table(x, useNA = 'no') %>% sort(decreasing = T) %>% .[1] %>% names),
            NAs = sapply(df, function(x) sum(is.na(x))),
            Unique = sapply(df, function(x) length(unique(x))),
            Length = sapply(df, function(x) x %>% nchar %>% range %>% paste(collapse = ' - '))
        )
    }


get_meta_fctr <- 
    function(df){
        df <- 
            get_df_fctr(df)
        
        data_frame(
            Variable = names(df),
            Levels = sapply(df, function(x) length(unique(x))),
            'Most Freq' = sapply(df, function(x) table(x, useNA = 'no') %>% sort(decreasing = T) %>% .[1] %>% names),
            NAs = sapply(df, function(x) sum(is.na(x))),
            Ordered = sapply(df, function(x) ifelse(x %>% is.ordered,'Y',NA))
        )
    }

