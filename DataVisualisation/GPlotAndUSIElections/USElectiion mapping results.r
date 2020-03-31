

# Run any of the install.packages() commands below for packages that are not yet on your system
#  install.packages("shiny") 
#  install.packages("urltools")
#  install.packages("tmap")
#  install.packages("tmaptools")
#  install.packages("leaflet")
#  install.packages("leaflet.extras")
#  install.packages("rio")
#  install.packages("scales")
#  install.packages("htmlwidgets")
#  install.packages("sf")
#  install.packages("dplyr")

# Set various values needed, including names of files and FIPS codes for New Hampshire and South Carolina
nhdatafilecsv <- "./data/NHD2016.csv"
scdatafile <- "./data/SCGOP2016.csv"

usshapefile <- "./Maps/cb_2014_us_county_5m.shp"
scfipscode <- "45"
nhfipscode <- "33"
# Load the tmap, tmaptools, and leaflet packages into your working session: 
library("tmap")
library("tmaptools")
library("leaflet")
library("sf")
library("leaflet.extras")
library("dplyr")

#nhdata <- rio::import(nhdatafile)


# Read in the 2016 Presidential Primary - Democratic President New Hampshire election results file:
nhdata <- rio::import(nhdatafilecsv)

# Eliminate columns for minor candidates and just use County, Clinton and Sanders columns:
nhdata <- nhdata[,c("County", "Clinton", "Sanders")]

# Add columns for percents and margins:
nhdata$SandersMarginVotes <- nhdata$Sanders - nhdata$Clinton
nhdata$SandersPct <- (nhdata$Sanders) / (nhdata$Sanders + nhdata$Clinton) # Will use formatting later to multiply by a hundred
nhdata$ClintonPct <- (nhdata$Clinton) / (nhdata$Sanders + nhdata$Clinton)
nhdata$SandersMarginPctgPoints <- nhdata$SandersPct - nhdata$ClintonPct
head(nhdata)

# Read in the shapefile for US states and counties:
usgeo <- read_shape(file=usshapefile, as.sf = TRUE)

# Do a quick plot of the shapefile and check its structure:
qtm(usgeo)

str(usgeo)

usgeo$STATEFP
usgeo$NAME

# Subset just the NH data from the US shapefile
nhgeo <- usgeo[usgeo$STATEFP==nhfipscode,]
str(nhgeo)

# tmap test plot of the New Hampshire data
qtm(nhgeo)

# Check if county names are in the same format in both files
str(nhgeo$NAME)
str(nhdata$County)

# They're not. Change the county names to plain characters in nhgeo:
nhgeo$NAME <- as.character(nhgeo$NAME)
str(nhgeo$NAME)

# Order each data set by county name
nhgeo <- nhgeo[order(nhgeo$NAME),]
nhdata <- nhdata[order(nhdata$County),]

# Are the two county columns identical now? They should be:
identical(nhgeo$NAME,nhdata$County )

# Merge data with tmaptool's append_data function
nhmap <- append_data(nhgeo, nhdata, key.shp = "NAME", key.data="County")

# See the new data structure with
str(nhmap)

# Quick and easy maps as static images with tmap's qtm() function:
qtm(nhmap, "SandersMarginVotes")

qtm(nhmap, "SandersMarginPctgPoints")

str(nhmap)

# For more control over look and feel, use the tm_shape() function:
nhstaticmap <-tm_shape(nhmap) +
  tm_fill("SandersMarginVotes", title="Sanders Margin, Total Votes", palette = "PRGn")+
  tm_borders(alpha=.5) +
  tm_text("NAME",size=0.8) +
  tm_style("classic")
nhstaticmap

nhstaticmap

# save the map to a jpg file:
tmap_save(nhstaticmap, filename="./Plots/nhdemprimary.jpg")

library(Leaflet)

# Next up: Code for a basic interactive map, this time for Clinton percentages in NH

# Create a palette
clintonPalette <- colorNumeric(palette = "Blues", domain=nhmap$ClintonPct)

# and a pop-up window
library(scales)
nhpopup <- paste0("<b>County: ", 
                  nhmap$NAME, 
                  "</b><br />Sanders ", 
                  percent(nhmap$SandersPct), " - Clinton ", 
                  percent(nhmap$ClintonPct))

