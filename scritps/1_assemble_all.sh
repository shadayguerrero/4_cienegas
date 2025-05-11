#!/bin/bash
source activate assembly_env

TRIMMED_READS="/data/metagenomics_data/CCC/MetaPipe/results_pipev2/trimmed-reads"
OUT_DIR="/data/shaday_data/project/assemblies"
mkdir -p $OUT_DIR
THREADS=16

for R1 in ${TRIMMED_READS}/*_1.trim.fastq; do
    SAMPLE=$(basename "$R1" _1.trim.fastq)
    R2="${TRIMMED_READS}/${SAMPLE}_2.trim.fastq"
    SAMPLE_OUT="${OUT_DIR}/${SAMPLE}_megahit"

    echo "Assembling $SAMPLE..."
    megahit -1 "$R1" -2 "$R2" -t $THREADS -o "$SAMPLE_OUT"
done

conda deactivate

