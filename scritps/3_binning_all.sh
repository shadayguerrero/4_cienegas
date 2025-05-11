#!/bin/bash
source activate binning_env

ASSEMBLIES="/data/shaday_data/project/assemblies"
MAPPING_DIR="/data/shaday_data/project/mapping"
BINNING_DIR="/data/shaday_data/project/binning"
DAS_DIR="/data/shaday_data/project/bins_final"
mkdir -p "$BINNING_DIR" "$DAS_DIR"
THREADS=8

for ASSEMBLY in ${ASSEMBLIES}/*/final.contigs.fa; do
    SAMPLE=$(basename $(dirname "$ASSEMBLY") _megahit)

    echo "Binning $SAMPLE..."

    metabat2 -i "$ASSEMBLY" -a "$MAPPING_DIR/depth.txt" \
             -o "$BINNING_DIR/${SAMPLE}_metabat2" -t $THREADS

    run_MaxBin.pl -contig "$ASSEMBLY" -abund "$MAPPING_DIR/depth.txt" \
                  -out "$BINNING_DIR/${SAMPLE}_maxbin2" -thread $THREADS

    DASTool \
      -i "$BINNING_DIR/${SAMPLE}_metabat2.scaffolds2bin.tsv,$BINNING_DIR/${SAMPLE}_maxbin2.scaffolds2bin.tsv" \
      -l metabat2,maxbin2 \
      -c "$ASSEMBLY" \
      -o "$DAS_DIR/${SAMPLE}_dastool" \
      --search_engine diamond --write_bins 1 \
      --threads $THREADS
done

conda deactivate

