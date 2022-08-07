# Identify DARs
macs3 callpeak -f BAMPE \
               -t treat_A.bam \
               -c treat_B.bam \
               -g 1.35e8 \
               -n treatA_vs_treatB_peaks \
               --outdir ../macs3/treatA_vs_treatB \
               -B \
               -q 0.01

