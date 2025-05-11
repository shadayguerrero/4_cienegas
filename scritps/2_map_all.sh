#!/bin/bash
#source activate mapping_env

TRIMMED_READS="/home_local/camda/shaday/4_cienegas/trimmed-reads"
ASSEMBLIES="/home_local/camda/shaday/4_cienegas/assemblies"
MAPPING_DIR="/home_local/camda/shaday/4_cienegas/mapping"
mkdir -p "$MAPPING_DIR"
THREADS=20

for R1 in ${TRIMMED_READS}/*_1.trim.fastq; do
    SAMPLE=$(basename "$R1" _1.trim.fastq)
    R2="${TRIMMED_READS}/${SAMPLE}_2.trim.fastq"
    CONTIGS="${ASSEMBLIES}/${SAMPLE}_megahit/final.contigs.fa"
    INDEX="${MAPPING_DIR}/${SAMPLE}_index"
    BAM="${MAPPING_DIR}/${SAMPLE}.bam"
    
    echo "Mapping $SAMPLE..."
    bowtie2-build "$CONTIGS" "$INDEX"
    bowtie2 -x "$INDEX" -1 "$R1" -2 "$R2" -p $THREADS | \
        samtools view -@ $THREADS -bS - | samtools sort -@ $THREADS -o "$BAM"
    samtools index "$BAM"
done

#jgi_summarize_bam_contig_depths --outputDepth "$MAPPING_DIR/depth.txt" $MAPPING_DIR/*.bam

#conda deactivate

