
load("c:/Benjamin_Becker/21_IQB_Projekte/Campus Files/PISA-Plus-2012-2013_CF_v1/R/PISA-Plus-2012-2013_Dataset_CF.rda")
str(pisa_2012_2013_data)

library(eatGADS)
pisa_g <- import_spss("C:/Benjamin_Becker/21_IQB_Projekte/Campus Files/PISA-Plus-2012-2013_CF_v1/SPSS/PISA-Plus-2012-2013_Dataset_CF.sav")

pisa_g$dat <- pisa_g$dat[1:2000, ]
rem_vars <- grep("^sci|^Phind|^belong|^relation", namesGADS(pisa_g), value = TRUE)
pisa_g2 <- removeVars(pisa_g, rem_vars)

View(extractMeta(pisa_g2))
pisa_dat <- extractData(pisa_g2, convertLabels = "character")

saveRDS(pisa_dat, "C:/Benjamin_Becker/02_Repositories/workshops/R_courses/data/pisaPlus_CF.RDS")
pisa_meta <- unique(extractMeta(pisa_g2)[, c("varName", "varLabel")])

eatAnalysis::write_xlsx(pisa_meta, filePath = "C:/Benjamin_Becker/02_Repositories/workshops/R_courses/data/pisaPlus_labels.xlsx",
                        row.names = FALSE)
