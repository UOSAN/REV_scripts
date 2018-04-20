import os
from datetime import datetime

# Set study info (change these for your study)
group = "sanlab"
study = "REV"

# Set directories (Check these for your study)

# logdir = os.getcwd() + "/logs_bidsQC"
# bidsdir = "/projects/" + group + "/shared/" + study + "/bids_data_copy"
# tempdir = bidsdir + "/tmp_dcm2bids"
# outputlog = logdir + "/outputlog_bidsQC" + datetime.now().strftime("%Y%m%d-%H%M%S") + ".txt"
# errorlog = logdir + "/errorlog_bidsQC" + datetime.now().strftime("%Y%m%d-%H%M%S") + ".txt"
# derivatives = bidsdir + "/derivatives"

# Set directories for local testing
bidsdir = "/Users/kristadestasio/Desktop/bids_data"
logdir = bidsdir + "/logs_bidsQC"
tempdir = bidsdir + "/tmp_dcm2bids"
outputlog = logdir + "/outputlog_bidsQC_" + datetime.now().strftime("%Y%m%d-%H%M") + ".txt"
errorlog = logdir + "/errorlog_bidsQC_" + datetime.now().strftime("%Y%m%d-%H%M") + ".txt"
derivatives = bidsdir + "/derivatives"