# Rename the county column from NAME to County with dplyr's rename function:

#nhmap <- rename(nhmap, County = NAME)


# Now the interactive map:
leaflet(nhmap) %>%
  addProviderTiles("CartoDB.Positron") %>%
  addPolygons(stroke=FALSE, 
              smoothFactor = 0.2, 
              fillOpacity = .8, 
              popup=nhpopup, 
              color= ~clintonPalette(nhmap$ClintonPct)
              )
  

# re-project
nhmap_projected <- sf::st_transform(nhmap, "+proj=longlat +datum=WGS84")
leaflet(nhmap_projected) %>%
  addProviderTiles("CartoDB.Positron") %>%
  addPolygons(stroke=FALSE, 
              smoothFactor = 0.2, 
              fillOpacity = .8, 
              popup=nhpopup, 
              color= ~clintonPalette(nhmap$ClintonPct)
  )

# South Carolina data
scdata <- rio::import(scdatafile)

# South Carolina shapefile:
scgeo <- dplyr::filter(usgeo, STATEFP==scfipscode)

# Quick plot of scgeo SC geospatial object:
qtm(scgeo)

# Add a column with percent of votes for each candidate. Candidates are in columns 2-7:
candidates <- colnames(scdata[2:7])
for(i in 2:7){
  j = i + 7
  temp <- scdata[[i]] / scdata$Total
  scdata[[j]] <- temp
  colnames(scdata)[j] <- paste0(colnames(scdata)[i], "Pct")
}  
  
# Get winner in each precinct
for(i in 1:nrow(scdata)){
  scdata$winner[i] <- names(which.max(scdata[i,2:7]))
}

# Import spreadsheet with percent of adult population holding at least a 4-yr college degree
sced <- rio::import("./Data/SCdegree.xlsx")


# Check if county names are in the same format in both files
str(scgeo$NAME)
str(scdata$County)

# Change the county names to plain characters in scgeo:
scgeo$NAME <- as.character(scgeo$NAME)

# Order each data set by county name
scgeo <- scgeo[order(scgeo$NAME),]
scdata <- scdata[order(scdata$County),]

# Are the two county columns identical now? They should be:
identical(scgeo$NAME,scdata$County )

# Add the election results and rename county column
scmap <- append_data(scgeo, scdata, key.data = "County", key.shp = "NAME")

scmap <- rename(scmap, County = NAME)
scmap <- append_data(scmap, sced, key.shp = "County", key.data = "County")

# Instead of just coloring the winner, let's color by strength of win with multiple layers
# Use same intensity for all - get minimum and maximum for the top 3 combined
minpct <- min(c(scmap$Donald.J.TrumpPct, scmap$Marco.RubioPct , scmap$Ted.CruzPct))
maxpct <- max(c(scmap$Donald.J.TrumpPct, scmap$Marco.RubioPct , scmap$Ted.CruzPct))

# Create leaflet palettes for each layer of the map:
winnerPalette <- colorFactor(palette=c("#984ea3", "#e41a1c"), domain = scmap$winner)
trumpPalette <- colorNumeric(palette = "Purples", domain=c(minpct, maxpct))
rubioPalette <- colorNumeric(palette = "Reds", domain = c(minpct, maxpct))
cruzPalette <- colorNumeric(palette = "Oranges", domain = c(minpct, maxpct))
edPalette <- colorNumeric(palette = "Blues", domain=scmap$PctCollegeDegree)

# Create a pop-up:
scpopup <- paste0("<b>County: ", scmap$County, "<br />Winner: ", scmap$winner, "</b><br /><br />Trump: ", percent(scmap$Donald.J.TrumpPct), "<br />Rubio: ", percent(scmap$Marco.RubioPct), "<br />Cruz: ", percent(scmap$Ted.CruzPct), "<br /><br />Pct w college ed: ", scmap$PctCollegeDegree, "% vs state-wide avg of 25%")

# Add the projection we know from the NH map we'll need for this data on a Leaflet map:
scmap <- sf::st_transform(scmap, "+proj=longlat +datum=WGS84")
# Basic interactive map showing winner in each county:

