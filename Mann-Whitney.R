# Učitavanje potrebnih paketa
library(readxl)

file_path <- "/Users/nikolinalekaj/Library/Mobile Documents/com~apple~CloudDocs/FIPU/HCI/PROJEKT/HCI (Responses).xlsx"
df <- read_excel(file_path)

colnames(data)

# Mapiranje tekstualnih odgovora na numeričke vrijednosti
data$Distrakcija_Numeric <- recode(data$Distrakcija..Molim.Vas.da.označite.u.kojoj.mjeri.se.slažete.ili.ne.slažete.s.navedenim.izjavama.koristeći.sljedeću.skalu.....Mobilne.obavijesti.me.često.prekidaju.dok.obavljam.važne.zadatke...,
                                   "Potpuno se ne slažem" = 1,
                                   "Ne slažem se" = 2,
                                   "Neutralan/a" = 3,
                                   "Nisam siguran/a" = 3,  # Za 'Nisam siguran/a'
                                   "Slažem se" = 4,
                                   "Potpuno se slažem" = 5)

# Provjera rezultata mapiranja
table(data$Distrakcija_Numeric)


#Provođenje Mann-Whitney U testa:

# Uspoređivanje korisnika društvenih mreža s ostalim korisnicima
social_media_users <- data$Distrakcija_Numeric[data$Koje.aplikacije.najčešće.koristite.na.svom.pametnom.telefonu...Možete.odabrati.više.odgovora.. == "Društvene mreže (Facebook, Instagram, Twitter, itd.)"]
other_users <- data$Distrakcija_Numeric[data$Koje.aplikacije.najčešće.koristite.na.svom.pametnom.telefonu...Možete.odabrati.više.odgovora.. != "Društvene mreže (Facebook, Instagram, Twitter, itd.)"]

# Mann-Whitney U test
wilcox.test(social_media_users, other_users, alternative = "two.sided")

colnames(data)


# Stvaranje grupa na temelju korištenih aplikacija
social_media_users <- data$Distrakcija_Numeric[data$Koje.aplikacije.najčešće.koristite.na.svom.pametnom.telefonu...Možete.odabrati.više.odgovora.. == "Društvene mreže (Facebook, Instagram, Twitter, itd.)"]
other_users <- data$Distrakcija_Numeric[data$Koje.aplikacije.najčešće.koristite.na.svom.pametnom.telefonu...Možete.odabrati.više.odgovora.. != "Društvene mreže (Facebook, Instagram, Twitter, itd.)"]

# Vizualizacija razine distrakcije između korisnika društvenih mreža i ostalih korisnika
boxplot(Distrakcija ~ Korisnici, 
        data = data.frame(Korisnici = c(rep("Social Media Users", length(social_media_users)), 
                                        rep("Other Users", length(other_users))),
                          Distrakcija = c(social_media_users, other_users)),
        main = "Distraction Level: Social Media Users vs. Other Users",
        ylab = "Distraction Level (1 - Strongly Disagree, 5 - Strongly Agree)",
        xlab = "Users",
        col = c("lightblue", "pink"))


