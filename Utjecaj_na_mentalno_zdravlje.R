# Izračunaj prosječnu razinu anksioznosti
prosjek_anksioznosti <- mean(df$`Utjecaj na mentalno zdravlje:\nOsjećate li povećanu anksioznost zbog stalnih obavijesti koje pristižu s Vašeg mobilnog uređaja?`, na.rm = TRUE)

# Ispis prosječne razine anksioznosti
print(prosjek_anksioznosti)



df$anksioznost <- as.numeric(factor(df$`Utjecaj na mentalno zdravlje:\nOsjećate li povećanu anksioznost zbog stalnih obavijesti koje pristižu s Vašeg mobilnog uređaja?`,
                                    levels = c("Nimalo", "Malo", "Neutralan/a", "Dosta", "Veoma"),
                                    labels = c(1, 2, 3, 4, 5)))

df$ucestalost_obavijesti <- as.numeric(factor(df$`Koliko često provjeravate mobilne obavijesti tijekom dana?`,
                                              levels = c("Nikada", "Rijetko", "Ponekad", "Često", "Stalno"),
                                              labels = c(1, 2, 3, 4, 5)))

df$opci_stav <- as.numeric(factor(df$`Kako biste opisali svoj opći stav prema mobilnim obavijestima?`,
                                  levels = c("Pozitivan", "Neutralan", "Negativan"),
                                  labels = c(1, 2, 3)))

df$utjecaj_tehnologije <- as.numeric(factor(df$`Opći utjecaj tehnologije:\nSmatrate li da bi Vaša produktivnost bila veća kada biste u potpunosti isključili obavijesti tijekom rada?`,
                                            levels = c("Da", "Ne", "Nisam siguran/a"),
                                            labels = c(1, 2, 3)))


relevant_columns <- c("Utjecaj na mentalno zdravlje:\nOsjećate li povećanu anksioznost zbog stalnih obavijesti koje pristižu s Vašeg mobilnog uređaja?",
                      "Koliko često provjeravate mobilne obavijesti tijekom dana?",
                      "Kako biste opisali svoj opći stav prema mobilnim obavijestima?",
                      "Opći utjecaj tehnologije:\nSmatrate li da bi Vaša produktivnost bila veća kada biste u potpunosti isključili obavijesti tijekom rada?")

Hipoteza2 <- df[, relevant_columns]

