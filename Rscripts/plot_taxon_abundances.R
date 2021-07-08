library(DBI)
library(ggplot2)
library(dbplyr)
library(dplyr)
con <- dbConnect(RSQLite::SQLite(), "db/SHP_MT.sqlite3")

genephylo <- tbl(con, "gene_phylo")

# group by source_sample and tax_phylum
p <- ggplot(genephylo)

con <- dbConnect(RSQLite::SQLite(), "db/SHP_MG.sqlite3")

genephylo <- tbl(con, "gene_phylo")

# group by source_sample and tax_phylum
p <- ggplot(genephylo)