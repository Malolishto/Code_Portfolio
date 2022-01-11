##Set-up
setwd("E:/College/UT Fall 2020/Basics of Computational Biology/Ancilliary Files")
source("bio321g_rnaseq_utils.R")
install.packages("BiocManager")
library(BiocManager)
BiocManager::install("BiocParallel")
a
BiocManager::install("DESeq2")
a
library(BiocParallel)
register(SnowParam(2))
library(DESeq2)
install.packages("ggplot2")
library(ggplot2)
library(tidyr)
##1.) 
DESeqDataSet = DESeqDataSetFromMatrix(
    design = ~time + genotype + time:genotype,
    countData = rnaCounts,
      colData = sampleAnnotation)
res=DESeq(DESeqDataSet, test = "LRT", reduced = ~time + genotype, parallel=TRUE)
nomer = results(res)
results = subset(nomer, padj <=.1)
nrow(results) * .1

##2.) 

lgNorm = log2(counts(res) + 1)

##3.) 
pca = prcomp(t(lgNorm))
pcaData = data.frame(pca$x[,1:2])
pcaData$group = sampleAnnotation[rownames(pcaData),"group"]
pcaData$sample = rownames(pcaData)
library(ggplot2)
theme_set(theme_bw())
gg = ggplot(pcaData, aes(x=PC1, y=PC2, color = group, label = sample))
gg = gg + geom_point(size=2.5, alpha = 0.75)
gg = gg + scale_color_manual(values = groupColors)
print(gg)
##4.) 
geneSets = read.table("gene_sets.tsv.gz",sep = "\t")
colnames(geneSets) = geneSets[1,]
geneSets[1,]
genes = geneSets[which(geneSets[,1] == "GO:0071495"),]
GO = data.frame(genes[,2:4])
colnames =(c("gene description", "gene name/symbol", "gene id"))
colnames(GO) = colnames 
write.table(GO, file = "Risch_go.tsv", row.names = FALSE, col.names = colnames, sep = "\t")

##5.) 
lgGo = data.frame(lgNorm[which(rownames(lgNorm)%in%GO[,3]),])

##6.)
pcaLgGo = prcomp(t(lgGo))
names(pcaLgGo)
is.list(pcaLgGo)
head(pcaLgGo$x[,1,drop=FALSE])
pcaLgGoData = data.frame(pcaLgGo$x[,1:2])
pcaLgGoData$group = sampleAnnotation[rownames(pcaData), "group"]
pcaLgGoData$sample = rownames(pcaLgGoData)
gg = ggplot(pcaLgGoData, aes(x = PC1, y = PC2, color = group, label = sample))
gg = gg + geom_point(size=2.5, alpha=0.75)
gg = gg + scale_color_manual(values = groupColors)
print(gg)
##7.) 
install.packages("pheatmap")
a
library(pheatmap)
heatData = lgGo - rowMeans(lgGo)
heatData[heatData > 2 ] = 2
heatData[heatData < -2] = -2
pheatmap(
  heatData, 
  color = heatPalette,
  clustering_method = "average",
  labels_row=geneNamesAndDescriptions[rownames(heatData), "symbol"],
  show_rownames = FALSE
)
##8.)  
p = nomer[order(nomer$pvalue),]
p =data.frame(p)
p =p[(which(rownames(p) %in% rownames(lgGo))),]
head(p, n=9)
colnames(p)
q = lgGo[which(rownames(lgGo) %in% rownames(head(p, n= 9))),]
colnames(q) = c("14BENDDAY2","14BENDDAY4","14BEXDARK2",
                "14BEXDARK3","14BEXDARK4","4GENDDAY2",
                "4GENDDAY3","4GENDDAY4","4GEXDARK2",
                "4GEXDARK3","COLENDDAY3","COLENDDAY5" 
                ,"COLEXDARK2","COLEXDARK3","COLEXDARK4")
colnames(q)[11:15]
stripchart321g(q,sampleAnnotation) %>% print()
