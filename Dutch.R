participles <- read.csv("participles.csv")
adjectives <- read.csv("adjectives.csv")

unique_participles <- unique(participles$participle)
participle_counts <- table(participles[["participle"]])

unique_adjectives <- unique(adjectives$adjective)
adjective_counts <- table(adjectives[["adjective"]])

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

write.csv(df, "adjectiveness.csv")