leaflet(scmap) %>%
  addProviderTiles("CartoDB.Positron") %>%
  addPolygons(stroke=TRUE,
              weight=1,
              smoothFactor = 0.2, 
              fillOpacity = .75, 
              popup=scpopup, 
              color= ~winnerPalette(scmap$winner),
              group="Winners"
  ) %>%

  addLegend(position="bottomleft", colors=c("#984ea3", "#e41a1c"), labels=c("Trump", "Rubio"))
# calculated the minimum and maximum for the combined Trump/Rubio/Cruz county results:

minpct <- min(c(scmap$Donald.J.TrumpPct, scmap$Marco.RubioPct , scmap$Ted.CruzPct))
maxpct <- max(c(scmap$Donald.J.TrumpPct, scmap$Marco.RubioPct , scmap$Ted.CruzPct))
#Now I can create a palette for each candidate using different colors but the same intensity range.

trumpPalette <- colorNumeric(palette = "Purples", domain=c(minpct, maxpct))
rubioPalette <- colorNumeric(palette = "Reds", domain = c(minpct, maxpct))
cruzPalette <- colorNumeric(palette = "Oranges", domain = c(minpct, maxpct))

winnerPalette <- colorFactor(palette=c("#984ea3", "#e41a1c"), domain = scmap$winner)
edPalette <- colorNumeric(palette = "Blues", domain=scmap$PctCollegeDegree)

scpopup <- paste0("County: ", scmap@data$County,
"Winner: ", scmap@data$winner,
"Trump: ", percent(scmap$Donald.J.TrumpPct),
"Rubio: ", percent(scmap$Marco.RubioPct),
"Cruz: ", percent(scmap$Ted.CruzPct),
"Pct w college ed: ", 
                  scmap$PctCollegeDegree, "% vs state-wide avg of 25%")

#Finally, before mapping, I know that I'm going to need to add the same projection that I needed for the New Hampshire map. 
#This code will add that projection to the scmap object:

scmap <- sf::st_transform(scmap, "+proj=longlat +datum=WGS84")

#This code shows a basic map of winners by county. Note that because only Trump and Rubio won counties in South Carolina, we can set up the legend to show only their colors and names:

# Put top 3 candidates in their own layers and add education layer, store in scGOPmap2 variable

scGOPmap2 <- leaflet(scmap) %>%
  addProviderTiles("CartoDB.Positron") %>%
  addPolygons(stroke=TRUE,
              weight=1,
              smoothFactor = 0.2, 
              fillOpacity = .75, 
              popup=scpopup, 
              color= ~winnerPalette(scmap$winner),
              group="Winners"
  ) %>% 
  addLegend(position="bottomleft", colors=c("#984ea3", "#e41a1c"), labels=c("Trump", "Rubio"))   %>%
  
  addPolygons(stroke=TRUE,
              weight=1,
              smoothFactor = 0.2, 
              fillOpacity = .75, 
              popup=scpopup, 
              color= ~trumpPalette(scmap$Donald.J.TrumpPct),
              group="Trump"
  ) %>%
  
  addPolygons(stroke=TRUE,
              weight=1,
              smoothFactor = 0.2, 
              fillOpacity = .75, 
              popup=scpopup, 
              color= ~rubioPalette(scmap$Marco.RubioPct),
              group="Rubio"
  ) %>%
  
  addPolygons(stroke=TRUE,
              weight=1,
              smoothFactor = 0.2, 
              fillOpacity = .75, 
              popup=scpopup, 
              color= ~cruzPalette(scmap$Ted.CruzPct),
              group="Cruz"
  ) %>%
  
  addPolygons(stroke=TRUE,
              weight=1,
              smoothFactor = 0.2, 
              fillOpacity = .75, 
              popup=scpopup, 
              color= ~edPalette(scmap$PctCollegeDegree),
              group="College degs"
  ) %>%
  
  addLayersControl(
    baseGroups=c("Winners", "Trump", "Rubio", "Cruz", "College degs"),
    position = "bottomleft",
    options = layersControlOptions(collapsed = FALSE)
  ) %>%
  addSearchOSM()

# View the scGOPmap2 map:
print(scGOPmap2)

# save as a self-contained HTML file
htmlwidgets::saveWidget(scGOPmap2, file="scGOPwidget2.html")

# save as an HTML file with dependencies in another directory:
htmlwidgets::saveWidget(widget=scGOPmap2, file="scGOPprimary_withdependencies.html", selfcontained=FALSE, libdir = "js")


