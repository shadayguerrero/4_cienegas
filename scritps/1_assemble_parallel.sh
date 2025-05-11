#!/bin/bash
#conda activate megahit

THREADS=10
TRIMMED_READS="/home_local/camda/shaday/4_cienegas/trimmed-reads"
OUT_DIR="/home_local/camda/shaday/4_cienegas/assemblies"
mkdir -p "$OUT_DIR"

assemble_sample() {
  SAMPLE=$1
  R1="${TRIMMED_READS}/${SAMPLE}_1.trim.fastq"
  R2="${TRIMMED_READS}/${SAMPLE}_2.trim.fastq"
  OUT="${OUT_DIR}/${SAMPLE}_megahit"

  echo "Assembling $SAMPLE"
  megahit -1 "$R1" -2 "$R2" -o "$OUT" -t $THREADS
}

export -f assemble_sample
export TRIMMED_READS OUT_DIR THREADS

parallel -j 4 assemble_sample :::: samples.txt

#conda deactivate

