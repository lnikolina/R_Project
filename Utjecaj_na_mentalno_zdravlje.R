
install.packages("readxl")
install.packages("ggplot2")
install.packages("dplyr")

library(readxl)
library(ggplot2)
library(dplyr)


file_path <- "/Users/nikolinalekaj/Library/Mobile Documents/com~apple~CloudDocs/FIPU/HCI/PROJEKT/HCI (Responses).xlsx"
data <- read_excel(file_path)


colnames(data)


# Seelektiranje
selected_columns <- c(
  "Utjecaj na mentalno zdravlje:\nOsjećate li povećanu anksioznost zbog stalnih obavijesti koje pristižu s Vašeg mobilnog uređaja?",
  "Koliko često provjeravate mobilne obavijesti tijekom dana?",
  "Kako biste opisali svoj opći stav prema mobilnim obavijestima?",
  "Opći utjecaj tehnologije:\nSmatrate li da bi Vaša produktivnost bila veća kada biste u potpunosti isključili obavijesti tijekom rada?"
)

filtered_data <- data[, selected_columns]


summary(filtered_data)


