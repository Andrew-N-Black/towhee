##Load ResistanceGA
library(terra, lib.loc = "/home/jeon96/R/bell/4.1.2-gcc-9.3.0-rw7vp7m/")
library(raster, lib.loc = "/home/jeon96/R/bell/4.1.2-gcc-9.3.0-rw7vp7m/")
library(sf, lib.loc = "/home/jeon96/R/bell/4.1.2-gcc-9.3.0-rw7vp7m/")
library(ResistanceGA, lib.loc = "/home/jeon96/R/bell/4.1.2-gcc-9.3.0-rw7vp7m/")
library(rgdal, lib.loc = "/home/jeon96/R/bell/4.1.2-gcc-9.3.0-rw7vp7m/")
library(dplyr)
library(parallel)
detectCores()

setwd(dir = "/scratch/bell/jeon96/Towhee/")
dir.create(file.path("/scratch/bell/jeon96/Towhee/rga/"))
write.dir <- "/scratch/bell/jeon96/Towhee/rga/"

##Load data
# Genetic data
towhee_fst <- readRDS("towhee_fst.rds")
towhee_fst <- as.matrix(towhee_fst)
towheeF_fst <- readRDS("towheeF_fst.rds")
towheeF_fst <- as.matrix(towheeF_fst)
towheeM_fst <- readRDS("towheeM_fst.rds")
towheeM_fst <- as.matrix(towheeM_fst)

# Load and aggregate raster data
covariates <- readRDS("towhee_stack.rds")


# Coordinates data
towhee_sites <- read.csv("towhee_longlat.csv")
towhee_sites_ord <- towhee_sites %>% arrange(desc(Lat)) #arrange sites by descending latitude
towhee_sites_coords_raw <- SpatialPoints(coords = towhee_sites_ord[,2:3], proj4string = CRS("+proj=longlat +datum=WGS84 +no_defs"))
towhee_sites_coords <- spTransform(towhee_sites_coords_raw, crs(covariates))

towheeF_sites <- read.csv("towheeF_longlat.csv")
towheeF_sites_ord <- towheeF_sites %>% arrange(desc(Lat)) #arrange sites by descending latitude
towheeF_sites_coords_raw <- SpatialPoints(coords = towheeF_sites_ord[,2:3], proj4string = CRS("+proj=longlat +datum=WGS84 +no_defs"))
towheeF_sites_coords <- spTransform(towheeF_sites_coords_raw, crs(covariates))

towheeM_sites <- read.csv("towheeM_longlat.csv")
towheeM_sites_ord <- towheeM_sites %>% arrange(desc(Lat)) #arrange sites by descending latitude
towheeM_sites_coords_raw <- SpatialPoints(coords = towheeM_sites_ord[,2:3], proj4string = CRS("+proj=longlat +datum=WGS84 +no_defs"))
towheeM_sites_coords <- spTransform(towheeM_sites_coords_raw, crs(covariates))

# Reorder gd matrices according to the descending latitude
th_order <- towhee_sites_ord$Pop_ID
towhee_fst_ord <- towhee_fst[order(factor(rownames(towhee_fst), levels = th_order)),order(factor(colnames(towhee_fst), levels = th_order))] 

th_orderF <- towheeF_sites_ord$Pop_ID
towheeF_fst_ord <- towheeF_fst[order(factor(rownames(towheeF_fst), levels = th_orderF)),order(factor(colnames(towheeF_fst), levels = th_orderF))] 

th_orderM <- towheeM_sites_ord$Pop_ID
towheeM_fst_ord <- towheeM_fst[order(factor(rownames(towheeM_fst), levels = th_orderM)),order(factor(colnames(towheeM_fst), levels = th_orderM))] 

# Separate each raster layer for ResistanceGA functions later
# Assign "10 * maximum value of each layer" for NA values
ele <- raster("dem_res_ext.tif")
ele_lowres <- terra::aggregate(ele, fact=20, fun="mean", cores=64, na.rm = TRUE)
ele_lowres@data@values[is.nan(ele_lowres@data@values)]<-NA
ele_lowres <- setMinMax(ele_lowres)
ele_lowres[is.na(ele_lowres)] <- 10*maxValue(ele_lowres)
writeRaster(ele_lowres, filename = paste0(write.dir,"ele_low.asc"), overwrite = TRUE)
ele_lowres<-raster("/scratch/bell/jeon96/Towhee/rga/ele_low.asc")

