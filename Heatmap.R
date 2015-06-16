if (!require("gplots"))
{
  install.packages("gplots", dependencies = TRUE)
  library (gplots)
}
if (!require ("RColorBrewer")){
  install.packages("RColorBrewer", dependencies = TRUE)
  library (RColorBrewer)
}
data <- read.table("~/Anju-LCM/COVERAGE/DESEQ-results/FDR-5/BS-NS-FDR5.txt",header=FALSE)
WP_DE<- read.csv("~/WPN-Norm-DE.csv")
dim(WP_DE)
head(WP_DE)
WP_DE_LN_SUB <- WP_DE_Ln[1:30,]
data <- data[,c(1,3:4)]

rnames <-data[,1]
head(rnames)

mat_data <- data.matrix(data[,2:3])
mat_data <- log (mat_data+1)
head(mat_data)
rownames(mat_data) <- rnames
my_palette <- colorRampPalette(c("red", "black", "green"))(n = 299)
#col_breaks = c(seq(-100,0, length=100),seq(0,100,length=100),seq(100,1,length=100))
#row_distance = dist(mat_data, method = "manhattan")
#row_cluster = hclust(row_distance, method = "ward")
#col_distance = dist(t(mat_data), method = "manhattan")
#col_cluster = hclust(col_distance, method = "ward")
#nrow=800
#ncol=4
#set.seed(12345)
#row.names=replicate(nrow,paste(letters[]))
#, width = 5*300, height = 5*300, res = 300, pointsize=8)
png(file="BS-NS-DE.png",width = 5*300, height = 5*300, res = 300, pointsize=8)
heatmap.2(mat_data,density.info = "none", trace="none", margins = c(12,9),col=my_palette,dendrogram = "row", Colv="NA")
dev.off()
