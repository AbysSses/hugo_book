---
tags:
  - bioinformatics
  - R
  - tutorial
  - scRNA
dg-publish: true
---
## 得到cellchat对象后的可视化分析

### 需要的包
```r
library(CellChat)
library(zellkonverter)
library(reticulate)
library(SingleCellExperiment)
library(patchwork)
library(presto)
library(Matrix)
library(future)
library(NMF)
```

### 读取和合并数据
```r
Hot_cell = readRDS("/share/home/sunLab/yanghc/project/TNBC_scRNA/GSE246613/cellchat/Hot_2.rds")
nonHot_cell = readRDS("/share/home/sunLab/yanghc/project/TNBC_scRNA/GSE246613/cellchat/nonHot_2.rds")

# 1. 合并两个 CellChat 对象  
object.list <- list(Hot = Hot_cell, nonHot = nonHot_cell)  
cellchat <- mergeCellChat(object.list, add.names = names(object.list))  # 合并后自动在 cellchat@net 等 slot 中保存两个数据集的信息 :contentReference[oaicite:0]{index=0}

```

### 分组间的dotplot可视化

 这里注意，netVisual_bubble()函数中有两个参数，第一个是comparison = c(1, 2)它会决定数据集的先后位置，例如在上一步的合并中` list(Hot = Hot_cell, nonHot = nonHot_cell)`这样代表，Hot在1这个位置，nonHot在2这个位置。此时使用第二个参数`max.dataset = 1`，就会显示在Hot组中更强的信号，反之=2的话则显示在nonHot组中更强的信号也就是上调信息。

对于不同的对比画图需求，只需要改动第二个参数`max.dataset = 1`即可。如果同时改动则等于没有改动。总结如下：
- 当你写 `comparison = c(1, 2)` 时，第 1 个子数据集是 Hot，第 2 个是 nonHot；此时 `max.dataset = 2` 就会高亮 nonHot 组中更强的信号。
    
- 如果你改成 `comparison = c(2, 1)`，那在这一对比较里第 1 个就变成 nonHot，第 2 个变成 Hot；这时候再用 `max.dataset = 2`，就会高亮 **Hot** 组中更强的信号。
```r
gg1 <- netVisual_bubble(cellchat, 
                        sources.use = c("SFRP4_High_CAF", "SFRP4_Low_CAF"), 
                        targets.use = "cancer cells",  
                        comparison = c(1, 2), 
                        max.dataset = 2, title.name = "Increased signaling in nonHot", angle.x = 45, remove.isolate = T)
#> Comparing communications on a merged object
gg2 <- netVisual_bubble(cellchat, 
                        sources.use = c("SFRP4_High_CAF", "SFRP4_Low_CAF"), 
                        targets.use = "cancer cells",  
                        comparison = c(1, 2),
                        max.dataset = 1, 
                        title.name = "Decreased signaling in nonHot", angle.x = 45, remove.isolate = T)
#> Comparing communications on a merged object
p = gg1 + gg2
print(p)
#ggsave(filename = "Hot_nonHot/CAFwithTumor_in_de.pdf", 
 #      width = 10,height = 8, plot = p)


```
得到图如下：
![](https://i.imgur.com/vBnLT9m.png)

### 网络互作强度图

```r
netVisual_diffInteraction(cellchat, weight.scale = T, measure = "weight")
```
![](https://i.imgur.com/9zxRosZ.png)


## 写在最后
基本上，做两组之间的细胞通讯分析，有这两个图差不多了，当有了目标受体配体的时候可以进一步分析