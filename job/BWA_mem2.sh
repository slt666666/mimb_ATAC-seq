#! /bin/bash
#============ LSF Options ============
#QSUB -q gr10405c
#QSUB -ug gr10405
#QSUB -W 336:00
#QSUB -A p=1:t=6:c=6:m=120G

#============ Shell Script ============

cd /home/b/b34531/share/t.sakai/Pingtao/ATACseq/data/combined_rawdata_pd

array=($(ls))
for i in {0..9};do
  treat=${array[i]}
  bwa-mem2 mem ../reference/TAIR10_chr_all.fas ${treat}/${treat}_R1.fastq.gz ${treat}/${treat}_R2.fastq.gz -t 6 \
    | samtools view  -u  - \
    | samtools sort -@ 6 -o ../bam_files/${treat}.bam -
done
