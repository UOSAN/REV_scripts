# Clear the environment
rm(list=ls())

# Set working directory
working_dir = "/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/expression_maps/betaseries"
#working_dir = "~/Desktop/expression_maps"
setwd(working_dir)

fileList = list.files(working_dir, pattern = '.txt', recursive = TRUE)
colnames <- c("ID", "beta_map", "neurosynth_map", "pattern_expression_value")

for (file in fileList) {
  
  # if the merged dataset doesn't exist, create it
  if (!exists('expression_map_data')) {
    expression_map_data = read.table(file.path(working_dir, file))
  }
  
  # if the merged dataset does exist, append to it
  else {
    tmp = read.table(file.path(working_dir, file))
    expression_map_data = dplyr::bind_rows(expression_map_data, tmp)
    rm(tmp)
  }
}

colnames(expression_map_data) = colnames

# Convert from long to wide format
expression_map_data <- tidyr::spread(expression_map_data, "neurosynth_map", "pattern_expression_value")

# Write data to a csv file
write.csv(expression_map_data, file=paste(working_dir, "pattern_expression_values_betaseries.csv", sep = "/"), row.names=FALSE)