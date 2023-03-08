# 
# INTERNAL USE ONLY
# 
# I use this script to remove the superfluous information from my datasets

fix_tokenisation = function(vector_) {
  gsub("[-.«»]", "", vector_)
}

# Load the participles dataset
participles <- read.csv("ParticiplesAnthe.csv")
pre_nrow <- nrow(participles)
# Remove duplicates
participles <- participles[!duplicated(participles[ , c("sentence",
                                                         "participle")]),]
after_nrow <- nrow(participles)

print(paste("Removed", pre_nrow - after_nrow, "duplicates"))

# Bye junk
participles <- subset(participles,
                      select = c(participle, participle_lemma))

# Fix tokenisation errors
participles$participle <- fix_tokenisation(participles$participle)
participles$participle <- tolower(participles$participle)

# Load the adjectives dataset
adjectives <- read.csv("AdjectivesAnthe.csv")
pre_nrow <- nrow(adjectives)
# Remove duplicates
adjectives <- adjectives[!duplicated(adjectives[ , c("sentence",
                                                     "participle")]),]
after_nrow <- nrow(adjectives)

print(paste("Removed", pre_nrow - after_nrow, "duplicates"))
# Bye junk
adjectives <- subset(adjectives,
                     select = c(participle, participle_lemma))
# Fix my mistake
names(adjectives) <- c("adjective", "adjective_lemma")

# Fix tokenisation errors
adjectives$adjective <- fix_tokenisation(adjectives$adjective)
adjectives$adjective <- tolower(adjectives$adjective)

participles_frequency <- as.data.frame(xtabs(~ participle, participles))
adjectives_frequency <- as.data.frame(xtabs(~ adjective, adjectives))

write.csv(participles_frequency, "participles.csv")
write.csv(adjectives_frequency, "adjectives.csv")
