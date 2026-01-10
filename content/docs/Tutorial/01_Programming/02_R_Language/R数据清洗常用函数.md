---
date: 2026-01-05 17:44:20
draft: false
tags: []
title: R数据清洗常用函数
weight: 1
bookToc: true
bookHidden: false
bookCollapseSection: true
bookComments: false
bookSearchExclude: false
LastMod: 2026-01-05 18:23:48
---
下面是 **R 语言常用数据处理函数速查表**（按“基础 R / tidyverse / dplyr”为主来整理）。

---

## 1) 基础 R（Base R）数据处理常用函数

### 1.1 查看 / 基本信息

- `str(x)`：结构（列类型、层级等）
    
- `summary(x)`：快速统计摘要
    
- `head(x, n)`, `tail(x, n)`：查看前/后 n 行
    
- `dim(x)`, `nrow(x)`, `ncol(x)`：维度
    
- `names(x)`, `colnames(x)`, `rownames(x)`：名称
    
- `class(x)`, `typeof(x)`：类型
    
- `unique(x)`, `duplicated(x)`：去重/重复检测
    
- `table(x)`：频数表
    

### 1.2 选取 / 子集

- `x[i, j]`：矩阵/数据框按行列取子集
    
- `subset(df, 条件, select=列)`：按条件和列筛选（简便但不推荐写包时用）
    
- `with(df, expr)`：在数据框环境里写表达式
    
- `within(df, expr)`：在数据框里修改/新增列
    

### 1.3 排序 / 合并 / 连接

- `order(x)`：返回排序索引（常配合 `df[order(df$col), ]`）
    
- `sort(x)`：排序后的向量
    
- `merge(x, y, by=..., all.x=..., all.y=...)`：连接（类似 join）
    
- `cbind(...)`, `rbind(...)`：按列/行拼接（列名、行数要对齐）
    

### 1.4 缺失值处理

- `is.na(x)`：缺失判断
    
- `na.omit(df)`：删除含 NA 的行（注意会丢数据）
    
- `complete.cases(df)`：完整行逻辑索引
    
- `ifelse(cond, a, b)`：向量化条件赋值（NA 处理要小心）
    
- `replace(x, idx, values)`：替换
    

### 1.5 字符串 / 正则（base）

- `paste(...)`, `paste0(...)`：拼接
    
- `sprintf(...)`：格式化字符串
    
- `substr(x, start, stop)`：截取子串
    
- `grep(pattern, x, value=TRUE)`：匹配查找
    
- `gsub(pattern, repl, x)`：替换
    
- `strsplit(x, split)`：分割
    

### 1.6 类型转换

- `as.numeric()`, `as.character()`, `as.integer()`, `as.factor()`
    
- `as.Date()`, `as.POSIXct()`
    
- `unlist()`, `as.list()`, `as.data.frame()`
    

### 1.7 汇总统计 / 向量化

- `mean()`, `median()`, `sd()`, `var()`, `quantile()`, `range()`
    
- `sum()`, `min()`, `max()`
    
- `tapply(x, group, FUN)`：按组汇总（老牌但仍常用）
    
- `aggregate(x ~ g1 + g2, data=df, FUN)`：按组汇总（data.frame 友好）
    
- `by(data, INDICES, FUN)`：按组执行函数
    
- `apply(X, MARGIN, FUN)`：矩阵按行/列
    
- `lapply()`, `sapply()`, `vapply()`：列表/向量映射
    
- `mapply()`：多参数映射
    

### 1.8 重新塑形（base）

- `reshape()`：宽长转换（不如 tidyverse 常用）
    
- `stack()`, `unstack()`：简单宽长转换
    

---

## 2) tidyverse 通用（不止 dplyr）

### 2.1 tibble（更好用的数据框）

- `tibble::tibble(...)`：建 tibble
    
- `tibble::as_tibble(x)`：转 tibble
    
- `tibble::tribble(...)`：手写小表（行方式）
    

### 2.2 readr（读写数据）

- `readr::read_csv()`, `read_tsv()`, `read_delim()`
    
- `readr::write_csv()`
    

### 2.3 stringr（字符串）

- `stringr::str_detect(x, pattern)`：是否匹配
    
- `str_subset(x, pattern)`：筛选匹配项
    
- `str_replace()`, `str_replace_all()`
    
