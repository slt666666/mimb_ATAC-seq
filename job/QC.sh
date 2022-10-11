#! /bin/bash
#============ LSF Options ============
#QSUB -q gr10405c
#QSUB -ug gr10405
#QSUB -W 336:00
#QSUB -A p=1:t=8:c=8:m=160G

#============ Shell Script ============

cd /home/b/b34531/share/t.sakai/Pingtao/ATACseq/data/combined_rawdata_pd

array=($(ls))

for i in {30..37};do
  
  cd ${array[i]}
  mkdir FastQC_R1; mkdir FastQC_R2
 
  # quality check
  fastqc --nogroup -o ./FastQC_R1 ${array[i]}_R1.fastq.gz
  fastqc --nogroup -o ./FastQC_R2 ${array[i]}_R2.fastq.gz

  # remove adapter
  NGmerge -a -1 ${array[i]}_R1.fastq.gz -2 ${array[i]}_R2.fastq.gz -o ${array[i]}_trimmed
  cd ..
done
