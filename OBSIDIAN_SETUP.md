# Obsidian 目录结构配置

## 📁 Obsidian 中的目录结构

在你的 Obsidian vault 中创建以下结构：

```
LifeOS/
└── 6. Website/
    └── 2.hugo_books/           ← 主目录
        ├── docs/                ← 文档目录 ⭐
        │   ├── _index.md
        │   ├── Tutorial/
        │   │   ├── _index.md
        │   │   └── installation.md
        │   └── programming/
        │       └── _index.md
        │
        ├── posts/               ← 博客目录 ⭐
        │   ├── _index.md
        │   └── 2024-12-22-my-post.md
        │
        └── (其他文件会被忽略)
```

## 🔄 同步逻辑

`deploy.sh` 脚本会执行以下同步：

```
Obsidian                                    →  Hugo
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
2.hugo_books/docs/                          →  content/docs/
  ├── _index.md                             →    ├── _index.md
  ├── Tutorial/                             →    ├── Tutorial/
  │   ├── _index.md                         →    │   ├── _index.md
  │   └── installation.md                   →    │   └── installation.md
  └── programming/                          →    └── programming/

2.hugo_books/posts/                         →  content/posts/
  ├── _index.md                             →    ├── _index.md
  └── 2024-12-22-my-post.md                 →    └── 2024-12-22-my-post.md

attachments/                                →  static/attachments/
  └── screenshot.png                        →    └── screenshot.png
```

## ⚙️ deploy.sh 配置

```bash
# Obsidian 源目录
OBSIDIAN_BASE=".../6. Website/2.hugo_books"
OBSIDIAN_DOCS="$OBSIDIAN_BASE/docs"      # 文档源
OBSIDIAN_POSTS="$OBSIDIAN_BASE/posts"    # 博客源

# Hugo 目标目录
HUGO_DOCS="$BOOK_DIR/content/docs"       # 文档目标
HUGO_POSTS="$BOOK_DIR/content/posts"     # 博客目标
```

## 📝 在 Obsidian 中创建内容

### 1. 创建文档章节

**位置**：`2.hugo_books/docs/Tutorial/`

**创建 _index.md：**
```yaml
---
title: "快速开始"
weight: 1
bookCollapseSection: false
---

# 快速开始

这是快速开始章节。
```

**创建子页面 installation.md：**
```yaml
---
title: "安装指南"
weight: 1
bookToc: true
---

# 安装指南

安装步骤...
```

### 2. 创建博客文章

**位置**：`2.hugo_books/posts/`

**创建 _index.md：**
```yaml
---
title: "博客"
---

# 博客文章列表
```

**创建文章 2024-12-22-my-post.md：**
```yaml
---
title: "我的第一篇博客"
date: 2024-12-22
tags: ["Hugo", "博客"]
categories: ["技术"]
---

# 我的第一篇博客

博客内容...
```

## 🚀 部署流程

### 步骤 1：在 Obsidian 中创建/编辑内容

在 `2.hugo_books/docs/` 或 `2.hugo_books/posts/` 中创建或修改 Markdown 文件。

### 步骤 2：运行部署脚本

```bash
cd /Users/hcyang/AI/gemini_project/hugo_site/my_book
./deploy.sh
```

### 步骤 3：检查同步结果

脚本会显示：

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 同步 Obsidian 内容到 Hugo...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 同步文档 (docs)...
  源目录: .../2.hugo_books/docs
  目标目录: .../content/docs
  ✓ 文档同步完成

📝 同步博客文章 (posts)...
  源目录: .../2.hugo_books/posts
  目标目录: .../content/posts
  ✓ 博客同步完成

🖼️  同步附件...
  ✓ 附件同步完成
```

## ✅ 验证同步

### 检查文档

```bash
ls -la content/docs/
# 应该看到从 Obsidian 同步过来的文件
```

### 检查博客

```bash
ls -la content/posts/
# 应该看到博客文章
```

### 本地预览

```bash
hugo server -D
# 访问 http://localhost:1313
```

## 📂 完整目录示例

### Obsidian 中创建这样的结构：

```
2.hugo_books/
├── docs/
│   ├── _index.md
│   ├── Tutorial/
│   │   ├── _index.md
│   │   ├── installation.md
│   │   └── configuration.md
│   ├── programming/
│   │   ├── _index.md
│   │   ├── python/
│   │   │   ├── _index.md
│   │   │   └── basics.md
│   │   └── javascript/
│   │       └── _index.md
│   └── reference/
│       ├── _index.md
│       └── api.md
│
└── posts/
    ├── _index.md
    ├── 2024-12-22-first-post.md
    └── 2024-12-23-hugo-tips.md
```

### 同步后 Hugo 项目中的结构：

```
my_book/
└── content/
    ├── _index.md          # 手动创建的首页
    ├── docs/              # 从 Obsidian 同步
    │   ├── _index.md
    │   ├── Tutorial/
    │   ├── programming/
    │   └── reference/
    └── posts/             # 从 Obsidian 同步
        ├── _index.md
        ├── 2024-12-22-first-post.md
        └── 2024-12-23-hugo-tips.md
```

## ⚠️ 注意事项

### 1. docs 目录必须存在

如果 `2.hugo_books/docs/` 不存在，脚本会显示警告并跳过文档同步。

**创建方法**：在 Obsidian 中创建 `2.hugo_books/docs/` 文件夹。

### 2. posts 目录是可选的

如果不需要博客功能，可以不创建 `posts/` 目录，脚本会自动跳过。

### 3. 文件会被删除

`rsync --delete` 会删除目标目录中多余的文件，确保与源目录完全一致。

**示例**：
- 如果你在 Obsidian 中删除了一个文件
- 运行 `deploy.sh` 后，Hugo 项目中对应的文件也会被删除

### 4. 排除的文件

以下文件/目录不会被同步：
- `.DS_Store` - macOS 系统文件
- `.obsidian/` - Obsidian 配置
- `.trash/` - 回收站
- `*.tmp` - 临时文件
- `drafts/` - 草稿目录

### 5. 附件目录

图片和其他附件应该放在：
```
6. Website/attachments/
```

**在 Markdown 中引用**：
```markdown
![描述](/attachments/image.png)
```

## 🔧 故障排除

### 问题 1：文档没有同步

**检查**：
```bash
ls "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/LifeOS/6. Website/2.hugo_books/docs"
```

如果目录不存在，在 Obsidian 中创建。

### 问题 2：同步后内容不对

**清空目标目录重新同步**：
```bash
rm -rf content/docs/*
rm -rf content/posts/*
./deploy.sh
```

### 问题 3：路径不正确

**检查 deploy.sh 中的路径配置**：
```bash
grep OBSIDIAN deploy.sh
```

确保路径与你的实际 Obsidian vault 位置一致。

## 📖 相关文档

- `MENU_GUIDE.md` - 菜单结构配置指南
- `README.md` - Hugo Book 主题使用指南
- `SETUP.md` - 完整安装设置指南
- `plan.md` - 技术方案文档

---

**现在可以在 Obsidian 中创建内容了！** 🎉

1. 在 `2.hugo_books/docs/` 中创建文档
2. 在 `2.hugo_books/posts/` 中创建博客
3. 运行 `./deploy.sh` 同步并部署
4. 访问 https://book.hcyang.us.kg/ 查看效果
