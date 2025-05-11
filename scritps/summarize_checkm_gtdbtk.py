import pandas as pd
import os
import glob

# Rutas base
HOME_DIR = "/home_local/camda/shaday/4_cienegas"
CHECKM_OUT = os.path.join(HOME_DIR, "checkm_out")
GTDBTK_OUT = os.path.join(HOME_DIR, "gtdbtk_out")
OUTPUT_FILE = os.path.join(HOME_DIR, "summary_MAGs.csv")

# Almacenar resultados por muestra
summary_rows = []

# Recorrer todas las carpetas de muestras en checkm_out
for sample_dir in glob.glob(os.path.join(CHECKM_OUT, "*")):
    sample = os.path.basename(sample_dir)
    lineage_file = os.path.join(sample_dir, "lineage.ms")
    gtdbtk_summary = os.path.join(GTDBTK_OUT, sample, "classification_summary.tsv")

    # Verificamos que ambos archivos existan
    if not os.path.isfile(lineage_file):
        print(f"❌ No se encontró lineage.ms para {sample}")
        continue
    if not os.path.isfile(gtdbtk_summary):
        print(f"❌ No se encontró classification_summary.tsv para {sample}")
        continue

    # Leer CheckM
    checkm_df = pd.read_csv(lineage_file, sep='\t', comment='#')
    checkm_df = checkm_df[['Bin Id', 'Completeness', 'Contamination']]

    # Leer GTDB-Tk
    gtdb_df = pd.read_csv(gtdbtk_summary, sep='\t')
    gtdb_df = gtdb_df[['user_genome', 'classification']]

    # Unir por bin/genome
    merged = pd.merge(checkm_df, gtdb_df, left_on='Bin Id', right_on='user_genome', how='left')
    merged['Sample'] = sample

    summary_rows.append(merged)

# Concatenar todas las muestras
final_df = pd.concat(summary_rows, ignore_index=True)

# Reordenar columnas
final_df = final_df[['Sample', 'Bin Id', 'Completeness', 'Contamination', 'classification']]

# Guardar resumen
final_df.to_csv(OUTPUT_FILE, index=False)

print(f"✅ Resumen final guardado en: {OUTPUT_FILE}")
