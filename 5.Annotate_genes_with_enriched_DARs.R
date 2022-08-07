library(ChIPpeakAnno)
library(TxDb.Athaliana.BioMart.plantsmart28)

# load input file
input_bed <- "treatA_vs_treatB_peaks.narrowPeak.bed"
peaks <- toGRanges(input_bed, format="BED", header=FALSE)

# load gene features, fix seqlevels
txdb <- TxDb.Athaliana.BioMart.plantsmart28
annoData <- toGRanges(txdb)
seqlevelsStyle(peaks) <- seqlevelsStyle(annoData)

# annotate peaks
anno <- annotatePeakInBatch(
                        peaks,
                        AnnotationData=annoData, 
                        output="overlapping", 
                        FeatureLocForDistance="TSS",
                        bindingRegion=c(-2000, 1000)
                        )
write.table(anno, "treatA_vs_treatB_peaks_annotation.txt", quote=FALSE)