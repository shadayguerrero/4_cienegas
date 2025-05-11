#!/bin/bash
source activate eval_env

DAS_DIR="/data/shaday_data/project/bins_final"
CHECKM_DIR="/data/shaday_data/project/checkm"
GTDBTK_DIR="/data/shaday_data/project/gtdbtk"
mkdir -p "$CHECKM_DIR" "$GTDBTK_DIR"
THREADS=8

for BIN_DIR in ${DAS_DIR}/*_dastool_DASTool_bins; do
    SAMPLE=$(basename "$BIN_DIR" _dastool_DASTool_bins)
    echo "Evaluating $SAMPLE..."

    checkm lineage_wf "$BIN_DIR" "$CHECKM_DIR/${SAMPLE}" -x fa -t $THREADS

    gtdbtk classify_wf \
      --genome_dir "$BIN_DIR" \
      --out_dir "$GTDBTK_DIR/${SAMPLE}" \
      --cpus $THREADS
done

conda deactivate

