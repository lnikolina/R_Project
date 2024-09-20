library(readxl)  # Učitaj biblioteku za čitanje Excel fajlova
library(ggplot2)  # Učitaj biblioteku za pravljenje grafova
library(dplyr)  # Učitaj biblioteku za manipulaciju podacima
library(tidyr)  # Učitaj biblioteku za preuređivanje podataka

# Definiraj putanju do fajla
file_path <- "/Users/nikolinalekaj/Library/Mobile Documents/com~apple~CloudDocs/FIPU/HCI/PROJEKT/HCI (Responses).xlsx"
data <- read_excel(file_path)  # Učitaj podatke iz Excel fajla

# Odaberi kolone koje su nam potrebne za analizu
selected_columns <- c(
  "Utjecaj na mentalno zdravlje:\nOsjećate li povećanu anksioznost zbog stalnih obavijesti koje pristižu s Vašeg mobilnog uređaja?",
  "Koliko često provjeravate mobilne obavijesti tijekom dana?",
  "Kako biste opisali svoj opći stav prema mobilnim obavijestima?",
  "Opći utjecaj tehnologije:\nSmatrate li da bi Vaša produktivnost bila veća kada biste u potpunosti isključili obavijesti tijekom rada?"
)

# Odaberi samo te kolone iz skupa podataka
filtered_data <- data[, selected_columns]

# Konvertiraj sve kolone u karaktere da izbjegnemo grešku u pivot_longer()
filtered_data <- filtered_data %>%
  mutate(across(everything(), as.character))

# Sada trebamo preurediti podatke iz širokog formata u dugi format
long_data <- filtered_data %>%
  pivot_longer(
    cols = everything(),  # Sve kolone prebacujemo u dva stupca: pitanje i odgovor
    names_to = "Question",  # Kolona sa imenima pitanja
    values_to = "Response"  # Kolona sa odgovorima
  )

# Pravim graf za sve četiri varijable odjednom
ggplot(long_data, aes(x = Response)) +  # Definiram da želim brojati odgovore
  geom_bar() +  # Koristim bar chart (stupce)
  facet_wrap(~ Question, scales = "free_x") +  # Dijelim graf u četiri manja grafika, svaki za jedno pitanje
  labs(title = "Analysis of Mobile Notifications Impact", x = "Responses", y = "Number of Responses") +  # Dodajem naslove i imenujem osi
  theme_minimal() +  # Koristim minimalistički stil grafika
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotiram tekst na x-osi da se odgovori bolje vide
