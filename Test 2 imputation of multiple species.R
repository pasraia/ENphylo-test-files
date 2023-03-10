### Installing/Updating packages
required<-c("ape", "raster", "methods","CENFA","pbapply","Rphylopars","RRphylo","dismo","gtools",
            "adehabitatMA", "ecospat", "foreach", "doParallel", "PresenceAbsence", 
            "parallel", "ade4", "sp", "biomod2", "terra", "sf", "adehabitatHS", "devtools")
if(any(!required%in%installed.packages()[,1]))
  install.packages(required[which(!required%in%installed.packages()[,1])])

latest_version<-c("ecospat","dismo","biomod2")
latest_version[which(latest_version%in%rownames(old.packages()))]->to_update
if(length(to_update)>0) install.packages(to_update)

sapply(required,require,character.only=TRUE)

### Loading Data and RRdtn package
setwd("YOUR_DIRECTORY")

getwd()->main.dir
url<-"https://www.dropbox.com/s/wm7qcuwm0nm35w2/ENphylo%20code%26data%202.zip?dl=1"
download.file(url,file.path(main.dir,"ENphylo code&data 2.zip"),mode="wb")
unzip("ENphylo code&data 2.zip")
load("ENphylo code&data/example_data.RData")
source("ENphylo code&data/ecospat.ESM.EnsembleModeling_CUSTOM.R")
source("ENphylo code&data/ecospat.ESM.Projection_CUSTOM.R")
source("ENphylo code&data/ecospat.ESM.Modeling_CUSTOM.R")
MASK_FULL<-raster::raster("ENphylo code&data/variable_bio1.tif")

install_github("pasraia/RRdtn")
require(RRdtn)

### running analyses ####
perc<-30 ### set the percentage of species to be imputed, we tested this in the 10-30% range
spec_to_impute<-replicate(50,{sample(1:length(DATA_FULL), round(length(DATA_FULL)*perc/100))}, simplify = F)

dir.create("tree_30",recursive=T)

tree_30<-for (jj in spec_to_impute){
  
  setwd("tree_30")

  Species_data_start<-DATA_FULL[jj]
  
  Species_data1<-pblapply(Species_data_start,subset,OBS==1)
  Species_data0<-pblapply(Species_data_start,subset,OBS==0)
  
  test_imputed<-ENphylo_modeling(external_enfa_models=enfa_all_species,
                                 spec_for_imputation=names(enfa_all_species[jj]),
                                 tree=tree,
                                 nsim=10,
                                 si=0.5,
                                 si2=0.5,
                                 eval_metric_for_imputation="AUC",
                                 output_options="full",
                                 eval_threshold=0.7)
  
  gc()
  
  test_imputed[jj]->test_imputed
  
  lapply(1:length(test_imputed),function(x){
    test_imputed[[x]]$calibrated_model$evaluation->xx
    names(test_imputed[x])->xx$species
    xx
  })->res
  do.call(rbind,res)->res
  save(res,file=paste(basename(tempfile()),".RData",sep=""))
  
  gc()
  closeAllConnections()
  
  setwd(main.dir)
}


  
