#! /bin/bash
#============ LSF Options ============
#QSUB -q gr10405c
#QSUB -ug gr10405
#QSUB -W 336:00
#QSUB -A p=1:t=6:c=6:m=120G

#============ Shell Script ============

cd /home/b/b34531/share/t.sakai/Pingtao/ATACseq/data/bam_files

array=($(ls))
for i in {0..8};do
  treat=${array[i]}
  macs3 callpeak -f BAMPE -t ${treat} -c gdna.bam -g 1.35e8 -n ${treat%.bam} --outdir ../macs3/${treat%.bam} -B -q 0.01
done
