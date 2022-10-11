#! /bin/bash
#============ LSF Options ============
#QSUB -q gr10405c
#QSUB -ug gr10405
#QSUB -W 336:00
#QSUB -A p=1:t=8:c=8:m=160G

#============ Shell Script ============

cd /home/b/b34531/share/t.sakai/Pingtao/ATACseq/data/reference

bwa-mem2 index TAIR10_chr_all.fas 

