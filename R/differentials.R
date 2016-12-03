args <- commandArgs(trailingOnly = TRUE)
R1<-read.table(args[1])
regions<-nrow(R1)
total<-sum(R1$V2)
if (total == regions) {
write.table(2, args[2], sep= "\t")
} else if (total == "0") {
write.table(0, args[2], sep= "\t")
} else {
write.table(1, args[2], sep= "\t") }

