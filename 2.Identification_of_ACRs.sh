# Identify ACRs
macs3 callpeak -f BAMPE \
               -t treat_A.bam \
               -c gdna.bam \
               -g 1.35e8 \
               -n treat_A \
               --outdir ../macs3/treat_A \
               -B \
               -q 0.01

