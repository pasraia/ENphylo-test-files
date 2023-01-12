Dropbox folder contains:
1) 'ENphylo code&data 2.zip' includes R data codes and raw data to run all the analyses as shown in 'Test 1 imputation of one species at a time.R', 'Test 2 imputation of multiple species.R', and 'ENphylo model predictions and mapping.R'. 
	- ecospat.ESM.EnsembleModeling_CUSTOM, ecospat.ESM.EnsembleProjection_CUSTOM, ecospat.ESM.Modeling_CUSTOM, ecospat.ESM.Projection_CUSTOM are
	R custom functions useful to run ESM on "Test 1..." code.
	- variable_bio1.tif is a raster object encompassing the background area enclosing all the species in the tree.
	- external_data is a folder including GeoTiff files at 22 kilo years onto which ENFA or ENphylo models may be projected (only for "Mapping ENphylo model predictions.R" code, see below)

		- example_data.RData is the R workspace containing:
		+ tree: a phylo object which includes all 31 species modelled in the analysis.
		+ DATA_FULL: a named list containing raw data already formatted to run ENphylo_modeling function. 
		+ enfa_all_species: a named list containing the output of ENphylo_modeling function where each species was modelled with ENFA algorithm.

2) 'Test 1 imputation of one species at a time.R' runs ENphylo on a single selected species, you may change upon your wish:
	1- which species is to be used to run ENphylo
	2- ENphylo settings

3) 'Test 2 imputation of multiple species.R' allows to test the accuracy of ENphylo running simulataneous estimation for multiple species
	1- you may change the percentage of species to be used to run ENphylo at line 25 (not tested with >30%) and some other ENphylo settings

4) 'ENphylo model predictions and mapping.R' allows to run ENphylo_prediction on individual species and produce suitability maps at 22 kilo years



INSTRUCTIONS:
1) Please download 'Test 1 imputation of one species at a time.R' or 'Test 2 imputation of multiple species.R' or 'ENphylo model predictions and mapping.R' from GitHub, or all of them upon your need.
2) Please run the lines under the headings "### Installing/Updating packages" and "### Loading Data and RRdtn package". 
Notice: AT RUNNING TEST 2 or THE PREDICTION AND MAPPING SCRIPT YOU DO NOT NEED TO INSTALL THE PACKAGES AND DOWNLOAD THE DATA AGAIN.
