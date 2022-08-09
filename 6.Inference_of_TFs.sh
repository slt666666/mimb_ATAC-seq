# Ensemble Motif bed data is available at:
# http://bioinformatics.psb.ugent.be/cig_data/motifmappings_ath/

# Detail in https://doi.org/10.1104/pp.19.00605

# find how many TFBSs ($motiffile) overlap with HS sites ($regionBed) using Bedtools
realNumber = `bedtools intersect -a $motiffile -b $regionBed -u -f 0.5 | wc -l`

# for nShuffling times generate the shuffled TFBSs, check their overlap with HS sites and save the numbers in “shufflednumbers” file.

for i in `seq 1 $nShuffling`;do
    shuffledFile = ”shuffled_”$motifid”_”$i”.out”
    bedtools shuffle -i $motiffile -g $chromLength -noOverlapping -excl $motiffile -incl $promoterBed > $shuffledFile
    number = `bedtools intersect -a $shuffledFile -b $regionBed -u -f 0.5 | wc -l`
    echo -e “$i\t$number” > > $shufflednumbers
done

# calculate the p-value of enrichment
countBigger = 0
for eachNumber in`cat $shufflednumbers`;do
    if [ $eachNumber -ge realNumber];then
        countBigger = $($countBigger+1)
done
pvalue = $countBigger/$nShuffling