bio1 <- raster("bio1_res_ext.tif")
bio1_lowres <- terra::aggregate(bio1, fact=20, fun="mean", cores=64, na.rm = TRUE)
bio1_lowres@data@values[is.nan(bio1_lowres@data@values)]<-NA
bio1_lowres <- setMinMax(ele_lowres)
bio1_lowres[is.na(bio1_lowres)] <- 10*maxValue(bio1_lowres)
writeRaster(bio1_lowres, filename = paste0(write.dir,"bio1_low.asc"), overwrite = TRUE)
bio1_lowres<-raster("/scratch/bell/jeon96/Towhee/rga/bio1_low.asc")

bio12 <- raster("bio12_res_ext.tif")
bio12_lowres <- terra::aggregate(bio12, fact=20, fun="mean", cores=64, na.rm = TRUE)
bio12_lowres@data@values[is.nan(bio12_lowres@data@values)]<-NA
bio12_lowres <- setMinMax(bio12_lowres)
bio12_lowres[is.na(bio12_lowres)] <- 10*maxValue(bio12_lowres)
writeRaster(bio12_lowres, filename = paste0(write.dir,"bio12_low.asc"), overwrite = TRUE)
bio12_lowres<-raster("/scratch/bell/jeon96/Towhee/rga/bio12_low.asc")

bio2 <- raster("bio2_res_ext.tif")
bio2_lowres <- terra::aggregate(bio2, fact=20, fun="mean", cores=64, na.rm = TRUE)
bio2_lowres@data@values[is.nan(bio2_lowres@data@values)]<-NA
bio2_lowres <- setMinMax(bio2_lowres)
bio2_lowres[is.na(bio2_lowres)] <- 10*maxValue(bio2_lowres)
writeRaster(bio2_lowres, filename = paste0(write.dir,"bio2_low.asc"), overwrite = TRUE)
bio2_lowres<-raster("/scratch/bell/jeon96/Towhee/rga/bio2_low.asc") # needs to be rerendered from ".asc" file

bio4 <- raster("bio4_res_ext.tif")
bio4_lowres <- terra::aggregate(bio4, fact=20, fun="mean", cores=64, na.rm = TRUE)
bio4_lowres@data@values[is.nan(bio4_lowres@data@values)]<-NA
bio4_lowres <- setMinMax(bio4_lowres)
bio4_lowres[is.na(bio4_lowres)] <- 10*maxValue(bio4_lowres)
writeRaster(bio4_lowres, filename = paste0(write.dir,"bio4_low.asc"), overwrite = TRUE)
bio4_lowres<-raster("/scratch/bell/jeon96/Towhee/rga/bio4_low.asc")

bio15 <- raster("bio15_res_ext.tif")
bio15_lowres <- terra::aggregate(bio15, fact=20, fun="mean", cores=64, na.rm = TRUE)
bio15_lowres@data@values[is.nan(bio15_lowres@data@values)]<-NA
bio15_lowres <- setMinMax(bio15_lowres)
bio15_lowres[is.na(bio15_lowres)] <- 10*maxValue(bio15_lowres)
writeRaster(bio15_lowres, filename = paste0(write.dir,"bio15_low.asc"), overwrite = TRUE)
bio15_lowres<-raster("/scratch/bell/jeon96/Towhee/rga/bio15_low.asc")

slo <- raster("slope_res_ext.tif")
slo_lowres <- terra::aggregate(slo, fact=20, fun="mean", cores=64, na.rm = TRUE)
slo_lowres@data@values[is.nan(slo_lowres@data@values)]<-NA
slo_lowres <- setMinMax(slo_lowres)
slo_lowres[is.na(slo_lowres)] <- 10*maxValue(slo_lowres)
writeRaster(slo_lowres, filename = paste0(write.dir,"slo_low.asc"), overwrite = TRUE)
slo_lowres<-raster("/scratch/bell/jeon96/Towhee/rga/slo_low.asc")

asp <- raster("aspect_res_ext.tif")
asp_lowres <- terra::aggregate(asp, fact=20, fun="mean", cores=64, na.rm = TRUE)
asp_lowres@data@values[is.nan(asp_lowres@data@values)]<-NA
asp_lowres <- setMinMax(asp_lowres)
asp_lowres[is.na(asp_lowres)] <- 10*maxValue(asp_lowres)
writeRaster(asp_lowres, filename = paste0(write.dir,"asp_low.asc"), overwrite = TRUE)
asp_lowres<-raster("/scratch/bell/jeon96/Towhee/rga/asp_low.asc")

