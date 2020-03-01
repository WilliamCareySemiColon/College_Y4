
# install.packages("purrr")
# install.packages("tibble")
# install.packages("stringr")
# install.packages("tidyr")
# install.packages("forcats")
The UK Office for National Statistics provides yearly data on the most popular baby names from 1996 to 2015. The data is provided separately for boys and girls and is stored in Excel spreadsheets.

There is a zipped folder in Brightspace Week 5 called boys. This contains a folder with excel workbooks for different years.  Download this into your data subfolder and uncompress it. 

Our mission is to extract and graph the top 100 boys names in England and Wales for every year from 1996 to 2015. There are several things that make this challenging.
library(tidyverse)

boy.file.names<-list.files("./data/boys",all.files=FALSE, full.names=TRUE)

boy.file.names

length(boy.file.names)

boy.file.names<-boy.file.names[2:length(boy.file.names)]
boy.file.names

boy.file.names[[1]]

library(readxl)
excel_sheets(boy.file.names[[1]])

excel_sheets(boy.file.names[[20]])

library(purrr)
map(boy.file.names, excel_sheets)

library(stringr)
str_subset(excel_sheets(boy.file.names[[2]]), "Table 1")

get.data.sheet.name <- function(file, pattern) {
    str_subset(excel_sheets(file), pattern)
}

#Now we can map this new function over our vector of file names.

map(boy.file.names,
    get.data.sheet.name,
    pattern = "Table 1")

tmp <- read_excel(
    boy.file.names[1],
    sheet = get.data.sheet.name(boy.file.names[1],
                                pattern = "Table 1"),
    col_names=TRUE,
    .name_repair="universal",
    skip = 6)

library(dplyr, quietly=TRUE)
glimpse(tmp)

str(tmp)

  ## 1. Write a function that takes a file name as an argument and reads
  ##    the worksheet containing "Table 1" from that file.
  read.baby.names <- function(file) {
      sheet.name <- str_subset(excel_sheets(file), "Table 1")
      read_excel(file, sheet = sheet.name, col_names=TRUE,
                 .name_repair="unique",
                 skip = 6)
  }
  
  ## 2. Test your function by using it to read *one* of the boys names
  ##    Excel files.
  glimpse(read.baby.names(boy.file.names[1]))

  ## 3. Use the `map` function to read data from all the Excel files,
  ##    using the function you wrote in step 1.
  boysNames <- map(boy.file.names, read.baby.names)

str(boysNames[1])



for(i in 1:length(boysNames)) {
    if (ncol(boysNames[[i]])==7){
#        str(boysNames[i])
        boysNames[[i]]=select(boysNames[[i]],Name...2, Name...6, Count...3, Count...7)
        boysNames[[i]]=rename(boysNames[[i]], Name = Name...2)
        boysNames[[i]]=rename(boysNames[[i]], Count = Count...3)
        boysNames[[i]]=rename(boysNames[[i]], Name__1 = Name...6)
        boysNames[[i]]=rename(boysNames[[i]], Count__1 = Count...7)
        
        
#rename(iris, petal_length = Petal.Length)
        }
    else if (ncol(boysNames[[i]])==9){
        #str(boysNames[i])
        boysNames[[i]]=select(boysNames[[i]],Name...2, Name...7, Count...3, Count...8)
#         boysNames[[i]]=rename(boysNames[[i]], Name...6 = Name...7)
#         boysNames[[i]]=rename(boysNames[[i]], Count...7 = Count...8)
        boysNames[[i]]=rename(boysNames[[i]], Name = Name...2)
        boysNames[[i]]=rename(boysNames[[i]], Count = Count...3)
        boysNames[[i]]=rename(boysNames[[i]], Name__1 = Name...7)
        boysNames[[i]]=rename(boysNames[[i]], Count__1 = Count...8)
    } else if (ncol(boysNames[[i]])==11){
        
        #str(boysNames[i])
        boysNames[[i]]=select(boysNames[[i]],Name...2, Name...8, Count...3, Count...9)
#         boysNames[[i]]=rename(boysNames[[i]], Name...6 = Name...8)
#         boysNames[[i]]=rename(boysNames[[i]], Count...7 = Count...9)
        boysNames[[i]]=rename(boysNames[[i]], Name = Name...2)
        boysNames[[i]]=rename(boysNames[[i]], Count = Count...3)
        boysNames[[i]]=rename(boysNames[[i]], Name__1 = Name...8)
        boysNames[[i]]=rename(boysNames[[i]], Count__1 = Count...9)
    }
#        
}



