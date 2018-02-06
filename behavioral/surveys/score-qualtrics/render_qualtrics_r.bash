#!/bin/bash
module add R
Rscript -e "library(rmarkdown);render('process_qualtrics_data.r')"

