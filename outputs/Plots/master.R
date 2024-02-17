
#Run Blue N project

#getdata
# Location of individual data scripts
script_folder <- "scripts/"

# List all files in the script folder with a .R extension
script_files <- list.files(script_folder, pattern = "\\.R$", full.names = TRUE)

# Loop through each script file and source it
for (script_file in script_files) {
  source(script_file)
}


#combinedata
source("scripts/synthesize/stackfromCCN.r")
source("scripts/synthesize/stackfromMaxwell.r")
source("scripts/synthesize/combine_all.r")

#plot data

source("plots/1.HistoScatterplot.r")       #Fig1
source("plots/2.NARcalculation.r")       #Fig2
source("plots/3a.globalrateplot_continent.r") #Fig3a
source("plots/3b.globalrateplot_world.r") #Fig3b
source("plots/Map_of_sites.r") #Fig S1
source("plots/violinplotofCNbyBD.r") #Fig S3