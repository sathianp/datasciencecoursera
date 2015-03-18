complete <- function(directory, id = 1:332){
  ##get current working directory and store it
  oldpath <- getwd()
  
  ##setpath to subdirectory specdata
  filepath <- paste(oldpath, directory, sep="/")
  
  ##get the list of filenames
  filenames <- list.files(filepath)
  temp <- data.frame()
  
  ## read only the requrired csv file into data frame
  for (i in 1:length(id)){
    filename <- paste(filepath, filenames[id[i]], sep="/")
    temp <- c(temp, lapply(filename, read.csv, header = TRUE))
  }
  df <- do.call(rbind, temp)

  ##subset the dataframe using the filter condition
  rs <- data.frame("id"=numeric(), "nobs"=numeric())
  #rs <- data.frame()  

  for (i in 1:length(id)) {
    sub_set <- subset(df, ID == id[i] & !is.na(sulfate) & !is.na(nitrate))
    rs <- rbind(rs, c(id[i], nrow(sub_set)))
  }

  colnames(rs) <- c("id", "nobs")
  
  print.data.frame(rs)
    
}
