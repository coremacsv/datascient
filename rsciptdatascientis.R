#----------------PULIZIA DEL FILE----------------------
#IN QUESTO CASO ABBIAMO TRASFORMATO TUTTE LE VALUTE IN EURO E ABBIAMO RINOMINATO/RIMOSSO 
#ALCUNE VARIABILI PER NOI NON IMPORTANTI 

data <- read.csv("data/ds_salaries.csv")

# Tasso di cambio attuale per le diverse valute
tasso_di_cambio_usd <- 0.92
tasso_di_cambio_gbp <- 1.09
# Aggiungi altri tassi di cambio per le valute desiderate

# Conversione delle righe con valute diverse da EUR in euro
data$salary <- ifelse(data$salary_currency == "EUR", data$salary, 
                      ifelse(data$salary_currency == "USD", data$salary * tasso_di_cambio_usd,
                             ifelse(data$salary_currency == "GBP", data$salary * tasso_di_cambio_gbp,
                                    data$salary)))

# Modifica il nome della variabile "salary" in "salary_in_EUR"
colnames(data)[colnames(data) == "salary"] <- "salary_in_EUR"

# Rimozione della variabile "salary_currency" se non più necessaria
data$salary_currency <- NULL

# Salva le modifiche
write.csv(data, "data/datascient_nuovo.csv", row.names = FALSE)



#---------INIZIAMO AD UTILIZZARE IL FILE PULITO-------------------

#---generiamo un grafico che rappresenta la media salario di ogni professione all'interno del dataset-----

library(plotly)
library(dplyr)

# Leggi i dati
dati <- read.csv("data/datascient_nuovo.csv")

# Genera il grafico a dispersione
grafico <- ggplot(dati, aes(x = job_title, y = salary_in_EUR, color = job_title, size = salary_in_EUR)) +
  geom_point(alpha = 0.7) +
  labs(x = "Professione", y = "Salary (EUR)", title = "Confronto degli Stipendi per Lavoro") +
  theme_minimal() +
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 45, hjust = 1))

# Converti il grafico in un grafico interattivo con plotly
grafico_interattivo <- ggplotly(grafico, tooltip = c("job_title", "salary_in_EUR"), dynamicTicks = TRUE)

# Visualizza il grafico interattivo
print(grafico_interattivo)



#------------------------











