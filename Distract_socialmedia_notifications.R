
library(readxl)

#Excel datoteke
file_path <- "/Users/nikolinalekaj/Library/Mobile Documents/com~apple~CloudDocs/FIPU/HCI/PROJEKT/HCI (Responses).xlsx"
df <- read_excel(file_path)

# Filtriranje korisnike koji koriste društvene mreže
drustvene_mreze_korisnici <- df[grepl("Društvene mreže", df$`Koje aplikacije najčešće koristite na svom pametnom telefonu?\n(Možete odabrati više odgovora.)`), ]

# Pretvaranje Likertove skale u numeričke vrijednosti
drustvene_mreze_korisnici$ometanje_numericko <- as.numeric(factor(
  drustvene_mreze_korisnici$`Percepcija utjecaja mobilnih obavijesti:\nMolim Vas da označite u kojoj mjeri se slažete ili ne slažete s navedenim izjavama koristeći sljedeću skalu: ["Mobilne obavijesti me često ometaju tijekom rada."]`,
  levels = c("Potpuno se ne slažem", "Ne slažem se", "Neutralan/a", "Slažem se", "Potpuno se slažem"),
  labels = c(1, 2, 3, 4, 5)
))

# Izračun prosječne razine ometanja
prosjek_ometanja <- mean(drustvene_mreze_korisnici$ometanje_numericko, na.rm = TRUE)

# Ispis prosjeka ometanja
print(prosjek_ometanja)




# Filtriranje korisnika koji ne koriste društvene mreže
ostali_korisnici <- df[!grepl("Društvene mreže", df$`Koje aplikacije najčešće koristite na svom pametnom telefonu?\n(Možete odabrati više odgovora.)`), ]

# Pretvaranje Likertove skale u numeričke vrijednosti za ostale korisnike
ostali_korisnici$ometanje_numericko <- as.numeric(factor(
  ostali_korisnici$`Percepcija utjecaja mobilnih obavijesti:\nMolim Vas da označite u kojoj mjeri se slažete ili ne slažete s navedenim izjavama koristeći sljedeću skalu: ["Mobilne obavijesti me često ometaju tijekom rada."]`,
  levels = c("Potpuno se ne slažem", "Ne slažem se", "Neutralan/a", "Slažem se", "Potpuno se slažem"),
  labels = c(1, 2, 3, 4, 5)
))

# Izračun prosječne razine ometanja za ostale korisnike
prosjek_ometanja_ostali <- mean(ostali_korisnici$ometanje_numericko, na.rm = TRUE)

# Ispis prosjeka ometanja za ostale korisnike
print(prosjek_ometanja_ostali)



#KREIRANJE PDF-a

pdf("analiza_ometanja.pdf")
print("Prosječna razina ometanja za korisnike društvenih mreža:")
print(prosjek_ometanja)
print("Prosječna razina ometanja za korisnike koji ne koriste društvene mreže:")
print(prosjek_ometanja_ostali)
dev.off()

#KREIRANJE GRAFOVA
grupe <- c("Društvene mreže", "Ostali korisnici")
prosjek_ometanja_grupe <- c(prosjek_ometanja, prosjek_ometanja_ostali)

barplot(prosjek_ometanja_grupe, names.arg = grupe, col = "pink", 
        main = "Usporedba ometanja: Društvene mreže vs. Ostali korisnici", 
        ylab = "Prosječna razina ometanja", ylim = c(0, 5))

pdf("graf_ometanja_roze.pdf")
barplot(prosjek_ometanja_grupe, names.arg = grupe, col = "pink", 
        main = "Usporedba ometanja: Društvene mreže vs. Ostali korisnici", 
        ylab = "Prosječna razina ometanja", ylim = c(0, 5))
dev.off()




# T-test za usporedbu ometanja između korisnika društvenih mreža i ostalih korisnika
t_test_rezultat <- t.test(drustvene_mreze_korisnici$ometanje_numericko, 
                          ostali_korisnici$ometanje_numericko, 
                          alternative = "two.sided", var.equal = FALSE)

# Ispis rezultata t-testa
print(t_test_rezultat)



#PDF T-TESTA

pdf("t_test_rezultat.pdf")
cat("T-test rezultati:\n\n")
cat("t-statistika: ", t_test_rezultat$statistic, "\n")
cat("Stupnjevi slobode: ", t_test_rezultat$parameter, "\n")
cat("P-vrijednost: ", t_test_rezultat$p.value, "\n")
cat("Interval povjerenja (95%): ", t_test_rezultat$conf.int[1], " do ", t_test_rezultat$conf.int[2], "\n")
cat("Prosječna razina ometanja - Društvene mreže: ", t_test_rezultat$estimate[1], "\n")
cat("Prosječna razina ometanja - Ostali korisnici: ", t_test_rezultat$estimate[2], "\n")