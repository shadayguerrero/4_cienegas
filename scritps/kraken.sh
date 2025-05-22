#!/bin/bash
KRAKEN_DB="/home_local/compartida/camda2024/k2_pluspfp_20250402/"
READS_DIR="/home_local/camda/shaday/4_cienegas/host_removed"
OUT_DIR="/home_local/camda/shaday/4_cienegas/kraken2_results"
# Ruta a la base de datos Kraken2



mkdir -p "$OUT_DIR"

# Número de núcleos por muestra
THREADS=24

# Leer archivo de muestras
while read SAMPLE; do
    R1="${READS_DIR}/${SAMPLE}/${SAMPLE}_R1.fastq.gz"
    R2="${READS_DIR}/${SAMPLE}/${SAMPLE}_R2.fastq.gz"
    OUTPUT="${OUT_DIR}/${SAMPLE}.kraken"
    REPORT="${OUT_DIR}/${SAMPLE}.report"

    echo "Procesando muestra: $SAMPLE"
    kraken2 \
        --db "$KRAKEN_DB" \
        --paired "$R1" "$R2" \
        --threads "$THREADS" \
        --report "$REPORT" \
        --gzip-compressed\
        --output "$OUTPUT"

    echo "Finalizó muestra: $SAMPLE"
done < samples.txt

