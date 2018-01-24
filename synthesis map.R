library(raster)
library(rgdal)
library(rworldmap) # library rworldmap provides different types of global maps, e.g:


###This file contains  a preliminary map for the synthesis paper of the Biotropica paper###

####DATASETS####
syn <- read.delim("synthesis dataset.txt")
str(syn)

####SPATIAL INFORMATION####
locs <- data.frame(site = syn$site, longitude = syn$long, latitude = syn$lat, colour = syn$colour)
coordinates(locs) <- c("longitude","latitude")
crs.geo <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84")  # geographical, datum WGS84
proj4string(locs) <- crs.geo  # define projection system of our data
#summary(locs)

#tiff(filename = "ATBC map.tif", height = 600, width = 1600, pointsize = 24)
newmap <- getMap(resolution = "low")

tiff(filename = "synthesis map.tif", height = 600, width = 1600, pointsize = 24)
plot(newmap,  xlim = c(-100, 130), ylim = c(-23, 23), asp =1 )
colpoints <- paste(syn$colour, "", sep = "")
points(locs, pch = 20, col = colpoints, cex = 2)
legend(50,-10, col = c("red", "blue"), pch = 20, bty = "n", legend = c("sites included in this issue", "other existing long-term sites"), pt.cex = 2)
dev.off()


#writeOGR(locs, dsn =paste(getwd(),"WS2016.kml" ,sep="/"), layer="locs", driver = "KML")

