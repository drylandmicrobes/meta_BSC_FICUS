CREATE TABLE gene_phylo (
	source_sample VARCHAR(32) NOT NULL,
        gene_id VARCHAR(32) PRIMARY KEY NOT NULL,
	percent_id varchar(8) NULL,
	tax_kingdom VARCHAR(32) NOT NULL,
	tax_phylum VARCHAR(32) NOT NULL,
	tax_class VARCHAR(32) NOT NULL,
	tax_order VARCHAR(64) NOT NULL,
	tax_family VARCHAR(64) NOT NULL,
	tax_genus VARCHAR(64) NOT NULL,
	tax_species VARCHAR(128) NOT NULL,
	tax_strain VARCHAR(128) NOT NULL
);
/* CREATE UNIQUE INDEX ix_gene_id ON gene_phylo (gene_id); */
CREATE INDEX ix_source ON gene_phylo (source_sample);
CREATE INDEX ix_kingdom ON gene_phylo (tax_kingdom);
CREATE INDEX ix_phylum ON gene_phylo (tax_phylum);
CREATE INDEX ix_class ON gene_phylo (tax_class);
CREATE INDEX ix_tax ON gene_phylo (tax_phylum,tax_class,tax_order,tax_family,tax_genus);
CREATE INDEX ix_genus ON gene_phylo (tax_genus);
CREATE INDEX ix_pid ON gene_phylo (percent_id);
