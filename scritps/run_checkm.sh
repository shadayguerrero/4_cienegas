#!/bin/bash

# Activar ambiente
#source activate eval_env

# Rutas
HOME_DIR="/home_local/camda/shaday/4_cienegas"
BINS_DIR="${HOME_DIR}/bins_final"
CHECKM_OUT="${HOME_DIR}/checkm_out"

mkdir -p "$CHECKM_OUT"

# Recorrer cada carpeta de muestra
for SAMPLE_DIR in ${BINS_DIR}/*_bins_DASTool_bins; do
    SAMPLE=$(basename "$SAMPLE_DIR" _bins_DASTool_bins)

    echo "Evaluando calidad para muestra: $SAMPLE"

    # Crear carpeta específica de salida para cada muestra
    mkdir -p "${CHECKM_OUT}/${SAMPLE}"

    checkm lineage_wf \
        -t 10 \
        -x fa \
        "$SAMPLE_DIR" \
        "${CHECKM_OUT}/${SAMPLE}"
done

#conda deactivate

