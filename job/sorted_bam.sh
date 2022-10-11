#! /bin/bash
#============ LSF Options ============
#QSUB -q gr10405c
#QSUB -ug gr10405
#QSUB -W 336:00
#QSUB -A p=1:t=15:c=15:m=300G

#============ Shell Script ============

cd /home/b/b34531/share/t.sakai/Pingtao/ATACseq/data/bam_files

array=($(ls))
for i in {0..37};do
  treat=${array[i]}
  samtools sort -@ 15 -o ${treat%.bam}_sorted.bam ${treat}
  samtools index -@ 15 ${treat%.bam}_sorted.bam
  samtools idxstats ${treat%.bam}_sorted.bam > ../idxstats_bam/${treat%.bam}_stats.txt
  mv ${treat%.bam}_sorted* ../sorted_bam_files/
done
