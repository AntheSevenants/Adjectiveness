participle_counts <- read.csv("participles.csv")
unique_participles <- unique(participle_counts$participle)
participle_counts <- xtabs(frequency ~ participle, participle_counts)

adjective_counts <- read.csv("adjectives.csv")
unique_adjectives <- unique(adjective_counts$adjective)
adjective_counts <- xtabs(frequency ~ adjective, adjective_counts)

# TODO: should I only count bare forms, or also declensed forms?

adjectiveness_vector = c()
declensed_adjectiveness_vector = c()
total_adjectiveness_vector = c()

for (participle in unique_participles) {
  adjectiveness <- NULL
  
  participle_count <- participle_counts[participle]
  adjective_count <- adjective_counts[participle]
  # We check for declensed adjectives
  declensed_adjective_count <- 0
  declensed_adjective <- paste0(participle, "e")
  if (declensed_adjective %in% unique_adjectives) {
    declensed_adjective_count <- adjective_counts[declensed_adjective]
  }
  total_adjective_count <- adjective_count + declensed_adjective_count
  
  # If this participle doesn't appear as an adjective, the adjectiveness is,
  # naturally, zero
  if (is.na(adjective_count)) {
    adjectiveness <- 0
    declensed_adjectiveness <- 0
    total_adjectiveness <- 0
  # Else, just compute the adjectiveness
  } else {
    # Regular adjectiveness (undeclensed)
    adjectiveness <- adjective_count / (participle_count + adjective_count)
    adjectiveness <- round(adjectiveness, digits=4)
    
    # Declensed adjectiveness
    declensed_adjectiveness <- declensed_adjective_count / 
      (participle_count + declensed_adjective_count)
    declensed_adjectiveness <- round(declensed_adjectiveness, digits=4)
    
    # Total adjectiveness
    total_adjectiveness <- total_adjective_count / 
      (participle_count + total_adjective_count)
    total_adjectiveness <- round(total_adjectiveness, digits=4)
  }
  
  adjectiveness_vector <- append(adjectiveness_vector, adjectiveness)
  declensed_adjectiveness_vector <- append(declensed_adjectiveness_vector, declensed_adjectiveness)
  total_adjectiveness_vector <- append(total_adjectiveness_vector, total_adjectiveness)
}

df <- data.frame(participle = unique_participles,
                 adjectiveness = adjectiveness_vector,
                 declensed_adjectiveness = declensed_adjectiveness_vector,
                 total_adjectiveness = total_adjectiveness_vector)

write.csv(df, "adjectiveness.csv", row.names=FALSE)
