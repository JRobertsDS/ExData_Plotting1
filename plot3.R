# plot3.R

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

plot3 <- function () {
        if (loadData () == gDownloadedToday)
                dateDownloaded <<- date ()
        hpcRawData <- read.table (gFileName, header = TRUE, sep=";", na.strings = "?", stringsAsFactors = FALSE)
        # Notice that the days in the dataset are Day, Month, Year, NOT Month, Day Year as is usual in the US
        hpcI <- subset (hpcRawData, Date == "1/2/2007" | Date == "2/2/2007")
        hpc <<- mutate (hpcI, DateTime = as.POSIXct (strptime (paste (hpcI$Date, hpcI$Time), format = "%d/%m/%Y %H:%M:%S")))
        rm (hpcRawData)
        
        png (filename = "plot3.png", width = 480, height = 480)
        with (hpc, plot (DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
        with (hpc, points (DateTime, Sub_metering_2, type = "l", col = "red"))
        with (hpc, points (DateTime, Sub_metering_3, type = "l", col = "blue"))
        legend ("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), 
                legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        dev.off()
}