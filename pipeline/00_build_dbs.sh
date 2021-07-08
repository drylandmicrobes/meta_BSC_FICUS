#!/usr/bin/bash -l
#SBATCH -p short -N 1 -n 2 --mem 2gb --out make_sqlitedb.log

module load workspace/scratch

TOPBASE=data
DBOUT=db
mkdir -p $DBOUT
# this is an associative array in BASH
declare -A DBTypes
DBTypes[MG]=Sheephole_Crust_Metagenome
DBTypes[MT]=Sheephole_Crust_Metatranscriptome

for dtype in "${!DBTypes[@]}";
do
    folder="${DBTypes[$dtype]}"
    echo "$dtype -> $folder"

    # metaG
    BASE=$TOPBASE/$folder
    mkdir -p $BASE/load

    TEMP=$SCRATCH/$dtype.db
    DB=$DBOUT/SHP_${dtype}.sqlite3
    echo "Target db is $DB"
    if [ ! -f $DB ]; then
	echo ".read lib/schema.sql" | sqlite3 $TEMP
	
	for f in $(ls $BASE/annot/*.gene_phylogeny.tsv)
	do
	    m=$(basename $f .gene_phylogeny.tsv)
	    TARGET=$BASE/load/$m.gene_phylogeny.tsv
	    if [ ! -f $TARGET ]; then
		perl -p -e "my @row = split(\"\t\"); splice(@row,1,2); my \$last = pop @row; \$_ = join(\"\t\",$m,@row, split ';',\$last);" $f > $TARGET
	    fi
	    echo ".mode tab
begin;
.import $TARGET gene_phylo
commit;
" | sqlite3 $TEMP
	done 
	mv $TEMP $DB
    fi
done
