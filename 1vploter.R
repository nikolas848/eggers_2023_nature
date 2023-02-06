rm(list = ls())
try(setwd(dirname(rstudioapi::getActiveDocumentContext()$path)))

#BiocManager::install("VplotR")

library(VplotR)
library(rtracklayer)

mypath="../raw_fastq"
myfiles <- list.files(pattern = "merged.*.bed$",path=mypath,recursive = T,full.names = T)
myfiles <- myfiles[grepl("peaks",myfiles)==F]
myfiles <- myfiles[grepl("l04",myfiles)==F]
myfiles <- myfiles[grepl("sub",myfiles)==F]
myfiles <- myfiles[file.size(myfiles)>10000000]
myfiles <- myfiles[c(6)]
mynames <- list.files(pattern = "merged.*.bed$",path=mypath,recursive = T)
mynames <- mynames[grepl("peaks",mynames)==F]
mynames <- mynames[grepl("l04",mynames)==F]
mynames <- mynames[grepl("sub",mynames)==F]
#mynames <- mynames[file.size(paste0("./",mynames))>10000000]
mynames <- gsub("/","",mynames)
mynames <- mynames[c(6)]
sites <- list.files(path = "../centersmotif",pattern="*.bed$",full.names = T)[c(3)]###
f=1
#site <- import.bed(sites[6])

# parallel::mclapply(seq_along(myfiles), mc.cores = 6, FUN = function(f){
# #for(f in myfiles){
# pdf(paste0(mynames[f],"motif.pdf"),width=4,height=4)
# fragments<-import.bed(myfiles[f])
# site <- import.bed(sites[f])
# #df <- getFragmentsDistribution(fragments,site)
# #print(ggplot(df, aes(x = x, y = y)) + geom_line() + theme_ggplot2())
# print(plotVmat(x = fragments, granges = site,ylims=c(60,300),xlims=c(-201,201)))
# dev.off()
# })


list_params <- list(
  "control"=list(
    import.bed(myfiles[1]),
    import.bed(sites[1])
  )
)
  
#   "MSL2" = list(
#     import.bed("../msl2data/merged.msl2_chip_cm.bed"), 
#     import.bed("../msl2data/pwminMSL2bound+C.bed")
#   ),
#   "CLOCK" = list(
#     import.bed(myfiles[1]), 
#     import.bed(sites[1])
#   ), 
#   "MYCMAX" = list(
#     import.bed(myfiles[4]), 
#     import.bed(sites[4])
#   ),
#   "MYCMAX mut" = list(
#     import.bed(myfiles[2]), 
#     import.bed(sites[2])
#   ),
#   "MYCMAX oct4" = list(
#     import.bed(myfiles[3]), 
#     import.bed(sites[3])
#   )
# )

p <- plotVmat(
  list_params, 
  cores = 1,
  nrow = 1, ncol = 5,
  ylims=c(60,300),
  xlims=c(-201,201),
  normFun = "zscore"
)
#p
ggsave("controlmycpwmfimo.pdf",p,height=8)


