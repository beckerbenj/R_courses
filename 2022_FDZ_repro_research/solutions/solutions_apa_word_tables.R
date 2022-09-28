#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# APA-Tables in R - Solutions
# 
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




# Exercises
#===========================================================

# load the pisa-dataset from the data-folder
pisa <- readRDS("data//pisaPlus_CF.RDS")

# 1. Create a descriptives table for the variables "hisei", "pared" and "computer_age".
# Save the table as a APA-formatted Word-table.
apaTables::apa.cor.table(pisa[, c("hisei", "pared", "classsize")], 
                         filename = "pisa_apatable_descr.doc", 
                         landscape = FALSE)


# 2. Predict mathematical literacy at t1 (ma_wle_t1) using "hisei", "language", and "gender".
# Save the results in an APA-formatted Word-table.
reg1 <- lm(ma_wle_t1 ~ hisei + language + gender, data = pisa)
apaTables::apa.reg.table(reg1, 
                         filename = "pisa_apatable_reg.doc")


# 3. Create a cross frequency table for the variable "language" and "gender".
# Save the results in an APA-formatted Word-table.
freq_tab <- table(pisa$gender, pisa$computer_age)
freq_df <- as.data.frame(freq_tab)
freq_df_wide <- tidyr::pivot_wider(freq_df, names_from = "Var1", values_from = "Freq")
names(freq_df_wide)[1] <- "Age of first computer usage"

# sorting
freq_df_wide <- freq_df_wide[c(3, 4, 1, 2, 5), ]

nice_tab <- rempsyc::nice_table(freq_df_wide, title = c("Table 1", "Gender and Age of First Computer Usage"),
                                footnote = c("Absolute frequencies based on self-reported gender and first computer usage."))
rempsyc::save_as_docx(nice_tab, path = "pisa_rempsyc_freq.docx")




