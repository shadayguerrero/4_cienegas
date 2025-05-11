#!/bin/bash

# Activar el ambiente
#source activate binning_env

# Configuración de rutas
THREADS=8
HOME_DIR="/home_local/camda/shaday/4_cienegas"

MAXBIN_DIR="${HOME_DIR}/binning/maxbin"
METABAT_DIR="${HOME_DIR}/binning/metabat"
ASSEMBLIES="${HOME_DIR}/assemblies"
DAS_DIR="${HOME_DIR}/bins_final"

mkdir -p "$DAS_DIR"

# Función para procesar una muestra
process_sample() {
  SAMPLE=$1

  echo "Procesando muestra: $SAMPLE"

  CONTIGS="${ASSEMBLIES}/${SAMPLE}_megahit/final.contigs.fa"

  ##### Generar .scaffolds2bin.tsv para MaxBin y MetaBAT #####
  Fasta_to_Contig2Bin.sh -i "${MAXBIN_DIR}/${SAMPLE}" -e fasta > "${DAS_DIR}/${SAMPLE}_maxbin.scaffolds2bin.tsv"
  Fasta_to_Contig2Bin.sh -i "${METABAT_DIR}/${SAMPLE}" -e fa > "${DAS_DIR}/${SAMPLE}_metabat.scaffolds2bin.tsv"

  ##### Correr DAS_Tool #####
  DAS_Tool \
    -i "${DAS_DIR}/${SAMPLE}_maxbin.scaffolds2bin.tsv,${DAS_DIR}/${SAMPLE}_metabat.scaffolds2bin.tsv" \
    -l maxbin,metabat \
    -c "$CONTIGS" \
    -o "${DAS_DIR}/${SAMPLE}_bins" \
    --debug -t $THREADS --search_engine diamond --write_bins
}

export -f process_sample
export MAXBIN_DIR METABAT_DIR ASSEMBLIES DAS_DIR THREADS

# Lista de muestras
SAMPLES=$(ls $MAXBIN_DIR)

# Ejecutar en paralelo
echo "$SAMPLES" | parallel -j 4 process_sample

# Desactivar el ambiente
#conda deactivate

