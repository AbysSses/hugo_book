---
title: R-seurat
draft: false
weight:
tags:
  - bioinformatics
  - spatial
  - scRNA
  - tutorial
  - theory
date: 2025-04-19 14:23:17
LastMod: 2025-12-23 14:42:13
---
# R-seurat
## 1. Seurat对象的整体结构

Seurat对象主要包含以下几大组件：

- **Assays**：存储表达矩阵和相关的数据（如空间转录组数据，通常为"Spatial"）。
    
- **Meta data**：样本、细胞、或者空间spot级别的元数据。
    
- **Dimensional Reductions**：PCA、UMAP、tSNE等降维分析的结果。
    
- **Images**：空间转录组中特有的组件，存储组织图像信息和空间坐标。

## 2. 典型结构:10x Visium

```R
SeuratObject
├── assays
│   └── Spatial（默认）
│       ├── counts：原始计数矩阵
│       ├── data：标准化表达矩阵（log normalized）
│       └── scale.data：经过缩放的表达数据（比如scale之后）
├── meta.data
│   └── 空间spot相关信息（细胞类型、样本条件等）
├── reductions
│   ├── pca：主成分分析结果
│   └── umap/tSNE：降维可视化结果
└── images
    └── slice1（空间图像信息）
        ├── coordinates：空间坐标数据（x, y位置）
        ├── image：组织的原始切片图像
        ├── scale factors：图像与空间坐标之间的尺度因子
        └── spot radius：空间spots的半径


```

## 3. 访问Seurat对象内容的示例代码

```r
library(Seurat)

# 假设数据对象名为obj
# 查看Seurat对象结构
str(obj)

# 提取空间坐标
coords <- GetTissueCoordinates(obj)

# 提取表达矩阵
expr_matrix <- GetAssayData(obj, slot = "data", assay = "Spatial")

# 提取空间图片
image <- obj@images$slice1@image

```


# Python环境(scanpy/Squidpy)

## 1.AnnData对象的整体结构

```bash
AnnData对象
├── X：主表达矩阵（通常为基因表达）
├── obs：观测单元元数据（细胞或spot的元信息）
├── var：基因层面的信息
├── uns：非结构化数据（通常存储如图像、空间坐标元数据）
├── obsm：观测单元的多维信息（如PCA、空间坐标）
├── layers：可选项，存储多个版本的表达数据（如raw counts、normalized数据）
└── obsp/varp：可选，存储pairwise关系数据（如空间邻域图）

```

## 2. 空间转录组的典型结构
以10x Visium数据为例：

- 表达数据（counts或normalized）保存在`X`或`layers`中。
    
- 空间坐标一般放置在`obsm['spatial']`中。
    
- 组织图像以及尺度因子、空间信息常位于`uns`中，如`uns['spatial']`中。

```python
AnnData object
├── X (spots × genes)：表达矩阵
├── obs：spot级别的元数据（如细胞簇、样本组别）
├── var：基因的元信息
├── uns
│   └── spatial
│       └── sample1
│           ├── images：组织图片（高、低分辨率）
│           └── scalefactors：尺度信息（用于坐标与图片对应）
├── obsm
│   └── spatial：空间坐标 (spots × 2，x, y)
└── layers（可选）
    ├── counts：原始计数
    └── normalized：归一化后的表达数据

```

## 3. 访问示例代码

```python
import scanpy as sc
import squidpy as sq

# 加载数据
adata = sq.datasets.visium_hne_adata()

# 查看结构
print(adata)

# 获取表达矩阵
expr_matrix = adata.X  # 或 adata.layers['counts']

# 获取空间坐标
coords = adata.obsm['spatial']

# 获取组织图片
image = adata.uns['spatial']['V1_Human_Lymph_Node']['images']['hires']


```

# Seurat 对象和AnnData对象结构的差异总结