lancov <- raster("landcover_rec_ext.tif")
lancov_lowres <- terra::aggregate(lancov, fact=20, fun="modal", cores=64, na.rm = TRUE)
lancov_lowres@data@values[is.nan(lancov_lowres@data@values)]<-NA
lancov_lowres <- setMinMax(lancov_lowres)
lancov_lowres[is.na(lancov_lowres)] <- 10*maxValue(lancov_lowres)
writeRaster(lancov_lowres, filename = paste0(write.dir,"lancov_low.asc"), overwrite = TRUE)
lancov_lowres<-raster("/scratch/bell/jeon96/Towhee/rga/lancov_low.asc")

covariates_hbt_lowres <- stack(ele_lowres, slo_lowres, asp_lowres, lancov_lowres) #habitat model covariates
covariates_clim_lowres <- stack(bio1_lowres, bio12_lowres, bio2_lowres, bio4_lowres, bio15_lowres) #habitat model covariates
covariates_lan_lowres <- stack(lancov_lowres) #habitat model covariates
covariates_topo_lowres <- stack(ele_lowres, slo_lowres, asp_lowres)
saveRDS(covariates_hbt_lowres, "covariates_hbt_lowres.rds")
saveRDS(covariates_clim_lowres, "covariates_clim_lowres.rds")
saveRDS(covariates_lan_lowres, "covariates_lan_lowres.rds")
saveRDS(covariates_topo_lowres, "covariates_topo_lowres.rds")

write.table(towhee_sites_coords,file=paste0(write.dir,"towhee_sites_coords.txt"),sep="\t",col.names=F,row.names=F)
th.locales <- read.table("/scratch/bell/jeon96/Towhee/rga/towhee_sites_coords.txt")
th.locales <- SpatialPoints(th.locales[,c(1,2)])
crs(th.locales) <- crs(covariates)

write.table(towheeF_sites_coords,file=paste0(write.dir,"towheeF_sites_coords.txt"),sep="\t",col.names=F,row.names=F)
th.localesF <- read.table("/scratch/bell/jeon96/Towhee/rga/towheeF_sites_coords.txt")
th.localesF <- SpatialPoints(th.localesF[,c(1,2)])
crs(th.localesF) <- crs(covariates)

write.table(towheeM_sites_coords,file=paste0(write.dir,"towheeM_sites_coords.txt"),sep="\t",col.names=F,row.names=F)
th.localesM <- read.table("/scratch/bell/jeon96/Towhee/rga/towheeM_sites_coords.txt")
th.localesM <- SpatialPoints(th.localesM[,c(1,2)])
crs(th.localesM) <- crs(covariates)

print("Data loading and preprocessing has been finished.")

## towhee all ind.
dir.create(file.path("/scratch/bell/jeon96/Towhee/rga/out/"))
dir.create(file.path("/scratch/bell/jeon96/Towhee/rga/all/"))
dir.create(file.path("/scratch/bell/jeon96/Towhee/rga/all/hbt/"))
dir.create(file.path("/scratch/bell/jeon96/Towhee/rga/all/clim/"))
dir.create(file.path("/scratch/bell/jeon96/Towhee/rga/all/lan/"))
dir.create(file.path("/scratch/bell/jeon96/Towhee/rga/all/topo/"))
hbt_out_dir <- "/scratch/bell/jeon96/Towhee/rga/all/hbt/"
clim_out_dir <- "/scratch/bell/jeon96/Towhee/rga/all/clim/"
lan_out_dir <- "/scratch/bell/jeon96/Towhee/rga/all/lan/"
topo_out_dir <- "/scratch/bell/jeon96/Towhee/rga/all/topo/"

dir.create(file.path("/scratch/bell/jeon96/Towhee/rga/female/"))
dir.create(file.path("/scratch/bell/jeon96/Towhee/rga/female/topo/"))
topo_out_dir <- "/scratch/bell/jeon96/Towhee/rga/female/topo/"

dir.create(file.path("/scratch/bell/jeon96/Towhee/rga/male/"))
dir.create(file.path("/scratch/bell/jeon96/Towhee/rga/male/topo/"))
topo_out_dir <- "/scratch/bell/jeon96/Towhee/rga/male/topo/"

gdist.inputs <- gdist.prep(n.Pops = length(th.locales),
                           samples = th.locales,
                           response = as.vector(lower(towhee_fst_ord)),
                           method = 'commuteDistance')
                           
gdistF.inputs <- gdist.prep(n.Pops = length(th.localesF),
                           samples = th.localesF,
                           response = as.vector(lower(towheeF_fst_ord)),
                           method = 'commuteDistance')
                           
gdistM.inputs <- gdist.prep(n.Pops = length(th.localesM),
                           samples = th.localesM,
                           response = as.vector(lower(towheeM_fst_ord)),
                           method = 'commuteDistance')
                           
