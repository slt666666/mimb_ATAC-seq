# Identify DARs
macs3 callpeak -f BAMPE \
               -t ${treat} \
               -c gdna.bam \
               -g 1.35e8 \
               -n ${treat%.bam} \
               --outdir ../macs3/${treat%.bam} \
               -B \
               -q 0.01

