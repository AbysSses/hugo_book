---
title: 下载原始数据
date: 2025-05-01 15:28:21
draft: false
dg-publish: true
tags:
  - tutorial
  - linux
  - shell
LastMod: 2025-12-23 13:26:39
---
#rnaseq #linux 

# 下载原始数据
## sra-tools 
`sra-tools` 包含了 `fastq-dump` 工具，可以用来从 SRA（Sequence Read Archive）数据库中下载测序数据并将其转换为 FASTQ 格式。使用 `fastq-dump` 工具，并指定以下参数：
```sh
fastq -dump --split 3 SRA2176358
```

- `-dump`: 表示执行下载和转换操作。
- `--split 3`: 表示将双端测序数据分割成两个文件，每个文件包含原始测序数据的一半。这个参数的值为 `3`，表示每个原始测序数据的一半被分割成一个独立的文件。
- `SRA2176358`: 是你要下载和转换的 SRA 数据库中的样本标识号。

因此，这个命令的作用是下载 SRA 数据库中的样本 `SRA2176358` 的测序数据，并将其转换为两个 FASTQ 文件，每个文件包含一半的原始测序数据。

## ascp
下载aspera软件 conda可以下载 也可以去官网下载压缩包手动安装

然后找SRA号去这个网站生成下载脚本(https://sra-explorer.info/)
生成的脚本长这样
```sh
ascp  -vQT -l 500m -P33001 -k 1 -i \
~/.aspera/connect/etc/asperaweb_id_dsa.openssh \
era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/SRR122/079/SRR12207279/SRR12207279_1.fastq.gz  ./
```

> ######### 主要使用参数  
> **-v** 详细模式  
> **-Q** 用于自适应流量控制，磁盘限制所需  
> **-T** 设置为无需加密传输  
> **-l** 最大下载速度，一般设为500m  
> **-P** TCP 端口，一般为33001  
> **-k** 断点续传，通常设为 1  
> **-i** 免密下载的密钥文件

密匙文件在aspera目录的etc文件下通常使用.openshh结尾那个，将自己的路径替换到上面命令中
# 质控
## fastqc
```text
# 基本格式

# fastqc [-o output dir] [--(no)extract] [-f fastq|bam|sam] [-c contaminant file] seqfile1 .. seqfileN

# 主要是包括前面的各种选项和最后面的可以加入N个文件
# -o --outdir FastQC生成的报告文件的储存路径，生成的报告的文件名是根据输入来定的
# --extract 生成的报告默认会打包成1个压缩文件，使用这个参数是让程序不打包
# -t --threads 选择程序运行的线程数，每个线程会占用250MB内存，越多越快咯
# -c --contaminants 污染物选项，输入的是一个文件，格式是Name [Tab] Sequence，里面是可能的污染序列，如果有这个选项，FastQC会在计算时候评估污染的情况，并在统计的时候进行分析，一般用不到
# -a --adapters 也是输入一个文件，文件的格式Name [Tab] Sequence，储存的是测序的adpater序列信息，如果不输入，目前版本的FastQC就按照通用引物来评估序列时候有adapter的残留
# -q --quiet 安静运行模式，一般不选这个选项的时候，程序会实时报告运行的状况。
```
写成脚本：

```sh
#!/bin/bash

# 检查上级目录是否存在 FASTQ 文件夹

if [ -d "../FASTQ" ]; then

else

mkdir -p ../FASTQ

fi

# 激活 rnaseq 环境
conda init
conda activate rnaseq
# 进入目标目录
cd /home/sunlab/workspace/test/mhw/raw_data
# 运行 fastqc 命令
fastqc -q -t 32 -o ../FASTQ/ *.fq.gz
```

集群
```sh
#!/bin/bash
#PBS -N QC
#PBS -l nodes=1:ppn=32
#PBS -o /share/home/sunLab/yanghc/workplace/test/PRJNA860635output.txt
#PBS -e /share/home/sunLab/yanghc/workplace/test/PRJNA860635err.txt
#PBS -j o
#PBS -q cpu_192
#PBS -l walltime=500:00:00
  
# 检查上级目录是否存在 FASTQ 文件夹

if [ -d "../FASTQ" ]; then
else
mkdir -p ../FASTQ
fi

# 激活 rnaseq 环境
conda init
conda activate rnaseq
# 进入目标目录
cd /share/home/sunLab/yanghc/workplace/test/PRJNA860635/
fastqc -o ../FASTQC *.fastq.gz
```




# 去开头结尾
## fastx_trimer
zcat $fastq_1 | fastx_trimer -f 11 -l 140 -z -o $out_fastq_1 &