#!/bin/bash

# Directorio donde están los ensambles en formato .fa
ASSEMBLY_DIR="/home_local/compartida/camda2024/gut/assembly"

# Directorio donde se guardarán los resultados de Prokka
OUTPUT_DIR="/home_local/compartida/camda2024/gut/prokka"
mkdir -p "$OUTPUT_DIR"

# Función para anotar un genoma con Prokka
run_prokka() {
    genome=$1
    base_name=$(basename $genome .fa)
    output_path="/home_local/compartida/camda2024/gut/prokka"/${base_name}
    mkdir -p $output_path 
    echo "Anotando $base_name con Prokka..."
    prokka --prefix ${base_name} --kingdom Bacteria --cpus 4 --force --outdir ${output_path} --metagenome ${genome} 
    echo "Anotación completada para $genome"
}

export -f run_prokka

# Uso de GNU Parallel para ejecutar Prokka en paralelo
find "$ASSEMBLY_DIR" -name "*.fa" | parallel -j 10 run_prokka

echo "Prokka ha finalizado la anotación para todos los genomas."

