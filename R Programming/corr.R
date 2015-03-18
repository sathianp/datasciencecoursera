corr <- function(directory, threshold = 0){
  ##get current working directory and store it
  oldpath <- getwd()
  
  newpath <- paste(oldpath, directory, sep="/")
  setwd(newpath)
  
  filenames <- list.files(pattern="*.csv")
  tables <- lapply(filenames, read.csv, header = TRUE)
  df <- lapply(tables, na.omit)
  
  setwd(oldpath)
  
  corV <- numeric(0)
  
  for (id in 1:length(df)){
    x <- data.frame(df[id])
    if (nrow(x) > threshold){
      corV <- c(corV, cor(x$sulfate, x$nitrate))
    }
  }
  
  y <- corV
}
