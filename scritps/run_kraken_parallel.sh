#!/bin/bash

# Ruta a la base de datos Kraken2
KRAKEN_DB="/home_local/compartida/camda2024/k2_pluspfp_20250402/"

# Ruta a los reads pareados
READS_DIR="/home_local/camda/shaday/4_cienegas/trimmed-reads"

# Directorio de salida
OUT_DIR="/home_local/camda/shaday/4_cienegas/kraken2_results"
mkdir -p "$OUT_DIR"

# Número de núcleos por proceso Kraken
THREADS_PER_JOB=8

# Número de procesos Kraken en paralelo
PARALLEL_JOBS=4

# Función para procesar una muestra
process_sample() {
    SAMPLE=$1
    R1="${READS_DIR}/${SAMPLE}_1.trim.fastq"
    R2="${READS_DIR}/${SAMPLE}_2.trim.fastq"
    OUTPUT="${OUT_DIR}/${SAMPLE}.kraken"
    REPORT="${OUT_DIR}/${SAMPLE}_report.txt"

    echo "Procesando muestra: $SAMPLE"
    kraken2 \
        --db "$KRAKEN_DB" \
        --paired "$R1" "$R2" \
        --threads $THREADS_PER_JOB \
        --report "$REPORT" \
        --output "$OUTPUT"
}

export -f process_sample
export READS_DIR KRAKEN_DB OUT_DIR THREADS_PER_JOB

# Generar lista de muestras
#ls ${READS_DIR}/*_1.trim.fastq | sed 's/.*\/\(.*\)_1.trim.fastq/\1/' > sample_list.txt

# Ejecutar en paralelo
cat samples.txt | parallel -j $PARALLEL_JOBS process_sample

