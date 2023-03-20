participle_counts <- read.csv("participles.csv")
unique_participles <- unique(participle_counts$participle)
participle_counts <- xtabs(frequency ~ participle, participle_counts)

adjective_counts <- read.csv("adjectives.csv")
unique_adjectives <- unique(adjective_counts$adjective)
adjective_counts <- xtabs(frequency ~ adjective, adjective_counts)

# TODO: should I only count bare forms, or also declensed forms?

adjectiveness_vector = c()

for (participle in unique_participles) {
  adjectiveness <- NULL
  
  participle_count <- participle_counts[participle]
  adjective_count <- adjective_counts[participle]
  
  # If this participle doesn't appear as an adjective, the adjectiveness is,
  # naturally, zero
  if (is.na(adjective_count)) {
    adjectiveness <- 0
  # Else, just compute the adjectiveness
  } else {
    adjectiveness <- adjective_count / (participle_count + adjective_count)
    adjectiveness <- round(adjectiveness, digits=4)
  }
  
  adjectiveness_vector <- append(adjectiveness_vector, adjectiveness)
}

df <- data.frame(participle = unique_participles,
                 adjectiveness = adjectiveness_vector)

write.csv(df, "adjectiveness.csv", row.names=FALSE)
