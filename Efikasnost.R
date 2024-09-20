colnames(data)

# necessary libraries
library(dplyr)

positive_productivity_columns_new <- c(
  "Efikasnost:\nMolim Vas da označite u kojoj mjeri se slažete ili ne slažete s navedenim izjavama koristeći sljedeću skalu: [\"Mobilne obavijesti mi pomažu pri obavljanju zadataka zbog brzih informacija.\"]",
  "Efikasnost:\nMolim Vas da označite u kojoj mjeri se slažete ili ne slažete s navedenim izjavama koristeći sljedeću skalu: [\"Smatram da su mobilne obavijesti korisne za moje svakodnevne zadatke.\"]",
  "Efikasnost:\nMolim Vas da označite u kojoj mjeri se slažete ili ne slažete s navedenim izjavama koristeći sljedeću skalu: [\"Obavijesti s mobitela me ne ometaju već mi pomažu da ostanem u toku i dok sam udubljen/a u rad.\"]",
  "Efikasnost:\nMolim Vas da označite u kojoj mjeri se slažete ili ne slažete s navedenim izjavama koristeći sljedeću skalu: [\"Bitno mi je da dobijem obavijest na mobitelu dok sam na poslu zbog mogućih opasnosti iz privatnog života.\"]"
)
#vadimo podatke iz data
positive_productivity_data_new <- data %>% select(all_of(positive_productivity_columns_new))

#izmjena naziva za laksu uporabu
colnames(positive_productivity_data_new) <- c(
  "Pomažu_obavljanju_zadataka",
  "Korisne_svakodnevni_zadaci",
  "Pomažu_ostati_u_toku",
  "Bitno_za_obavijesti_privatni_zivot"
)

#likertova skala s vrijednostima 1-5
positive_productivity_data_new <- positive_productivity_data_new %>%
  mutate(across(everything(), ~ recode(.,
                                       "Potpuno se ne slažem" = 1,
                                       "Ne slažem se" = 2,
                                       "Nisam siguran/a" = 3,
                                       "Slažem se" = 4,
                                       "Potpuno se slažem" = 5)))

#uvid
head(positive_productivity_data_new)  # Prikazuje prvih nekoliko redova u konzoli
View(positive_productivity_data_new)  # Otvara podatke u novom prozoru

write.csv(positive_productivity_data_new, "positive_productivity_data_new.csv", row.names = FALSE)


#plots

# Instalacija potrebnih paketa
#install.packages("tidyr")
#install.packages("ggplot2")

# Učitavanje paketa
library(tidyr)
library(ggplot2)

# Prilagodba punih naziva varijabli
positive_productivity_long <- positive_productivity_data_new %>%
  pivot_longer(cols = c(Pomažu_obavljanju_zadataka, Korisne_svakodnevni_zadaci,
                        Pomažu_ostati_u_toku, Bitno_za_obavijesti_privatni_zivot),
               names_to = "Varijabla",
               values_to = "Vrijednosti") %>%
  mutate(Varijabla = recode(Varijabla,
                            "Pomažu_obavljanju_zadataka" = "Mobilne obavijesti mi pomažu pri obavljanju zadataka zbog brzih informacija.",
                            "Korisne_svakodnevni_zadaci" = "Smatram da su mobilne obavijesti korisne za moje svakodnevne zadatke.",
                            "Pomažu_ostati_u_toku" = "Obavijesti s mobitela me ne ometaju već mi pomažu da ostanem u toku i dok sam udubljen/a u rad.",
                            "Bitno_za_obavijesti_privatni_zivot" = "Bitno mi je da dobijem obavijest na mobitelu dok sam na poslu zbog mogućih opasnosti iz privatnog života."))


# Pogled na long format podataka
head(positive_productivity_long)

# Izrada grafikona s punim upitima
ggplot(positive_productivity_long, aes(x = Vrijednosti, fill = Varijabla)) +
  geom_bar(position = "dodge", color = "black") +
  labs(title = "Efikasnost" ,
       x = "Odgovori (Likert skala)",
       y = "Broj ispitanika",
       fill = "Upit") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotiranje osi x ako ima puno varijabli




#SEM PLS
library(plspm)

# Definiramo unutarnji model (ovdje nema odnosa među konstruktorima)
productivity_path <- matrix(c(0, 0, 0, 0,  # redak za prvu latentnu varijablu
                              0, 0, 0, 0,  # redak za drugu latentnu varijablu
                              0, 0, 0, 0,  # redak za treću latentnu varijablu
                              0, 0, 0, 0), # redak za četvrtu latentnu varijablu
                            nrow = 4, ncol = 4, byrow = TRUE)

# Definiramo vanjski model - svaki konstruktor ima svoje indikatore
outer_model <- list(
  c("Pomažu_obavljanju_zadataka"),
  c("Korisne_svakodnevni_zadaci"),
  c("Pomažu_ostati_u_toku"),
  c("Bitno_za_obavijesti_privatni_zivot")
)

# Definiramo reflektivne modele za sve latentne varijable
modes <- c("A", "A", "A", "A")


#NA ERROR

# Zamjena Likertove skale vrijednostima 1-5 s dodatnim .default za sve ostalo
positive_productivity_data_new <- positive_productivity_data_new %>%
  mutate(across(everything(), ~ recode(.,
                                       "Potpuno se ne slažem" = 1,
                                       "Ne slažem se" = 2,
                                       "Nisam siguran/a" = 3,
                                       "Slažem se" = 4,
                                       "Potpuno se slažem" = 5,
                                       .default = NA_real_)))  # Dodan .default

# Uklanjanje redova s NA vrijednostima
positive_productivity_data_clean <- na.omit(positive_productivity_data_new)

# Pokretanje PLS modela s očišćenim podacima
productivity_pls <- plspm(positive_productivity_data_clean, productivity_path, outer_model, modes)

# Prikaz rezultata modela
summary(productivity_pls)

