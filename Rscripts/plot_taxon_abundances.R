library(DBI)
library(ggplot2)
library(dbplyr)
library(dplyr)
con <- dbConnect(RSQLite::SQLite(), "db/SHP_MT.sqlite3")

MTgenephylo <- tbl(con, "gene_phylo")
phylaMT <- MTgenephylo %>% 
  group_by(source_sample,tax_phylum) %>%
  summarise(
    countTaxa = n()
  ) %>%  arrange(desc(countTaxa)) %>% filter(countTaxa > 100)


phylaMTall <- phylaMT %>% collect()

# group by source_sample and tax_phylum
p <- ggplot(phylaMTall,aes(x=source_sample,y=countTaxa,fill=source_sample)) + geom_bar(stat="identity") + facet_wrap(~tax_phylum) +
  theme(axis.text.x=element_blank()) + scale_fill_brewer()  + scale_y_log10()

p
ggsave("plots/MT_phyla.pdf",p,width=20)


# MG
con <- dbConnect(RSQLite::SQLite(), "db/SHP_MG.sqlite3")

MGgenephylo <- tbl(con, "gene_phylo")
phylaMG <- MGgenephylo %>% 
  group_by(source_sample,tax_phylum) %>%
  summarise(
    countTaxa = n()
  ) %>%  arrange(desc(countTaxa)) %>% filter(countTaxa > 100)


phylaMGall <- phylaMG %>% collect()

# group by source_sample and tax_phylum
p <- ggplot(phylaMGall,aes(x=source_sample,y=countTaxa,fill=source_sample)) + geom_bar(stat="identity") + facet_wrap(~tax_phylum) +
  theme(axis.text.x=element_blank()) + scale_fill_brewer()  + scale_y_log10()

p
ggsave("plots/MG_phyla.pdf",p,width=20)