# #clean.baby.data.sheet<- function(file, pattern) {
# clean.baby.data.sheet<- function(file) {
#     file <- select (file,  Name...2, Name...6, Count...3, Count...7)
#     boysNames[[1]] <- drop_na(boysNames[[1]])
#     )
# #   file <- select (file,  pattern)

# #clean.baby.data.sheet(boysNames[2],c( Name...2, Name...6, Count...3, Count...7))
# clean.baby.data.sheet(boysNames[1])
# #boysNames[[1]] <- select(boysNames[[1]], Name...2, Name...6, Count...3, Count...7)


get.data.sheet.name <- function(file, pattern) {
    str_subset(excel_sheets(file), pattern)
}

#Finally, we will want to filter out missing ??? do this for all the elements in boysNames, a task I leave to you.

  ## 1. Write a function that takes a `data.frame` as an argument and
  ##    returns a modified version including only columns named `Name`,
  ##    `Name__1`, `Count`, or `Count__1`.

  namecount <- function(data) {
      data <-drop_na(data)
      str(data)
      # boysNames[[1]] <- drop_na(boysNames[[1]])

      #select(boysNames[[i]],Name...2, Name...6, Count...3, Count...7)
       #rename(data, Name=Name...2=Name)
#       rename(data, Count=Count...3)
#       rename(data, Name_1=Name...6)
#       rename(data, Count_1=Count...7)
#       select(data, Name, Name_1, Count, Count_1)
       select(data,Name, Name__1, Count, Count__1)
  }
     
  ## 2. Test your function on the first `data.frame` in the list of baby
  ##    names data.

  namecount(boysNames[[19]])

onelist<-function(data)(
bind_rows(select(data, Name, Count),
           select(data, Name = Name__1, Count = Count__1))
)
#onelist(boysNames[[2]])
map(
    boysNames, onelist)

## write a function that does all the cleanup
cleanupNamesData <- function(x) {
    filtered <- filter(x, !is.na(Name)) # drop rows with no Name value
    selected <- select(filtered, Name, Count, Name__1, Count__1) # select just Name and Count columns
    bind_rows(select(selected, Name,  Count), # re-arrange into two columns
              select(selected, Name = Name__1, Count = Count__1))
}
cleanupNamesData(boysNames[[1]])
## test it out on the second data.frame in the list
glimpse(boysNames[[2]]) # before cleanup

boysNames <- map(boysNames, cleanupNamesData)

glimpse(head(boysNames))

years <- str_extract(boy.file.names, "[0-9]{4}")
boysNames <- setNames(boysNames, years)
glimpse(head(boysNames))

boysNames <- imap(boysNames,
                  function(data, name) {
                      mutate(data, Year = as.integer(name))
                      })
boysNames <- bind_rows(boysNames)

glimpse(boysNames)

Exercise: Make one big table
Turn the list of boys names data.frames into a single table.

Create a directory under data/all and write the data to a .csv file.

Finally, repeat the previous exercise, this time working with the data in one big table.

Exercise prototype
Working with the data in one big table is often easier.

boysNames <- bind_rows(boysNames)

dir.create("data/all")
## Warning in dir.create("data/all"): 'data/all' already exists
write_csv(boysNames, "data/all/boys_names.csv")

## What where the five most popular names in 2013?
slice(arrange(filter(boysNames, Year == 2013),
              desc(Count)),
      1:5)
## # A tibble: 5 x 3
##   Name    Count  Year
##   <chr>   <dbl> <int>
## 1 OLIVER   6949  2013
## 2 JACK     6212  2013
## 3 HARRY    5888  2013
## 4 JACOB    5126  2013
## 5 CHARLIE  5039  2013
## How has the popularity of the name "ANDREW" changed over time?
andrew <- filter(boysNames, Name == "ANDREW")

ggplot(andrew, aes(x = Year, y = Count)) +
    geom_line() +
    ggtitle("Popularity of \"Andrew\", over time")


