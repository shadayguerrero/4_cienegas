#!/bin/bash

# Activar el ambiente correcto
#source activate binning_env

THREADS=10
HOME_DIR="/home_local/camda/shaday/4_cienegas"

MAXBIN_DIR="${HOME_DIR}/binning/maxbin"
METABAT_DIR="${HOME_DIR}/binning/metabat"
ASSEMBLIES="${HOME_DIR}/assemblies"
DAS_DIR="${HOME_DIR}/bins_final"

mkdir -p "$DAS_DIR"

# Recorremos cada muestra (carpetas en maxbin/)
for SAMPLE in $(ls $MAXBIN_DIR); do
  echo "Procesando muestra: $SAMPLE"

  CONTIGS="${ASSEMBLIES}/${SAMPLE}_megahit/final.contigs.fa"

  ##### Generar los .scaffolds2bin.tsv #####
  echo "Generando .scaffolds2bin.tsv para $SAMPLE"

  Fasta_to_Contig2Bin.sh -i "${MAXBIN_DIR}/${SAMPLE}" -e fasta > "${DAS_DIR}/${SAMPLE}_maxbin.scaffolds2bin.tsv"
  Fasta_to_Contig2Bin.sh -i "${METABAT_DIR}/${SAMPLE}" -e fa > "${DAS_DIR}/${SAMPLE}_metabat.scaffolds2bin.tsv"

  ##### Ejecutar DAS_Tool #####
  echo "Corriendo DAS_Tool para $SAMPLE"

  DAS_Tool \
    -i "${DAS_DIR}/${SAMPLE}_maxbin.scaffolds2bin.tsv,${DAS_DIR}/${SAMPLE}_metabat.scaffolds2bin.tsv" \
    -l maxbin,metabat \
    -c "$CONTIGS" \
    -o "${DAS_DIR}/${SAMPLE}_bins" \
    --debug -t $THREADS --search_engine diamond --write_bins
done

#conda deactivate

