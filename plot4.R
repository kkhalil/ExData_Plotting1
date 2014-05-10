plot4 <- function() {
    filename <- "household_power_consumption.txt"

    # read the types of the columns to speed the reading and save the titles
    tab5rows <- read.table(filename, header=TRUE, sep=";", stringsAsFactors=FALSE, nrows=5)
    classes <- sapply(tab5rows, class)

    # first sample on 16/12/2006 at 17:24
    # skip 36 minutes + 6 hours + 46 days = 36 + 60 * ( 6 + 24 * 46) = 66636
    # skip the header so in total we have to skip 66637 rows
    # read data of "1/2/2007" and "2/2/2007", so 2 * 24 * 60 = 2880 samples

    hpc <- read.table(filename, colClasses=classes, stringsAsFactors = FALSE,
                      sep=";", skip=66637, nrow=2880)
    names(hpc) <- names(tab5rows)
    rm(tab5rows)

    febDays <- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")

    png(file = "plot4.png", width = 480, height = 480, bg = "transparent")
    
    par(mfcol=c(2,2))
    plot(febDays, hpc$Global_active_power, type = "l", col = "black", 
         xlab = "", ylab = "Global Active Power")

    with(hpc, { plot(febDays, Sub_metering_1, type = "l", col = "black", 
                     xlab = "", ylab = "Energy sub metering")
                points(febDays, Sub_metering_2, type = "l", col = "red" )
                points(febDays, Sub_metering_3, type = "l", col = "blue")
                legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", 
                       "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1,
                       bty="n")
               })

    plot(febDays, hpc$Voltage, type = "l", col = "black", 
         xlab = "datetime", ylab = "Voltage")

    plot(febDays, hpc$Global_reactive_power, type = "l", col = "black", 
         xlab = "datetime", ylab = "Global_reactive_power")


    #dev.copy(png, file = "plot4.png", width = 480, height = 480, bg = "transparent")
    dev.off()
}