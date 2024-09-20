colnames(data)

# necessary libraries
library(dplyr)


# relevant columns positive productivity
positive_productivity_data <- data %>%
  select(
    Pomažu_obavljanju_zadataka = `Efikasnost:\nMolim Vas da označite u kojoj mjeri se slažete ili ne slažete s navedenim izjavama koristeći sljedeću skalu: ["Mobilne obavijesti mi pomažu pri obavljanju zadataka zbog brzih informacija."]`,
    Korisne_svakodnevni_zadaci = `Efikasnost:\nMolim Vas da označite u kojoj mjeri se slažete ili ne slažete s navedenim izjavama koristeći sljedeću skalu: ["Smatram da su mobilne obavijesti korisne za moje svakodnevne zadatke."]`,
    Pomažu_ostati_u_toku = `Efikasnost:\nMolim Vas da označite u kojoj mjeri se slažete ili ne slažete s navedenim izjavama koristeći sljedeću skalu: ["Obavijesti s mobitela me ne ometaju već mi pomažu da ostanem u toku i dok sam udubljen/a u rad."]`,
    Bitno_za_obavijesti_privatni_zivot = `Efikasnost:\nMolim Vas da označite u kojoj mjeri se slažete ili ne slažete s navedenim izjavama koristeći sljedeću skalu: ["Bitno mi je da dobijem obavijest na mobitelu dok sam na poslu zbog mogućih opasnosti iz privatnog života."]`
  )

#Likert scale values to numerical (1 to 5), 
positive_productivity_data <- positive_productivity_data %>%
  mutate(across(everything(), ~ recode(.,
                                       "Potpuno se ne slažem" = 1,
                                       "Ne slažem se" = 2,
                                       "Nisam siguran/a" = 3,
                                       "Slažem se" = 4,
                                       "Potpuno se slažem" = 5,
                                       .default = NA_real_  # Specify NA_real_ for numerical data
  )))

# View the transformed data again to check
head(positive_productivity_data)