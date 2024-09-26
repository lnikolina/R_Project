# Učitavanje potrebnih paketa
library(readxl)

file_path <- "/Users/nikolinalekaj/Library/Mobile Documents/com~apple~CloudDocs/FIPU/HCI/PROJEKT/HCI (Responses).xlsx"
df <- read_excel(file_path)

colnames(data)

# Kreiranje varijable za anksioznost
data$Anksioznost <- ifelse(data$`Utjecaj.na.mentalno.zdravlje..Osjećate.li.povećanu.anksioznost.zbog.stalnih.obavijesti.koje.pristižu.s.Vašeg.mobilnog.uređaja.` >= 4, "Anksioznost", "Nema anksioznosti")

# Provjera rezultata
table(data$Anksioznost)

# Kreiranje tablice učestalosti za negativne emocije (anksioznost)
table_anksioznost <- table(data$Anksioznost)

# Prikaz tablice učestalosti
print(table_anksioznost)


# Chi-square test
chisq_test <- chisq.test(table_anksioznost)

# Prikaz rezultata χ² testa
print(chisq_test)

# Kreiranje grafičkog prikaza za anksioznost
library(ggplot2)
ggplot(data, aes(x = Anksioznost, fill = Anksioznost)) +
  geom_bar() +
  labs(title = "Anxiety Levels Among Users", x = "Anxiety", y = "Number of Users") +
  scale_fill_manual(values = c("lightblue", "pink"))
