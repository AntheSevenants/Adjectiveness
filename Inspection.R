df <- read.csv("adjectiveness.csv")

# Correlation: adjectiveness and declensed adjectiveness
cor.test(df$adjectiveness, df$declensed_adjectiveness)
# -> very bad measure by itself

# Correlation: adjectiveness and total adjectiveness
cor.test(df$adjectiveness, df$total_adjectiveness)
# -> very high correlation, it doesn't seem to matter

difference <- df$total_adjectiveness - df$adjectiveness

mean(difference)
median(difference)

# no real difference