hbt_GA.inputs <- GA.prep(method = "LL",
                         ASCII.dir = covariates_hbt_lowres,
                         scale = FALSE,
                         Results.dir = hbt_out_dir,
                         parallel = 64)

hbt_MS_results <- MS_optim(gdist.inputs = gdist.inputs,
                           GA.inputs = hbt_GA.inputs)
saveRDS(hbt_MS_results, file="/scratch/bell/jeon96/Towhee/rga/all/hbt_MS_results.rds")     
print("Habitat Multi-surface model has been optimized.")

clim_GA.inputs <- GA.prep(method = "LL",
                          ASCII.dir = covariates_clim_lowres,
                          scale = FALSE,
                          Results.dir = clim_out_dir,
                          parallel = 64)

clim_MS_results <- MS_optim(gdist.inputs = gdist.inputs,
                            GA.inputs = clim_GA.inputs)
saveRDS(clim_MS_results, file="/scratch/bell/jeon96/Towhee/rga/all/clim_MS_results.rds")     
print("Climate Multi-surface model has been optimized.")

lan_GA.inputs <- GA.prep(method = "LL",
                         ASCII.dir = covariates_lan_lowres,
                         scale = FALSE,
                         Results.dir = lan_out_dir,
                         parallel = 64)

lan_SS_results <- SS_optim(gdist.inputs = gdist.inputs,
                           GA.inputs = lan_GA.inputs)
saveRDS(lan_SS_results, file="/scratch/bell/jeon96/Towhee/rga/all/lan_SS_results.rds")     
print("Landcover Multi-surface model has been optimized.")

topo_GA.inputs <- GA.prep(method = "LL",
                          ASCII.dir = covariates_topo_lowres,
                          scale = FALSE,
                          Results.dir = topo_out_dir,
                          parallel = 64)

topo_MS_results <- MS_optim(gdist.inputs = gdist.inputs,
                            GA.inputs = topo_GA.inputs)

topoF_MS_results <- MS_optim(gdist.inputs = gdistF.inputs,
                            GA.inputs = topo_GA.inputs)
                            
topoM_MS_results <- MS_optim(gdist.inputs = gdistM.inputs,
                            GA.inputs = topo_GA.inputs)
                                                                                    
saveRDS(topo_MS_results, file="/scratch/bell/jeon96/Towhee/rga/all/topo_MS_results.rds") 
saveRDS(topoF_MS_results, file="/scratch/bell/jeon96/Towhee/rga/female/topo_MS_results.rds")  
saveRDS(topoM_MS_results, file="/scratch/bell/jeon96/Towhee/rga/male/topo_MS_results.rds") 
print("Topographic Multi-surface model has been optimized.")

# Boostrapping
# Extract relevant components from optimization outputs
# Make a list of cost/resistance distance matrices
hbt_MS_results <- readRDS("/scratch/bell/jeon96/Towhee/rga/all/hbt_MS_results.rds")
clim_MS_results <- readRDS("/scratch/bell/jeon96/Towhee/rga/all/clim_MS_results.rds")
lan_SS_results <- readRDS("/scratch/bell/jeon96/Towhee/rga/all/lan_SS_results.rds")
topo_MS_results <- readRDS("/scratch/bell/jeon96/Towhee/rga/all/topo_MS_results.rds")

th_mat.list <- c(hbt_MS_results$cd,
                 clim_MS_results$cd,
                 lan_SS_results$cd,
                 topo_MS_results$cd)

th_k <- rbind(hbt_MS_results$k,
              clim_MS_results$k,
              lan_SS_results$k,
              topo_MS_results$k)

# Create square distance matrix for response for use with
# the bootstrap function        
th_response <- matrix(0, 10, 10) #number of populations
th_response[lower.tri(th_response)] <- lower(towhee_fst_ord)

# Run bootstrap (obs = num.pop)
(th_AIC.boot <- Resist.boot(mod.names = names(th_mat.list),
                            dist.mat = th_mat.list,
                            n.parameters = th_k[,2],
                            sample.prop = 0.75,
                            iters = 1000,
                            obs = 10,
                            genetic.mat = th_response))
saveRDS(th_AIC.boot, file = "/scratch/bell/jeon96/Towhee/rga/all/th_AIC_result.RDS")
write.table(th_AIC.boot, file = "/scratch/bell/jeon96/Towhee/rga/all/th_AIC_result.txt")
print("Bootstrapping has been finished.")
print("All RGA anayses has been finished.")