
library(dplyr)
library(tidyverse)
library(ggplot2)
library(lubridate)
library(sqldf)


# set strings as factors to false
options(stringsAsFactors = FALSE)

# download the data
# download.file(url = "https://ndownloader.figshare.com/files/7283285",
#               destfile = "./data/805325-precip-dailysum_2003-2013.csv",
#               method = "libcurl")

# import data
boulder_daily_precip <- read.csv("./data/805325-precip-dailysum_2003-2013.csv",
         header = TRUE,
         na.strings = 999.99)

# view structure of data
str(boulder_daily_precip)

# are there any unusual / No data values?
summary(boulder_daily_precip$DAILY_PRECIP)

# view first 6 lines of the data
head(boulder_daily_precip)
# view structure of data
str(boulder_daily_precip)
# are there any unusual / No data values?
summary(boulder_daily_precip$DAILY_PRECIP)
max(boulder_daily_precip$DAILY_PRECIP)

# format date field
boulder_daily_precip$DATE <- as.Date(boulder_daily_precip$DATE,
                                     format = "%m/%d/%y")


# plot the data using ggplot2
ggplot(data=boulder_daily_precip, aes(x = DATE, y = DAILY_PRECIP)) +
      geom_point() +
      labs(title = "Precipitation - Boulder, Colorado")

boulder_daily_precip <- boulder_daily_precip %>%
  na.omit()
# plot the data using ggplot2
ggplot(data=boulder_daily_precip, aes(x = DATE, y = DAILY_PRECIP)) +
      geom_point(color = "darkorchid4") +
      labs(title = "Precipitation - Boulder, Colorado")

#Don’t forget to add x and y axis labels to your plot! 
#Use the labs() function to add a title, x and y label (and subtitle if you’d like) to your plot.

labs(title = "Hourly Precipitation - Boulder Station\n 2003-2013",
     x = "Date",
     y = "Precipitation (Inches)")
ggplot(data = boulder_daily_precip, aes(DATE, DAILY_PRECIP)) +
      geom_point(color = "darkorchid4") +
      labs(title = "Hourly Precipitation - Boulder Station\n 2003-2013",
           x = "Date",
           y = "Precipitation (Inches)")

ggplot(data = boulder_daily_precip, aes(DATE, DAILY_PRECIP)) +
      geom_point(color = "darkorchid4") +
      labs(title = "Hourly Precipitation - Boulder Station\n 2003-2013",
           x = "Date",
           y = "Precipitation (Inches)") + theme_bw(base_size = 11)
Pipes let you take the output of one function and send it directly to the next, which is useful when you need to do many things to the same data set. Pipes in R look like %>% and are made available via the magrittr package, installed automatically with dplyr.
boulder_daily_precip <- boulder_daily_precip %>%
  na.omit()

# format date field without pipes
boulder_daily_precip$DATE <- as.Date(boulder_daily_precip$DATE,
                                     format = "%m/%d/%y")

boulder_daily_precip <- boulder_daily_precip %>%
  mutate(DATE = as.Date(DATE, format = "%m/%d/%y"))

#You can then add the na.omit() function to the above code

boulder_daily_precip <- boulder_daily_precip %>%
  mutate(DATE = as.Date(DATE, format = "%m/%d/%y")) %>%
  na.omit()

boulder_daily_precip %>%
  mutate(DATE = as.Date(boulder_daily_precip$DATE, format = "%m/%d/%y")) %>%
  na.omit() %>%
ggplot(aes(DATE, DAILY_PRECIP)) +
      geom_point(color = "darkorchid4") +
      labs(title = "Hourly Precipitation - Boulder Station\n 2003-2013",
           subtitle = "plotted using pipes",
           x = "Date",
           y = "Precipitation (Inches)") + theme_bw()

# subset 2 months around flood
precip_boulder_AugOct <- boulder_daily_precip %>%
                        filter(DATE >= as.Date('2013-08-15') & DATE <= as.Date('2013-10-15'))
#In the code above, you use the pipe to send the boulder_daily_precip data through a filter step. 
#In that filter step, you filter out only the rows within the date range that you specified. 
#Since %>% takes the object on its left and passes it as the first argument to the function on its right, 
#you don’t need to explicitly include it as an argument to the filter() function.

# check the first & last dates
min(precip_boulder_AugOct$DATE)
## [1] "2013-08-21"
max(precip_boulder_AugOct$DATE)
## [1] "2013-10-11"

# create new plot
ggplot(data = precip_boulder_AugOct, aes(DATE,DAILY_PRECIP)) +
  geom_bar(stat = "identity", fill = "darkorchid4") +
  xlab("Date") + ylab("Precipitation (inches)") +
  ggtitle("Daily Total Precipitation Aug - Oct 2013 for Boulder Creek") +
  theme_bw()




