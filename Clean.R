# 
# INTERNAL USE ONLY
# 
# I use this script to remove the superfluous information from my datasets

# Load the participles dataset
participles <- read.csv("ParticiplesAnthe.csv")
# Bye junk
participles <- subset(participles,
                      select = c(participle, participle_lemma))

# Fix tokenisation errors
participles$participle <- gsub("", "", participles$participle)
participles$participle <- gsub("-", "", participles$participle)
participles$participle <- gsub("\\.", "", participles$participle)
participles$participle <- gsub("«", "", participles$participle)
participles$participle <- gsub("»", "", participles$participle)
participles$participle <- tolower(participles$participle)

# Load the adjectives dataset
adjectives <- read.csv("AdjectivesAnthe.csv")
# Bye junk
adjectives <- subset(adjectives,
                     select = c(participle, participle_lemma))
# Fix my mistake
names(adjectives) <- c("adjective", "adjective_lemma")

# Fix tokenisation errors
adjectives$adjective <- gsub("", "", adjectives$adjective)
adjectives$adjective <- gsub("-", "", adjectives$adjective)
adjectives$adjective <- gsub("«", "", adjectives$adjective)
adjectives$adjective <- gsub("\\.", "", adjectives$adjective)
adjectives$adjective <- gsub("»", "", adjectives$adjective)
adjectives$adjective <- tolower(adjectives$adjective)

write.csv(participles, "participles.csv")
write.csv(adjectives, "adjectives.csv")
