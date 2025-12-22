# Hugo Book 菜单配置指南

基于 Hugo Book 主题官方 exampleSite 的配置说明。

## 目录结构与菜单显示的关系

### 核心原则

Hugo Book 的左侧菜单**自动**根据 `content/docs/` 目录结构生成，无需手动配置。

**关键参数：**

| 参数 | 默认值 | 作用 |
|------|--------|------|
| `bookFlatSection` | `false` | 是否平铺显示子页面（不显示父级） |
| `bookCollapseSection` | `false` | 是否默认折叠该章节 |
| `weight` | `0` | 排序权重（越小越靠前） |

---

## 问题诊断：为什么菜单不显示层级？

### 当前问题

**看到的菜单：**
```
博客
快速开始
安装指南
```

**期望的菜单：**
```
博客
Tutorial (快速开始)
  └── 安装指南
```

### 原因分析

#### 原因 1：bookFlatSection 设置错误

如果 `Tutorial/_index.md` 中设置了 `bookFlatSection: true`，会导致子页面平铺显示。

**错误配置：**
```yaml
---
title: "快速开始"
bookFlatSection: true  # ❌ 这会平铺显示
---
```

**正确配置：**
```yaml
---
title: "快速开始"
weight: 1
bookCollapseSection: false  # 默认展开
# bookFlatSection 不要设置或设置为 false
---
```

#### 原因 2：menu.before 配置影响

`hugo.toml` 中的 `[[menu.before]]` 配置会在菜单顶部添加链接。

**当前配置：**
```toml
[[menu.before]]
  name = "博客"
  url = "/posts/"
  weight = 10
```

这会导致"博客"出现在左侧菜单，**不是**顶部菜单。

---

## 解决方案

### 方案 1：正确的目录结构（推荐）

#### 步骤 1：检查 _index.md 配置

**Tutorial/_index.md 正确配置：**
```yaml
---
title: "快速开始"
weight: 1
bookCollapseSection: false
# 不要设置 bookFlatSection: true
---

# 快速开始

这里是入门指南章节。
```

#### 步骤 2：子页面配置

**Tutorial/installation.md 正确配置：**
```yaml
---
title: "安装指南"
weight: 1
bookToc: true
---

# 安装指南

内容...
```

#### 步骤 3：移除 menu.before 配置

编辑 `hugo.toml`，**删除**或**注释掉**：

```toml
# 删除这部分，博客链接放在首页即可
# [[menu.before]]
#   name = "博客"
#   url = "/posts/"
#   weight = 10
```

或者改为使用 `menu.after`（显示在菜单底部）：

```toml
[[menu.after]]
  name = "📝 博客"
  url = "/posts/"
  weight = 10
```

---

### 方案 2：使用 exampleSite 的标准结构

#### 标准目录结构

```
content/docs/
├── _index.md              # 文档首页（可选）
├── getting-started/       # 章节 1
│   ├── _index.md          # 章节说明
│   ├── installation.md    # 子页面 1
│   └── configuration.md   # 子页面 2
├── tutorial/              # 章节 2
│   ├── _index.md
│   ├── basics.md
│   └── advanced.md
└── reference/             # 章节 3
    ├── _index.md
    └── api.md
```

#### 章节 _index.md 模板

```yaml
---
title: "章节标题"
weight: 1                    # 章节排序
bookCollapseSection: false   # false=默认展开, true=默认折叠
# bookFlatSection: false     # 保持层级结构（默认）
---

# 章节标题

章节介绍内容。
```

#### 普通页面模板

```yaml
---
title: "页面标题"
weight: 1        # 页面排序
bookToc: true    # 显示右侧目录
---

# 页面标题

页面内容...
```

---

## 完整示例

### 示例 1：两层结构

**目录结构：**
```
docs/
├── tutorial/
│   ├── _index.md
│   ├── step1.md
│   └── step2.md
└── guide/
    ├── _index.md
    └── intro.md
```

**菜单显示效果：**
```
Tutorial
  ├── Step 1
  └── Step 2
Guide
  └── Introduction
```

**配置文件：**

`tutorial/_index.md`:
```yaml
---
title: "Tutorial"
weight: 1
bookCollapseSection: false
---

# Tutorial

教程章节介绍。
```

`tutorial/step1.md`:
```yaml
---
title: "Step 1"
weight: 1
---

# Step 1

第一步内容。
```

---

### 示例 2：三层嵌套结构

**目录结构：**
```
docs/
└── programming/
    ├── _index.md
    ├── python/
    │   ├── _index.md
    │   ├── basics.md
    │   └── advanced.md
    └── javascript/
        ├── _index.md
        └── async.md
```

**菜单显示效果：**
```
Programming
  ├── Python
  │   ├── Basics
  │   └── Advanced
  └── JavaScript
      └── Async Programming
```

**配置文件：**

`programming/_index.md`:
```yaml
---
title: "Programming"
weight: 1
bookCollapseSection: false
---
```

`programming/python/_index.md`:
```yaml
---
title: "Python"
weight: 1
bookCollapseSection: false
---
```