# plot the data using ggplot2 and pipes
boulder_daily_precip %>%
  na.omit() %>%
ggplot(aes(x = DATE, y = DAILY_PRECIP)) +
      geom_point(color = "darkorchid4") +
      facet_wrap( ~ YEAR ) +
      labs(title = "Precipitation - Boulder, Colorado",
           subtitle = "Use facets to plot by a variable - year in this case",
           y = "Daily precipitation (inches)",
           x = "Date") + theme_bw(base_size = 15) +
     # adjust the x axis breaks
     scale_x_date(date_breaks = "5 years", date_labels = "%m-%Y")

# plot the data using ggplot2 and pipes
boulder_daily_precip %>%
ggplot(aes(x = JULIAN, y = DAILY_PRECIP)) +
      geom_point(color = "darkorchid4") +
      facet_wrap( ~ YEAR, ncol = 3) +
      labs(title = "Daily Precipitation - Boulder, Colorado",
           subtitle = "Data plotted by year",
           y = "Daily Precipitation (inches)",
           x = "Day of Year") + theme_bw(base_size = 15)

# subset 2 months around flood
boulder_daily_precip %>%
  filter(JULIAN > 230 & JULIAN < 290) %>%
  ggplot(aes(x = JULIAN, y = DAILY_PRECIP)) +
      geom_bar(stat = "identity", fill = "darkorchid4") +
      facet_wrap( ~ YEAR, ncol = 3) +
      labs(title = "Daily Precipitation - Boulder, Colorado",
           subtitle = "Data plotted by year",
           y = "Daily precipitation (inches)",
           x = "Date") + theme_bw(base_size = 15)

# if you send the month function a particular date and specify the format, it returns the month
month(as.POSIXlt("01-01-2003", format = "%m-%d-%y"))
## [1] 1
month(as.POSIXlt("06-01-2003", format = "%m-%d-%y"))
## [1] 6

# extract just the date from the date field in your data.frame
head(month(boulder_daily_precip$DATE))
## [1] 1 1 2 2 2 2

# add a month column to your boulder_daily_precip data.frame
boulder_daily_precip <- boulder_daily_precip %>%
  mutate(month = month(DATE))

#boulder_daily_precip$test <- as.Date(paste0(boulder_daily_precip$month_year,"-01"),"%Y-%m-%d")

# calculate the sum precipitation for each month
boulder_daily_precip_month <- boulder_daily_precip %>%
  group_by(month) %>%
  summarise(sum_precip = sum(DAILY_PRECIP))

# subset 2 months around flood
boulder_daily_precip_month %>%
  ggplot(aes(x = month, y = sum_precip)) +
      geom_point(color = "darkorchid4") +
      labs(title = "Daily Precipitation - Boulder, Colorado",
           subtitle = "Data plotted by year",
           y = "Daily precipitation (inches)",
           x = "Date") + theme_bw(base_size = 15)

# calculate the sum precipitation for each month
boulder_daily_precip_month <- boulder_daily_precip %>%
  group_by(month, YEAR) %>%
  summarise(max_precip = sum(DAILY_PRECIP))

# subset 2 months around flood
boulder_daily_precip_month %>%
  ggplot(aes(x = month, y = max_precip)) +
      geom_bar(stat = "identity", fill = "darkorchid4") +
  facet_wrap(~ YEAR, ncol = 3) +
      labs(title = "Total Monthly Precipitation - Boulder, Colorado",
           subtitle = "Data plotted by year",
           y = "Daily precipitation (inches)",
           x = "Month") + theme_bw(base_size = 15)

# assign each month to the same year and day for plotting
as.Date(paste0("2015-", boulder_daily_precip_month$month,"-01"),"%Y-%m-%d")

# scale_x_date(date_labels = "%b")

# function with ggplot(), to format the x axis as a date.

# Note that %b represents the abbreviated month which will be plotted as labels on the x-axis.


boulder_daily_precip_month %>%
  mutate(month2 = as.Date(paste0("2015-", month,"-01"),"%Y-%m-%d")) %>%
  ggplot(aes(x = month2, y = max_precip)) +
      geom_bar(stat = "identity", fill = "red1") +
  facet_wrap(~ YEAR, ncol = 3) +
      labs(title = "Montly Total Daily Precipitation - Boulder, Colorado",
           subtitle = "Data plotted by year",
           y = "Daily precipitation (inches)",
           x = "Month") + theme_bw(base_size = 15) +
  scale_x_date(date_labels = "%b")
