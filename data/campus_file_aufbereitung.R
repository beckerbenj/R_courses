

load("~/Repositories/FDZ_autoReporting/20_campus files/IQB-LV-2011_SchuelerInnen-Eltern_CF.rda")

library(eatGADS)
gads <- import_spss("~/Repositories/FDZ_autoReporting/20_campus files/IQB-LV-2011_SchuelerInnen-Eltern_v2_CF.sav")

varLabels <- unique(extractMeta(gads)[, c("varName", "varLabel")])

fac_names <- namesGADS(gads)[!grepl("^SS|SB", namesGADS(gads))]
out <- extractData(gads, convertLabels = "factor", convertVariables = fac_names)

saveRDS(out, file = "~/Repositories/FDZ_autoReporting/20_campus files/lv11.RDS")
write.csv2(varLabels, file = "~/Repositories/FDZ_autoReporting/20_campus files/lv11_varLabels.csv", 
           row.names = FALSE)
