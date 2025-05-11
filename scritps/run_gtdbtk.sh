#!/bin/bash

# Activar ambiente
#source activate eval_env

# Rutas
HOME_DIR="/home_local/camda/shaday/4_cienegas"
BINS_DIR="${HOME_DIR}/bins_final"
GTDBTK_OUT="${HOME_DIR}/gtdbtk_out"

mkdir -p "$GTDBTK_OUT"

# Recorrer cada carpeta de muestra
for SAMPLE_DIR in ${BINS_DIR}/*_bins_DASTool_bins; do
    SAMPLE=$(basename "$SAMPLE_DIR" _bins_DASTool_bins)

    echo "Asignando taxonomía para muestra: $SAMPLE"

    mkdir -p "${GTDBTK_OUT}/${SAMPLE}"

    gtdbtk classify_wf \
        --genome_dir "$SAMPLE_DIR" \
        --out_dir "${GTDBTK_OUT}/${SAMPLE}" \
        --cpus 10 --extension fa
done

#conda deactivate

