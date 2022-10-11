#! /bin/bash
#============ LSF Options ============
#QSUB -q gr10405c
#QSUB -ug gr10405
#QSUB -W 336:00
#QSUB -A p=1:t=2:c=2:m=40G

#============ Shell Script ============

cd /home/b/b34531/share/t.sakai/Pingtao/ATACseq/data/macs3

array=($(ls))
for i in {0..9};do
  treat=${array[i]}
  cd $treat
  macs3 bdgcmp -m FE \
    --o-prefix $treat \
    -t "${treat}_treat_pileup.bdg" \
    -c "${treat}_control_lambda.bdg"
  cd ..
done
