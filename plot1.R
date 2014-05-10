plot1 <- function() {
    filename <- "household_power_consumption.txt"

    # read the types of the columns to speed the reading and save the titles
    tab5rows <- read.table(filename, header = TRUE, sep = ";", 
                           stringsAsFactors = FALSE, nrows = 5)
    classes <- sapply(tab5rows, class)

    # first sample on 16/12/2006 at 17:24
    # skip 36 minutes + 6 hours + 46 days = 36 + 60 * ( 6 + 24 * 46) = 66636
    # skip the header so in total we have to skip 66637 rows
    # read data of "1/2/2007" and "2/2/2007", so 2 * 24 * 60 = 2880 samples

    hpc <- read.table(filename, colClasses=classes, stringsAsFactors = FALSE,
                      sep=";", skip=66637, nrow=2880)
    names(hpc) <- names(tab5rows)
    rm(tab5rows)

    png(file = "plot1.png", width = 480, height = 480, bg = "transparent")
    hist(hpc$Global_active_power, xlab="Global Active Power (kilowatts)", 
         main = "Global Active Power", col="red")

    # dev.copy(png, file = "plot1.png", width = 480, height = 480, bg = "transparent")
    dev.off()
}