|特征|Seurat（R）|AnnData（Python）|
|---|---|---|
|数据存储|assays (counts/data/scale.data)|X或layers|
|元数据|meta.data|obs (spots) / var (genes)|
|空间坐标|images下的coordinates|obsm['spatial']|
|空间图像|images下的image|uns['spatial'][sample]['images']|
|尺度信息|images下的scale.factors|uns['spatial'][sample]['scalefactors']|
|降维信息|reductions|obsm|
# 两者数据结构互相转化

```R
library(SeuratDisk)

SaveH5Seurat(obj, filename = "data.h5Seurat")
Convert("data.h5Seurat", dest = "h5ad")

```



# Matrix Market Exchange Format （MEX） 格式对应关系

一般数据结构是：
```
├── matrix.mtx
├── features.tsv（或features.tsv.gz）
├── barcodes.tsv（或barcodes.tsv.gz）
└── spatial/
    ├── tissue_positions_list.csv（或tissue_positions.csv）
    ├── tissue_lowres_image.png
    ├── tissue_hires_image.png
    └── scalefactors_json.json

```

## R中
| 文件                                   | 对象中位置                                                         |
| ------------------------------------ | ------------------------------------------------------------- |
| matrix.mtx、features.tsv、barcodes.tsv | `obj@assays$Spatial@counts` 原始计数矩阵数据                          |
|                                      | `obj@assays$Spatial@data` 归一化数据                               |
| tissue_positions_list.csv            | `obj@images$slice1@coordinates` (空间坐标数据)                      |
| tissue_lowres_image.png              | `obj@images$slice1@image` (低分辨率图像，用于可视化)                      |
| tissue_hires_image.png               | 可选，高分辨率图片，一般不自动加载，可用自定义读取                                     |
| scalefactors_json.json               | `obj@images$slice1@scale.factors` (空间坐标的尺度因子，用于定位spot在图片中的位置) |
## Python

| 文件                                   | 对象中位置                                                         |
| ------------------------------------ | ------------------------------------------------------------- |
| matrix.mtx、features.tsv、barcodes.tsv | `adata.X` 或 `adata.layers['counts']` 原始表达数据                   |
|                                      | 基因名：`adata.var_names`                                         |
|                                      | Spot名：`adata.obs_names`                                       |
| tissue_positions_list.csv            | `adata.obsm['spatial']` (空间坐标数据)                              |
| tissue_lowres_image.png              | `adata.uns['spatial'][sample]['images']['lowres']` （低分辨率图）    |
| tissue_hires_image.png               | `adata.uns['spatial'][sample]['images']['hires']` （高分辨率图）     |
| scalefactors_json.json               | `adata.uns['spatial'][sample]['scalefactors']` （坐标与图片对应的尺度因子） |


## 对比

| 数据内容          | 文件位置（原始数据）                               | Seurat对象                      | AnnData对象                                    |
| ------------- | ---------------------------------------- | ----------------------------- | -------------------------------------------- |
| 表达矩阵（基因表达数据）  | matrix.mtx + features.tsv + barcodes.tsv | `assays$Spatial@counts/data`  | `X` 或 `layers['counts']`                     |
| 基因名称          | features.tsv                             | rownames(counts矩阵)            | `adata.var_names`                            |
| Spot名称        | barcodes.tsv                             | colnames(counts矩阵)            | `adata.obs_names`                            |
| 空间坐标 (x, y)   | tissue_positions_list.csv                | `images$slice1@coordinates`   | `obsm['spatial']`                            |
| 空间组织图像 (低分辨率) | tissue_lowres_image.png                  | `images$slice1@image`         | `uns['spatial'][sample]['images']['lowres']` |
| 空间组织图像 (高分辨率) | tissue_hires_image.png                   | 一般不默认加载，需要额外读取                | `uns['spatial'][sample]['images']['hires']`  |
| 尺度因子（坐标映射到图片） | scalefactors_json.json                   | `images$slice1@scale.factors` | `uns['spatial'][sample]['scalefactors']`     |