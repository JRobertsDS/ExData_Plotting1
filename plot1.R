# plot1.R

library (dplyr)

# globals 
gDownloadedToday = TRUE
gFileName = "household_power_consumption.txt"

loadData <- function () {
        # estimate of file size: 2,075,259 rows, 9 columns, or 18677331 entries
        #       at 8 bytes per, 149418648 bytes, or roughly 150 MB; plenty of room
        #       after loading, object.size (hpcRawData) returns 149604992
        retVal = !gDownloadedToday
        zipFileName = "hpc.zip"
        if (!file.exists(gFileName)) {
                datasetZipURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                download.file(datasetZipURL, zipFileName, "curl") 
                unzip (zipFileName)
                retVal = gDownloadedToday
        }
        return (retVal)
}

plot1 <- function () {
        if (loadData () == gDownloadedToday)
                dateDownloaded <<- date ()
        hpcRawData <- read.table (gFileName, header = TRUE, sep=";", na.strings = "?", stringsAsFactors = FALSE)
        # Notice that the days in the dataset are Day, Month, Year, NOT Month, Day Year as is usual in the US
        hpc <- subset (hpcRawData, Date == "1/2/2007" | Date == "2/2/2007")
        #hpc <<- mutate (hpcI, DateTime = as.POSIXct (strptime (paste (hpcI$Date, hpcI$Time), format = "%d/%m/%Y %H:%M:%S")))
        rm (hpcRawData)
        
        png (filename = "plot1.png", width = 480, height = 480)
        hist (hpc$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
        dev.off()
}