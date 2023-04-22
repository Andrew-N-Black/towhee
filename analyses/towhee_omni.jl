# Check and convert NoData values to NA in R
# e.g.,
#surf_f <- raster("/scratch/bell/jeon96/Towhee/rga/female/topo/Results/ele_low.slo_low.asp_low.asc")
#surf_f.all <- readAll(surf_f) 
#summary(surf_f.all)
#table(surf_f.all@data@values)
#hist(surf_f.all@data@values) 
#plot(surf_f.all)
#min(surf_f.all@data@values) # "min"=1
#surf_f.all[surf_f.all==1] <- NA
#hist(surf_f.all@data@values) # check again
#plot(surf_f.all) # check again
# name and save the raster as "surf_f.asc"
#writeRaster(surf_m.all, "surf_m.asc")


# Then now in julia
# Load packages
#using Pkg; Pkg.add(["Omniscape", "Rasters", "Plots"])
using Omniscape, Rasters, Plots

currmap, flow_pot, norm_current = run_omniscape("/scratch/bell/jeon96/Towhee/omni_config.ini")
                                                
exit()

# Again in R - plotting
#library(raster)
#library(colorspace)
#library(rasterVis)
#library(dplyr)
#library(latticeExtra)
#curr <- raster("/scratch/bell/jeon96/Towhee/omniscape/all/_3/cum_currmap.tif")
#mywindow <- extent(curr)
#towhee_sites <- read.csv("/scratch/bell/jeon96/Towhee/towhee_longlat.csv")
#towhee_sites_ord <- towhee_sites %>% arrange(desc(Lat)) #arrange sites by descending latitude
#towhee_sites_coords_raw <- SpatialPoints(coords = towhee_sites_ord[,2:3], proj4string = CRS("+proj=longlat +datum=WGS84 +no_defs"))
#towhee_sites_coords <- spTransform(towhee_sites_coords_raw, crs("+proj=longlat +datum=WGS84 +no_defs"))
##color <- colorspace::terrain_hcl(100,rev=TRUE)
##plot(curr, z=z, main="Cumulative Current Flow", xlab="Longitude", ylab="Latitude", col=color, ext=mywindow)
#breaks=seq(0,9,0.01) # common range among the three cases
#cols <- colorRampPalette(c("brown4", "lightgoldenrodyellow", "darkgreen"))(length(breaks) - 1)
#levelplot(curr, main="Cumulative Current Flow",  margin=FALSE, at = breaks, col.regions = cols) + layer(sp.points(towhee_sites_coords, pch=3, cex=1, col="darkblue"))

#tiff("all_cum_currmap_re.tif", width=6, height=6, units='in', res=300)
#levelplot(curr, main="Cumulative Current Flow",  margin=FALSE, at = breaks, col.regions = cols) + layer(sp.points(towhee_sites_coords, pch=3, cex=1, col="darkblue"))
#dev.off()

#setwd("/scratch/bell/jeon96/Towhee/omniscape/")
#ras <- raster("surf.asc")
#mywindow <- extent(ras)
#breaks=seq(0,19,0.01) # common range among the three cases
#cols <- colorRampPalette(c("darkgreen", "lightgoldenrodyellow", "brown4"))(length(breaks) - 1)
#towhee_sites <- read.csv("/scratch/bell/jeon96/Towhee/towhee_longlat.csv")
#towhee_sites_ord <- towhee_sites %>% arrange(desc(Lat)) #arrange sites by descending latitude
#towhee_sites_coords_raw <- SpatialPoints(coords = towhee_sites_ord[,2:3], proj4string = CRS("+proj=longlat +datum=WGS84 +no_defs"))
#towhee_sites_coords <- spTransform(towhee_sites_coords_raw, crs("+proj=longlat +datum=WGS84 +no_defs"))
#levelplot(ras, main="Optimized Resistance",  margin=FALSE, at = breaks, col.regions = cols, ext=mywindow) + layer(sp.points(towhee_sites_coords, pch=3, cex=1, col="darkblue"))

#tiff("all_resistance_re.tiff", units="in", width=6, height=6, res=300)
##plot(ras, main="Optimized Resistance", xlab="Longitude", ylab="Latitude", col=color, ext=mywindow)
##points(towhee_sites_coords, col="darkblue", pch=3)
#levelplot(ras, main="Optimized Resistance",  margin=FALSE, at = breaks, col.regions = cols, ext=mywindow) + layer(sp.points(towhee_sites_coords, pch=3, cex=1, col="darkblue"))
#dev.off()
