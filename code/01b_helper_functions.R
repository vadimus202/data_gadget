
stopifnot(!is.null(df))

df_meta <- 
    function()
        data_frame(
            var = names(df),
            class = sapply(df,class),
            NAs = sapply(df, function(x) sum(is.na(x)))
        )


df_meta_num <- 
    function(){
        df <- 
            df[, sapply(df, is.numeric)]
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

df_meta_char <- 
    function(){
        df <- 
            df[, sapply(df, is.character), drop=F]
        data_frame(
            variable = names(df),
            example = sapply(df, function(x) table(x, useNA = 'no') %>% sort(decreasing = T) %>% .[1] %>% names),
            NAs = sapply(df, function(x) sum(is.na(x))),
            unique = sapply(df, function(x) length(unique(x))),
            range = sapply(df, function(x) x %>% nchar %>% range %>% paste(collapse = ' - '))
        )
    }
