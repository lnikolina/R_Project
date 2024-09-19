
library(readxl)
library(ggplot2)
library(dplyr)

file_path <- "/Users/nikolinalekaj/Library/Mobile Documents/com~apple~CloudDocs/FIPU/HCI/PROJEKT/HCI (Responses).xlsx"
data <- read_excel(file_path)

colnames(data)

selected_columns <- c(
  "Utjecaj na mentalno zdravlje:\nOsjećate li povećanu anksioznost zbog stalnih obavijesti koje pristižu s Vašeg mobilnog uređaja?",
  "Koliko često provjeravate mobilne obavijesti tijekom dana?",
  "Kako biste opisali svoj opći stav prema mobilnim obavijestima?",
  "Opći utjecaj tehnologije:\nSmatrate li da bi Vaša produktivnost bila veća kada biste u potpunosti isključili obavijesti tijekom rada?"
)

filtered_data <- data[, selected_columns]


summary(filtered_data)

# Plot 1: Impact on Mental Health - Anxiety
ggplot(filtered_data, aes(x = `Utjecaj na mentalno zdravlje:\nOsjećate li povećanu anksioznost zbog stalnih obavijesti koje pristižu s Vašeg mobilnog uređaja?`)) +
  geom_bar() +
  labs(title = "Impact on Mental Health - Anxiety Due to Notifications", x = "Responses", y = "Number of Responses") +
  theme_minimal()

# Plot 2: How Often Do You Check Mobile Notifications?
ggplot(filtered_data, aes(x = `Koliko često provjeravate mobilne obavijesti tijekom dana?`)) +
  geom_bar() +
  labs(title = "How Often Do You Check Mobile Notifications?", x = "Responses", y = "Number of Responses") +
  theme_minimal()

# Plot 3: General Attitude Towards Mobile Notifications
ggplot(filtered_data, aes(x = `Kako biste opisali svoj opći stav prema mobilnim obavijestima?`)) +
  geom_bar() +
  labs(title = "General Attitude Towards Mobile Notifications", x = "Responses", y = "Number of Responses") +
  theme_minimal()

# Plot 4: General Technology Impact on Productivity
ggplot(filtered_data, aes(x = `Opći utjecaj tehnologije:\nSmatrate li da bi Vaša produktivnost bila veća kada biste u potpunosti isključili obavijesti tijekom rada?`)) +
  geom_bar() +
  labs(title = "General Technology Impact on Productivity", x = "Responses", y = "Number of Responses") +
  theme_minimal()




# anova



# "Koliko često provjeravate mobilne obavijesti" factor (independent variable)
filtered_data$`Koliko često provjeravate mobilne obavijesti tijekom dana?` <- as.factor(filtered_data$`Koliko često provjeravate mobilne obavijesti tijekom dana?`)


anova_result <- aov(`Utjecaj na mentalno zdravlje:\nOsjećate li povećanu anksioznost zbog stalnih obavijesti koje pristižu s Vašeg mobilnog uređaja?` ~ `Koliko često provjeravate mobilne obavijesti tijekom dana?`, data = filtered_data)

summary(anova_result)

summary(anova_result)