`programming/python/basics.md`:
```yaml
---
title: "Basics"
weight: 1
---
```

---

## 特殊参数说明

### bookFlatSection

**作用**：控制是否平铺显示子页面

**示例：**

**设置为 true（平铺）：**
```yaml
---
title: "API Reference"
bookFlatSection: true
---
```

**菜单显示：**
```
API Reference
GET /users
POST /users
DELETE /users
```
（所有子页面与父页面平级显示）

**设置为 false 或不设置（层级）：**
```yaml
---
title: "API Reference"
bookFlatSection: false
---
```

**菜单显示：**
```
API Reference
  ├── GET /users
  ├── POST /users
  └── DELETE /users
```
（子页面在父页面下方，有缩进）

---

### bookCollapseSection

**作用**：控制章节是否默认折叠

**示例：**

```yaml
---
title: "Advanced Topics"
bookCollapseSection: true  # 默认折叠
---
```

**效果**：用户需要点击章节标题才能展开查看子页面。

---

### bookHidden

**作用**：隐藏页面，不在菜单中显示

**示例：**

```yaml
---
title: "Draft Page"
bookHidden: true
---
```

该页面不会出现在左侧菜单，但可以通过直接 URL 访问。

---

## 博客链接的放置位置

### 选项 1：放在首页（推荐）

在 `content/_index.md` 或 `content/docs/_index.md` 中添加链接：

```markdown
## 📝 博客

查看我的[博客文章](/posts/)。
```

**优点**：
- 左侧菜单只显示文档结构
- 清晰的内容区分

### 选项 2：使用 menu.after

在 `hugo.toml` 中配置：

```toml
[[menu.after]]
  name = "📝 博客"
  url = "/posts/"
  weight = 10
```

**效果**：博客链接显示在左侧菜单**底部**，与文档分离。

### 选项 3：使用顶部导航（需要自定义主题）

Hugo Book 默认没有顶部导航栏，需要自定义 layout。

---

## 当前项目的修复步骤

### 步骤 1：修改 hugo.toml

**删除或移动博客链接：**

```toml
# 删除 menu.before 配置
# [[menu.before]]
#   name = "博客"
#   url = "/posts/"
#   weight = 10

# 改为 menu.after（菜单底部）
[[menu.after]]
  name = "📝 博客"
  url = "/posts/"
  weight = 10
```

### 步骤 2：确认 Tutorial/_index.md 配置

```yaml
---
title: "快速开始"
weight: 1
bookCollapseSection: false
# 确保没有 bookFlatSection: true
---
```

### 步骤 3：重启 Hugo 服务器

```bash
# 停止当前服务器 (Ctrl+C)
hugo server -D
```

### 步骤 4：验证菜单结构

**期望的菜单：**
```
首页
快速开始
  └── 安装指南
─────────────
📝 博客
```

---

## 在 Obsidian 中的目录组织

### 推荐结构

```
2.hugo_books/
├── _index.md                # 文档首页（可选）
├── getting-started/         # 第一章
│   ├── _index.md
│   ├── installation.md
│   └── configuration.md
├── tutorial/                # 第二章
│   ├── _index.md
│   ├── lesson-1.md
│   └── lesson-2.md
├── reference/               # 第三章
│   ├── _index.md
│   └── api.md
└── posts/                   # 博客文章
    ├── _index.md
    └── my-post.md
```

### Front Matter 模板

**章节 _index.md：**
```yaml
---
title: "章节标题"
weight: 1
bookCollapseSection: false
---

# 章节标题

章节介绍。
```

**普通页面：**
```yaml
---
title: "页面标题"
weight: 1
bookToc: true
---

# 页面标题

内容...
```

**博客文章：**
```yaml
---
title: "博客标题"
date: 2024-12-22
tags: ["标签1", "标签2"]
categories: ["分类"]
---

# 博客标题

内容...
```

---

## 常见问题

### Q1: 为什么菜单显示是平的，没有层级？

**A**: 检查 `_index.md` 中是否设置了 `bookFlatSection: true`。移除或设置为 `false`。

### Q2: 如何调整菜单项的顺序？

**A**: 使用 `weight` 参数，数字越小越靠前。

### Q3: 如何让章节默认折叠？

**A**: 在 `_index.md` 中设置 `bookCollapseSection: true`。

### Q4: 博客链接应该放在哪里？

**A**: 推荐使用 `menu.after` 放在菜单底部，或在首页添加链接。

### Q5: 如何隐藏某个页面？

**A**: 在页面的 Front Matter 中设置 `bookHidden: true`。

---

## 参考资源

- Hugo Book 主题文档: https://github.com/alex-shpak/hugo-book
- exampleSite 示例: `themes/hugo-book/exampleSite/`
- Hugo 文档: https://gohugo.io/content-management/menus/

---

**总结**：
- 菜单**自动**根据目录结构生成
- 使用 `bookFlatSection` 控制平铺 vs 层级
- 使用 `weight` 控制顺序
- 博客链接建议使用 `menu.after` 或放在首页
