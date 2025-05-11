#!/bin/bash
#micromamba activate binning_env

THREADS=9
ASSEMBLIES="/home_local/camda/shaday/4_cienegas/assemblies"
MAPPING_DIR="/home_local/camda/shaday/4_cienegas/mapping"
BINNING_DIR="/home_local/camda/shaday/4_cienegas/binning"
DAS_DIR="/home_local/camda/shaday/4_cienegas/bins_final"
mkdir -p "$BINNING_DIR" "$DAS_DIR"

bin_sample() {
  SAMPLE=$1
  CONTIGS="${ASSEMBLIES}/${SAMPLE}_megahit/final.contigs.fa"

  echo "Binning $SAMPLE"
  metabat2 -i "$CONTIGS" -a "$MAPPING_DIR/${SAMPLE}-depth.txt" -o "$BINNING_DIR/${SAMPLE}_metabat2" -t $THREADS

  run_MaxBin.pl -contig "$CONTIGS" -abund "$MAPPING_DIR/${SAMPLE}-depth.txt" \
    -out "$BINNING_DIR/${SAMPLE}_maxbin2" -thread $THREADS

  DASTool \
    -i "$BINNING_DIR/${SAMPLE}_metabat2.scaffolds2bin.tsv,$BINNING_DIR/${SAMPLE}_maxbin2.scaffolds2bin.tsv" \
    -l metabat2,maxbin2 \
    -c "$CONTIGS" \
    -o "$DAS_DIR/${SAMPLE}_dastool" \
    --search_engine diamond --write_bins 1 --threads $THREADS
}

export -f bin_sample
export ASSEMBLIES MAPPING_DIR BINNING_DIR DAS_DIR THREADS

parallel -j 4 bin_sample :::: samples.txt

#conda deactivate

