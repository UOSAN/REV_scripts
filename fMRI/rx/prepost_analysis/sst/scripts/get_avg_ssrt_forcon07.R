# Cange the contrast number and the subject list to match that contrast subject list
contrast <- 'con_07' 
subjectlist <- c(044, 114, 003, 035, 090, 141, 070, 102, 052, 039, 111, 069, 097, 084, 027, 075, 011, 118, 023, 080, 065, 036, 100, 094, 010, 029, 037, 041, 074, 142, 073, 121, 021, 018, 076, 077, 031, 050, 107, 082, 056, 022, 048, 115, 006, 024, 093, 140, 131, 108, 144, 054, 104, 109, 130, 137, 129, 053, 098, 016, 046, 017, 110, 126, 135, 067, 020, 038, 127, 089, 086, 013, 001, 060, 078)

setwd(paste0('~/Desktop/REV_scripts/fMRI/rx/prepost_analysis/sst/scripts'))
load('~/Desktop/REV_scripts/behavioral/REV_SST/scripts/analyses/df_ssrt.Rda')
df_ssrt <- df_ssrt[which(df_ssrt$id %in% subjectlist), ]
df_ssrt <- unique(df_ssrt[!is.na(df_ssrt$prepost),c(1:2,9)])
tt <- table(df_ssrt$id)
df_ssrt <- df_ssrt[df_ssrt$id %in% names(tt[tt > 1]), ]
df_ssrt$id <- factor(df_ssrt$id)
df_ssrt$prepost <- relevel(df_ssrt$prepost, ref = "pre")
differences_inverted <- aggregate(df_ssrt$ssrt_avg, by = list(id = df_ssrt$id), FUN = diff)
change_in_ssrt <- -differences_inverted$x

write.table(change_in_ssrt, paste0("ssrt_change_covariate_", contrast, ".txt"), 
            sep = "\t", 
            row.names = FALSE, 
            col.names = FALSE)

table(sign(differences_inverted$x))
