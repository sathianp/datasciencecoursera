pollutantmean <- function(directory, pollutant, id = 1:332){
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
  rs <- do.call(rbind, temp)
  
  
  ##remove NA and apply the filter for pollutant
  if (pollutant == "nitrate") {
       sub_set <- subset(rs, !is.na(nitrate))
    }
   else {
       sub_set <- subset(rs, !is.na(sulfate))
    }
 
  ##calculate mean, rounding to 3 digits  
  round(mean(sub_set[, pollutant]), 3)
  
}
