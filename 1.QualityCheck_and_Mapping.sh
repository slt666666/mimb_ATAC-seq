# Quality check
fastqc --nogroup -o ./FastQC_R1 treat_A_R1.fastq.gz
fastqc --nogroup -o ./FastQC_R2 treat_A_R2.fastq.gz
fastqc --nogroup -o ./FastQC_R1 treat_B_R1.fastq.gz
fastqc --nogroup -o ./FastQC_R2 treat_B_R2.fastq.gz

# Mapping
bowtie2 --threads 8 -x TAIR10 --very-sensitive --end-to-end --maxins 20000 --no-discordant --no-mixed --fr --time --no-unal --qc-filter -1 treat_A_R1.fastq.gz -2 treat_A_R2.fastq.gz \
| samtools view -b --reference TAIR10 --threads 8 \
| samtools sort -o treat_A.bam && samtools index treat_A.bam

# Test PCR duplication
picard MarkDuplicates I=treat_A.bam O=treat_A_add_dup.bam M=treat_A__dupmetrixs.txt REMOVE_SEQUENCING_DUPLICATES=false TAGGING_POLICY=OpticalOnly TAG_DUPLICATE_SET_MEMBERS=true
echo $metric $( grep -A1 LIBRARY  *_dupmetrixs.txt | tail -n 1 | awk -F "\t" '{print $9}' )