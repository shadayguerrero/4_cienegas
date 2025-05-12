# Análisis Metagenómico - Cuatro Ciénegas

Este repositorio contiene los archivos y resultados del análisis metagenómico de muestras obtenidas en la región de Cuatro Ciénegas. Se incluyen pasos de ensamblado, binning, clasificación taxonómica y anotación funcional.

## 📁 Estructura del repositorio

| Carpeta/Archivo        | Descripción |
|------------------------|-------------|
| `assemblies/`          | Ensambles de las muestras (no incluido en el repositorio por tamaño). |
| `binning/`             | Archivos intermedios para la construcción de MAGs. |
| `binning_res/`         | Resultados del binning con distintas herramientas. |
| `bins_final/`          | MAGs finales seleccionados tras DAS Tool. |
| `checkm_out/`          | Resultados de calidad de MAGs con CheckM. |
| `envs/`                | Archivos de entorno con dependencias bioinformáticas. |
| `gtdbtk_out/`          | Clasificación taxonómica con GTDB-Tk. |
| `kraken2_results/`     | Resultados taxonómicos a partir de los reads con Kraken2. |
| `krona/`               | Visualizaciones interactivas con Krona. |
| `mapping/`             | Archivos de mapeo de reads a contigs. |
| `trimmed-reads/`       | Lecturas preprocesadas (reads limpios) por muestra. |
| `scritps/`             | Scripts utilizados en el análisis (bash, Python, etc.). |
| `samples.txt`          | Lista de muestras procesadas. |

## 🚀 Reproducibilidad

Puedes reproducir parte del análisis utilizando los scripts disponibles en la carpeta `scritps/`. Se recomienda crear los entornos necesarios con `conda` o `micromamba`, usando los archivos disponibles en `envs/`.

## 📦 Requisitos

- Conda / Micromamba
- Snakemake (opcional para automatización)
- Kraken2, CheckM, GTDB-Tk, Prokka, entre otros (dependiendo del análisis a reproducir)




