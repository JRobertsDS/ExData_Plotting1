# plot1.R

# globals 
gDownloaded = TRUE
gFileName = "household_power_consumption.txt"

loadData <- function () {
        # estimate of file size: 2,075,259 rows, 9 columns, or 18677331 entries
        #       at 8 bytes per, 149418648 bytes, or roughly 150 MB; plenty of room
        #       after loading, object.size (hpcRawData) returns 149604992
        zipFileName = "hpc.zip"
        if (!file.exists(gFileName)) {
                datasetZipURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                download.file(datasetZipURL, zipFileName, "curl") 
                unzip (zipFileName)
                return (gDownloaded)
        }
        return (!gDownloaded)
}

firstPlot <- function () {
        if (loadData () == gDownloaded)
                dateDownloaded <<- date ()
        hpcRawData <<- read.table (gFileName, header = TRUE, sep=";", na.strings = "?", stringsAsFactors = FALSE)
}