- `str_split()`
    
- `str_extract()`
    
- `str_trim()`
    
- `str_to_lower()`, `str_to_upper()`
    

### 2.4 lubridate（日期时间）

- `ymd()`, `mdy()`, `dmy()`
    
- `ymd_hms()`
    
- `floor_date()`, `ceiling_date()`
    
- `interval()`, `duration()`
    

### 2.5 purrr（函数式/映射）

- `purrr::map()`, `map_dbl()`, `map_chr()`, `map_df()`
    
- `map2()`, `pmap()`
    
- `walk()`：只执行副作用不返回
    
- `possibly()`, `safely()`：容错执行
    

### 2.6 tidyr（数据整形：非常常用）

- `pivot_longer()`：宽 → 长
    
- `pivot_wider()`：长 → 宽
    
- `separate()`：按分隔符拆列
    
- `unite()`：合并多列为一列
    
- `separate_rows()`：一格多值拆成多行
    
- `drop_na()`, `replace_na()`
    
- `fill()`：向下/向上填充缺失
    
- `nest()`, `unnest()`：嵌套数据（建模常用）
    

### 2.7 forcats（因子）

- `fct_relevel()`：调整水平顺序
    
- `fct_reorder()`：按数值重排水平（画图/汇总很常用）
    
- `fct_lump()`：合并低频水平
    

---

## 3) dplyr 核心（你日常 80% 的操作）

### 3.1 行/列操作（最常用五件套）

- `select()`：选列
    
    - `select(starts_with("x"))`, `ends_with()`, `contains()`, `matches()`
        
- `filter()`：筛行（条件筛选）
    
- `mutate()`：新增/修改列
    
- `arrange()`：排序
    
- `summarise()`：汇总（常配合分组）
    

### 3.2 分组与汇总

- `group_by(...)`
    
- `summarise(...)`
    
- `ungroup()`
    
- `count(x, sort=TRUE)`：快速计数（等价 group_by + summarise(n=n())）
    
- `n()`, `n_distinct()`：组内计数/去重计数
    
- `across(cols, fns)`：对多列批量计算（超级常用）
    

### 3.3 连接（join）

- `left_join(x, y, by=...)`
    
- `inner_join()`
    
- `right_join()`
    
- `full_join()`
    
- `anti_join()`：找 x 中没有匹配到 y 的
    
- `semi_join()`：保留 x 中能匹配到 y 的（不带 y 的列）
    

### 3.4 组合 / 集合

- `bind_rows(...)`, `bind_cols(...)`
    
- `distinct()`：去重（行级）
    
- `union()`, `intersect()`, `setdiff()`
    

### 3.5 排序/排名/窗口函数

- `desc(x)`：降序
    
- `slice_head(n=)`, `slice_tail()`, `slice_sample()`
    
- `slice_max(order_by, n=)` / `slice_min()`
    
- `row_number()`, `min_rank()`, `dense_rank()`
    
- `lag()`, `lead()`：前后位移（时间序列常用）
    
- `cummean()`, `cumsum()`, `cummin()`, `cummax()`
    

### 3.6 条件与缺失

- `if_else(cond, a, b)`：类型更严格，比 `ifelse` 更安全
    
- `case_when(...)`：多条件映射（非常常用）
    
- `coalesce(x, y, z)`：依次用非 NA 的值填充
    

### 3.7 其他高频

- `rename(new = old)`
    
- `relocate(col, .before=, .after=)`
    
- `pull(col)`：抽取一列成向量
    
- `everything()`：选择全部列（select 辅助）
    
- `recode()` / `recode_factor()`：值映射
    

---

## 4) 一套“最常用”的组合模板（你可以当写法套路）

### 4.1 清洗 + 筛选 + 新列 + 汇总（标准 pipeline）

```r
df %>%
  filter(...) %>%
  mutate(...) %>%
  group_by(...) %>%
  summarise(...)
```

### 4.2 多列批量处理（across）

```r
df %>%
  summarise(across(where(is.numeric), ~mean(.x, na.rm = TRUE)))
```

### 4.3 宽长转换（pivot）

```r
long <- df %>% tidyr::pivot_longer(cols = -id, names_to = "feature", values_to = "value")
wide <- long %>% tidyr::pivot_wider(names_from = feature, values_from = value)
```

---

