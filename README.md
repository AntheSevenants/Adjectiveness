# Adjectiveness
Compute the 'adjectiveness' of a past participle

This repository contains the scripts I used to compute the "adjectiveness" of, reasonably, almost *all* participles in Dutch.

## What is adjectiveness?

Past participles in Dutch (and probably also in other languages) can often be used as adjectives:

1. Het kind was gisteren rond 14u **verdwaald**.  
  "The child had **lost way** yesterday around 2 PM."
2. Een **verdwaald** kind komt meestal snel terug.  
   "A **lost way** child usually comes back fast." (very literal)

'Adjectiveness', then, is a measure which expresses how much a past participle is used as an adjective (like in example 2). The value ranges from 0 (never used as an adjective) to 1 (always used as an adjective).

## How can you compute adjectiveness?

In theory, it is really easy to compute adjeciveness for a specific participle:

```math
\frac{\text{uses as an adjective}}{\text{uses as an adjective + uses as a participle}}
```

However, how does one assess how many times a specific participle is used in language *as a whole*? To approximate this metric, I queried [LassyGroot](https://taalmaterialen.ivdnt.org/download/tstc-lassy-groot-corpus/) for *all* adjectives and *all* participles in the entire corpus. Then, I looked up for every undeclensed past participle form (e.g. no *verdwaald**e***) how often it appeared as a particple, and also how often it appeared as an adjective. With this information, I could compute adjectiveness for every participle.

## I do not want to run all these queries myself. Can I just download the output?

Sure. The CSV file is available under [releases](https://github.com/AntheSevenants/Adjectiveness/releases).

## I want to run all these queries myself. Where are your corpus files?

I queried all adjectives and participles using [mattenklopper](https://github.com/AntheSevenants/mattenklopper). There are a few issues with sharing the files created by this script:

* The output files were absolutely huge and totalled over 3 GB together.
* The output files include the sentence contexts of each attestation. Since adjectives and participles are so common, my output files come dangerously close to just re-sharing the LassyGroot corpus 'as-is', which I think violates the corpus licence.

I wrote a [cleaning script](https://github.com/AntheSevenants/Adjectiveness/blob/main/Clean.R) to scrub the sentence contexts and clean up the tokenisation. The output files of *this* script are still rather large (~ 800 MB), but could be shared on, for example, Zenodo. I will upload the files as soon as possible so my output becomes reproducible.