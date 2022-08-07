# Quality check
fastqc --nogroup -o ./FastQC_R1 ${array[i]}_R1.fastq.gz
fastqc --nogroup -o ./FastQC_R2 ${array[i]}_R2.fastq.gz
fastqc --nogroup -o ./FastQC_R1 ${array[i]}_R1.fastq.gz
fastqc --nogroup -o ./FastQC_R2 ${array[i]}_R2.fastq.gz

# Mapping
bowtie2 --threads {threads} -x {reference} --very-sensitive --end-to-end --maxins 20000 --no-discordant --no-mixed --fr --time --no-unal --qc-filter -1 {input.R1} -2 {input.R2} \
| samtools view -b --reference {reference} --threads {threads} \
| samtools sort -o {output} && samtools index {output}

# Test PCR duplication
picard MarkDuplicates I={input} O={output.bam} M={output.txt} REMOVE_SEQUENCING_DUPLICATES=false TAGGING_POLICY=OpticalOnly TAG_DUPLICATE_SET_MEMBERS=true
echo $metric $( grep -A1 LIBRARY  *_dupmetrixs.txt | tail -n 1 | awk -F "\t" '{print $9}' )