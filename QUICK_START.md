# Hugo Book 快速开始 - 目录结构说明

## 📁 Obsidian 目录结构

在你的 Obsidian vault 中，所有内容都在一个目录下：

```
LifeOS/
└── 6. Website/
    ├── 2. hugo_book/           ← 主目录
    │   ├── _index.md            ← 网站首页
    │   │
    │   ├── getting-started/     ← 文档：快速开始
    │   │   ├── _index.md
    │   │   ├── installation.md
    │   │   └── configuration.md
    │   │
    │   ├── programming/         ← 文档：编程
    │   │   ├── _index.md
    │   │   ├── python/
    │   │   │   ├── _index.md
    │   │   │   └── basics.md
    │   │   └── javascript/
    │   │       └── _index.md
    │   │
    │   ├── reference/           ← 文档：参考
    │   │   ├── _index.md
    │   │   └── api.md
    │   │
    │   └── posts/               ← 博客文章 ⭐
    │       ├── _index.md
    │       ├── 2024-12-22-first-post.md
    │       └── 2024-12-23-second-post.md
    │
    └── attachments/             ← 统一的图片目录
        ├── screenshot.png
        └── diagram.svg
```

## 📝 内容类型区别

### 文档 (docs)

**位置**：`2. hugo_book/` 根目录及子目录（除了 `posts/`）

**用途**：
- 知识库文档
- 教程
- 参考手册
- 层级化的结构

**特点**：
- 显示在左侧菜单树
- 支持无限层级
- 使用 `weight` 参数排序
- 每个目录需要 `_index.md`

**示例 Front Matter**：
```markdown
---
title: "Python 基础教程"
weight: 1
bookToc: true
bookCollapseSection: false
---

# Python 基础教程

文档内容...
```

### 博客 (posts)

**位置**：`2. hugo_book/posts/`

**用途**：
- 时间线式的博客文章
- 新闻、公告
- 随笔、思考

**特点**：
- 按时间倒序排列
- 不显示在左侧菜单
- 有独立的文章列表页
- 支持标签和分类

**示例 Front Matter**：
```markdown
---
title: "我的第一篇博客"
date: 2024-12-22
tags: ["博客", "Hugo"]
categories: ["技术"]
---

博客内容...
```

## 🔄 同步逻辑

执行 `./deploy.sh` 时：

```
Obsidian: 2. hugo_book/
├── (除 posts 外的所有内容)  →  Hugo: content/docs/
└── posts/                     →  Hugo: content/posts/
```

**关键点**：
- `posts/` 目录会被单独同步到 `content/posts/`
- 其他所有内容同步到 `content/docs/`（不包括 `posts/`）
- 附件统一同步到 `static/attachments/`

## 📋 创建示例内容

### 1. 创建首页

**文件**：`2. hugo_book/_index.md`

```markdown
---
title: "知识库首页"
type: docs
---

# 欢迎来到我的知识库

这里包含我的文档和博客文章。

## 📚 文档

- [快速开始](getting-started/)
- [编程教程](programming/)
- [参考资料](reference/)

## 📝 最新博客

访问 [博客页面](/posts/) 查看所有文章。
```

### 2. 创建文档章节

**文件**：`getting-started/_index.md`

```markdown
---
title: "快速开始"
weight: 1
bookCollapseSection: false
---

# 快速开始

这是入门指南章节。
```

**文件**：`getting-started/installation.md`

```markdown
---
title: "安装指南"
weight: 1
bookToc: true
---

# 安装指南

## 前置条件

需要以下软件...

## 安装步骤

1. 下载安装包
2. 运行安装程序
3. 配置环境变量
```

### 3. 创建博客文章

**目录**：先创建 `posts/` 文件夹

**文件**：`posts/_index.md`

```markdown
---
title: "博客"
---

# 博客文章

这里是我的博客文章列表。
```

**文件**：`posts/2024-12-22-first-post.md`

```markdown
---
title: "我的第一篇博客"
date: 2024-12-22
tags: ["Hugo", "博客"]
categories: ["技术"]
---

# 我的第一篇博客

这是我的第一篇博客文章。

## 内容

今天开始使用 Hugo Book 主题搭建知识库...
```

**文件**：`posts/2024-12-23-hugo-tips.md`

```markdown
---
title: "Hugo 使用技巧"
date: 2024-12-23
tags: ["Hugo", "教程"]
categories: ["技术"]
---

# Hugo 使用技巧

分享一些 Hugo 的使用技巧。

## 技巧 1：使用 shortcodes

Hugo 提供了很多实用的 shortcodes...
```

## 🚀 部署流程

### 首次部署

```bash
cd /Users/hcyang/AI/gemini_project/hugo_site/my_book

# 1. 本地预览（可选）
hugo server -D
# 访问 http://localhost:1313
# 检查文档和博客是否都正常显示

# 2. 执行部署
./deploy.sh

# 3. 等待 Vercel 构建（1-2 分钟）
# 4. 访问 https://book.hcyang.us.kg/
```

### 部署输出示例

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 同步 Obsidian 内容到 Hugo...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 同步文档 (docs)...
  源目录: .../2. hugo_book
  目标目录: .../content/docs
  ✓ 文档同步完成

📝 同步博客文章 (posts)...
  源目录: .../2. hugo_book/posts
  目标目录: .../content/posts
  ✓ 博客同步完成

🖼️  同步附件...
  ✓ 附件同步完成

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎨 检查主题修改...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  → 主题无变化

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📦 提交到 GitHub...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ✓ 已推送到 GitHub

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ 发布完成！
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌐 网站地址: https://book.hcyang.us.kg/
⏱️  Vercel 构建大约需要 1-2 分钟
```

## 📊 网站结构

部署后的网站结构：

```
网站首页 (/)
│
├── 📚 文档 (左侧菜单)
│   ├── 快速开始
│   │   ├── 安装指南
│   │   └── 配置
│   ├── 编程
│   │   ├── Python
│   │   └── JavaScript
│   └── 参考
│       └── API
│
└── 📝 博客 (/posts/)
    ├── 2024-12-23 Hugo 使用技巧
    ├── 2024-12-22 我的第一篇博客
    └── ...
```

## ❓ 常见问题

### Q1: 博客文章会出现在左侧菜单吗？

**A**: 不会。`posts/` 目录中的文章不会显示在左侧文档菜单中，它们有独立的博客列表页面。

### Q2: 可以在文档中链接到博客文章吗？

**A**: 可以。使用相对路径：
```markdown
查看我的[博客文章](/posts/2024-12-22-first-post/)
```

### Q3: 博客文章需要设置 weight 吗？

**A**: 不需要。博客文章按 `date` 字段排序，最新的在最前面。

### Q4: 可以不创建 posts 目录吗？

**A**: 可以。如果你只需要文档功能，不创建 `posts/` 目录即可，deploy.sh 会自动跳过博客同步。

### Q5: 如何访问博客列表？

**A**: 访问 `/posts/` 路径，例如：https://book.hcyang.us.kg/posts/

### Q6: 文档和博客可以使用同样的图片吗？

**A**: 可以。所有图片都放在统一的 `attachments/` 目录，使用 `/attachments/image.png` 引用。

## 📚 更多信息

- **详细使用指南**：查看 `README.md`
- **技术方案**：查看 `plan.md`
- **完整设置指南**：查看 `SETUP.md`

---

**开始创建你的知识库吧！** 🎉
