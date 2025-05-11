#!/bin/bash

BINNING_DIR="/home_local/camda/shaday/4_cienegas/binning"

# Crear carpetas principales
mkdir -p "${BINNING_DIR}/maxbin"
mkdir -p "${BINNING_DIR}/metabat"

# Ordenar los archivos
cd "$BINNING_DIR"

# Para archivos de MaxBin2
for FILE in *_maxbin2.*; do
  # Extraer el nombre de la muestra
  SAMPLE=$(echo "$FILE" | sed 's/_maxbin2\..*//')

  # Crear carpeta para la muestra si no existe
  mkdir -p "${BINNING_DIR}/maxbin/${SAMPLE}"

  # Mover el archivo a la carpeta de la muestra
  mv "$FILE" "${BINNING_DIR}/maxbin/${SAMPLE}/"
done

# Para archivos de MetaBAT2
for FILE in *_metabat2.*.fa; do
  # Extraer el nombre de la muestra
  SAMPLE=$(echo "$FILE" | sed 's/_metabat2\..*\.fa//')

  # Crear carpeta para la muestra si no existe
  mkdir -p "${BINNING_DIR}/metabat/${SAMPLE}"

  # Mover el archivo a la carpeta de la muestra
  mv "$FILE" "${BINNING_DIR}/metabat/${SAMPLE}/"
done

echo "✅ Organización completa: bins y archivos auxiliares de MaxBin2 y MetaBAT2."

