# Hugo Book 知识库项目使用说明

## 📋 项目概述

这是一个基于 **Hugo Book** 主题构建的个人知识库网站项目，实现了从 **Obsidian** 笔记到在线网站的自动化发布流程。

### 核心特性

- 📚 **书籍式文档结构**：类似书籍的层级化文档组织
- 🔍 **内置搜索功能**：支持全文搜索
- 🌓 **深色模式**：自动适配系统主题
- 📐 **数学公式支持**：使用 KaTeX 渲染 LaTeX 公式
- 📊 **图表支持**：支持 Mermaid 流程图、时序图等
- 🔄 **自动化部署**：Obsidian → Hugo → GitHub → Vercel 全自动流程
- 📝 **博客功能**：支持时间线式的博客文章

### 项目信息

- **网站地址**: https://book.abysses.love/
- **Hugo 版本**: v0.153.0+
- **主题**: [Hugo Book](https://github.com/alex-shpak/hugo-book)
- **托管平台**: Vercel
- **内容源**: Obsidian 笔记库

---

## 📁 项目结构

```
my_book/
├── content/                    # Hugo 内容目录
│   ├── _index.md              # 网站首页
│   ├── docs/                  # 主文档区（左侧菜单）
│   │   └── Tutorial/          # 教程文档
│   │       ├── 01_Programming/      # 编程相关
│   │       │   ├── 01_Python/
│   │       │   ├── 02_R_Language/
│   │       │   └── 03_Linux_Shell/
│   │       ├── 02_Bioinformatics/   # 生物信息学
│   │       │   ├── 01_Theory/        # 理论基础
│   │       │   ├── 02_Pipelines/     # 分析流程
│   │       │   └── 03_Structure_Viz/ # 结构可视化
│   │       ├── 03_Tools_Efficiency/  # 工具与效率
│   │       │   ├── 01_Obsidian_KM/   # Obsidian 知识管理
│   │       │   ├── 02_DevOps_Git/    # DevOps 与 Git
│   │       │   └── 03_AI_Workflow/   # AI 工作流
│   │       ├── 04_Games_Inspiration/ # 游戏与灵感
│   │       └── 05_Projects/          # 项目
│   └── posts/                 # 博客文章
│       ├── _index.md
│       └── *.md               # 博客文章
│
├── static/                    # 静态资源
│   ├── attachments/           # 图片和附件（从 Obsidian 同步）
│   ├── avatar.jpg             # 头像
│   └── bg.mp4                 # 背景视频
│
├── layouts/                   # 自定义布局模板
│   ├── _partials/
│   ├── index.html             # 首页布局
│   └── posts/
│       └── list.html          # 博客列表布局
│
├── assets/                    # 资源文件
│   └── _custom.scss          # 自定义样式
│
├── themes/                   # 主题目录
│   └── hugo-book/            # Hugo Book 主题（Git submodule）
│
├── hugo.toml                 # Hugo 配置文件
├── vercel.json               # Vercel 部署配置
├── deploy.sh                 # 完整部署脚本（同步 Obsidian）
├── push.sh                   # 快速推送脚本（不同步 Obsidian）
│
├── README.md                 # Hugo Book 使用指南
├── SETUP.md                  # 完整设置指南
├── QUICK_START.md            # 快速开始指南
├── OBSIDIAN_SETUP.md         # Obsidian 配置说明
├── plan.md                   # 技术方案文档
├── AGENTS.md                 # 仓库规范
└── use.md                    # 本文件（项目使用说明）
```

---

## 🛠️ 技术栈

### 核心工具

- **Hugo**: 静态网站生成器（v0.153.0+）
- **Hugo Book Theme**: 文档主题
- **Obsidian**: 笔记编辑工具（内容源）
- **Git**: 版本控制
- **Vercel**: 静态网站托管平台

### 功能支持

- **Markdown**: 内容编写格式
- **KaTeX**: 数学公式渲染
- **Mermaid**: 图表绘制
- **rsync**: 文件同步工具

---

## ⚙️ 配置文件说明

### hugo.toml

主配置文件，定义网站基本信息和功能：

```toml
baseURL = 'https://book.abysses.love/'
languageCode = 'zh-cn'
title = '⚡Abyss⚡'
theme = 'hugo-book'
timeZone = "Asia/Shanghai"

[params]
  BookSearch = true        # 开启搜索
  BookTheme = 'auto'       # 自动深色模式
  BookSection = 'docs'     # 指定文档目录
  BookPortableLinks = true

  [params.katex]
    enable = true          # 启用数学公式

# 菜单底部配置（添加博客链接）
[[menu.after]]
  name = "📝 博客"
  url = "/posts/"
  weight = 10

[markup]
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = true        # 允许 HTML/JS (Mermaid 必需)
  [markup.tableOfContents]
    startLevel = 2
    endLevel = 4
```

### vercel.json

Vercel 部署配置：

```json
{
  "git": {
    "deploymentEnabled": {
      "main": true
    }
  },
  "build": {
    "env": {
      "HUGO_VERSION": "0.153.0"
    }
  },
  "installCommand": "git submodule update --init --recursive && echo 'Submodules initialized'"
}
```

---

## 📝 内容组织规则

### 文档结构（content/docs/）

所有放在 `content/docs/` 目录下的内容会：
- ✅ 自动出现在左侧导航菜单
- ✅ 按照 `weight` 参数排序
- ✅ 支持无限层级嵌套

#### 目录命名规范

- 使用数字前缀控制顺序：`01_Programming/`, `02_Bioinformatics/`
- 每个文件夹必须包含 `_index.md` 文件
- 文件名使用小写字母和连字符：`r基础函数.md`

#### Front Matter 参数

**章节页（_index.md）**：
```yaml
---
title: "编程"
weight: 1
bookCollapseSection: false  # 是否默认折叠
bookFlatSection: false       # 是否平铺显示
---
```

**普通页面**：
```yaml
---
title: "Python 基础教程"
weight: 1
bookToc: true               # 显示右侧目录
bookHidden: false          # 是否在菜单中隐藏
---
```

### 博客文章（content/posts/）

博客文章特点：
- 按时间倒序排列
- 不显示在左侧菜单
- 有独立的文章列表页
- 支持标签和分类

**Front Matter 示例**：
```yaml
---
title: "我的第一篇博客"
date: 2024-12-22
tags: ["Hugo", "博客"]
categories: ["技术"]
---
```

---

## 🔄 部署流程

### 完整部署流程（deploy.sh）

执行 `./deploy.sh` 会完成以下步骤：

```
1. 同步 Obsidian 内容
   └─ rsync 从 Obsidian → content/
   
2. 同步附件
   └─ rsync 从 Obsidian attachments → static/attachments/
   
3. 检查主题修改
   └─ 如果主题有修改，自动提交并推送
   
4. 提交到 GitHub
   └─ git add . && git commit && git push
   
5. Vercel 自动构建
   └─ 检测到推送后自动构建并部署
```

### 快速推送（push.sh）

当只修改了配置、样式等，不涉及 Obsidian 内容时：

```bash
./push.sh "修改网站标题"
```

---

## 📚 Obsidian 同步机制

### 源目录结构

Obsidian 中的内容源目录：

```
LifeOS/
└── 6. Website/
    ├── 2.hugo_books/        # 主内容目录
    │   ├── docs/            # 文档（同步到 content/docs/）
    │   └── posts/           # 博客（同步到 content/posts/）
    └── attachments/         # 附件（同步到 static/attachments/）
```

### 同步配置

在 `deploy.sh` 中配置的路径：

```bash
# Obsidian 源目录
OBSIDIAN_CONTENT="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/LifeOS/6. Website/2.hugo_books"

# Hugo 目标目录
HUGO_CONTENT="$BOOK_DIR/content"

# 附件目录
OBSIDIAN_ATTACHMENTS="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/LifeOS/6. Website/attachments"
HUGO_ATTACHMENTS="$BOOK_DIR/static/attachments"
```

### 同步规则

- ✅ 使用 `rsync --delete` 保持完全一致
- ✅ 排除 `.DS_Store`、`.obsidian`、`.trash` 等系统文件
- ✅ 排除 `drafts/` 草稿目录
- ✅ 保留文件权限和时间戳

---

## 🚀 使用指南

### 本地开发

#### 启动开发服务器

```bash
cd /Users/hcyang/AI/gemini_project/hugo_site/my_book
hugo server -D
# 访问 http://localhost:1313
```

#### 构建生产版本

```bash
hugo --minify
# 生成到 public/ 目录
```

### 日常发布流程

#### 场景 1：写文章并发布

1. **在 Obsidian 中写作**
   - 在 `6. Website/2.hugo_books/docs/` 或 `posts/` 中创建/编辑文件
   - 使用 Markdown 语法
   - 添加 Front Matter

2. **本地预览（可选）**
   ```bash
   hugo server -D
   ```

3. **发布到网站**
   ```bash
   ./deploy.sh
   ```

4. **等待部署完成**
   - Vercel 自动构建（约 1-2 分钟）
   - 访问 https://book.abysses.love/ 查看

#### 场景 2：修改配置/样式

```bash
# 不涉及 Obsidian 内容同步
./push.sh "修改网站配置"
```

### 添加图片

1. **在 Obsidian 中插入图片**
   - 图片自动保存到 `6. Website/attachments/`
   - 使用标准 Markdown：`![描述](/attachments/image.png)`

2. **部署**
   ```bash
   ./deploy.sh
   # 脚本会自动同步附件目录
   ```

---

## 📖 内容分类说明

### 当前内容结构

#### 01_Programming（编程）

- **01_Python**: Python 编程相关
- **02_R_Language**: R 语言相关
  - R基础函数
  - R数据清洗常用函数
- **03_Linux_Shell**: Linux Shell 脚本

#### 02_Bioinformatics（生物信息学）

- **01_Theory（理论基础）**
  - Bulk-RNAseq: 批量 RNA 测序理论
  - scRNA-seq: 单细胞 RNA 测序
    - ScripyTCR术语表
    - scRNA-TCR
    - TCR在癌症免疫治疗中研究实例
    - UMI
    - 单细胞高变基因
  - Spatial-ST: 空间转录组

- **02_Pipelines（分析流程）**
  - Bulk: 批量分析流程
    - Python/R/Shell 实现
  - scRNA: 单细胞分析流程
    - Python/R/Shell 实现
    - Cellchat 分析
  - ST: 空间转录组流程
    - Python/R/Shell 实现
    - 空转数据的读取方式

- **03_Structure_Viz（结构可视化）**

#### 03_Tools_Efficiency（工具与效率）

- **01_Obsidian_KM**: Obsidian 知识管理
  - lifeOS_gif教程
  - lifeos_常见问题
  - 各种插件的使用

- **02_DevOps_Git**: DevOps 与 Git
  - Git推送教程
  - jupyter添加内核
  - obsidian和hugo联用----Vercel 云端构建的自动化流程
  - SSH 密钥-github
  - 终端的代理配置

- **03_AI_Workflow**: AI 工作流

#### 04_Games_Inspiration（游戏与灵感）

- **01_Reviews**: 游戏评论
- **02_Gamification**: 游戏化
- **03_Game_Dev**: 游戏开发

#### 05_Projects（项目）

- **01_Website**: 网站相关项目
  - cloudflare使用(子域名创建)
  - 申请euo.rg

---

## 🔧 脚本说明

### deploy.sh

**功能**：完整部署脚本，同步 Obsidian 内容并推送到 GitHub

**执行流程**：
1. 检查 Obsidian 源目录是否存在
2. 使用 rsync 同步内容到 `content/`
3. 同步附件到 `static/attachments/`
4. 检查主题 submodule 是否有修改，如有则提交
5. 提交所有更改到 Git
6. 推送到 GitHub
7. 发送系统通知（如果安装了 terminal-notifier）

**使用**：
```bash
./deploy.sh
```

**输出示例**：
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 同步 Obsidian 内容到 Hugo...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 同步内容 (content)...
  源目录: .../2.hugo_books
  目标目录: .../content
  ✓ 内容同步完成

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

🌐 网站地址: https://book.abysses.love/
⏱️  Vercel 构建大约需要 1-2 分钟
```

### push.sh

**功能**：快速推送脚本，不涉及 Obsidian 同步

**使用场景**：
- 修改了 `hugo.toml` 配置
- 修改了主题样式
- 修改了布局模板
- 其他不涉及内容同步的更改

**使用**：
```bash
# 使用默认提交信息
./push.sh

# 使用自定义提交信息
./push.sh "修改网站标题"
```

---

## 🎨 自定义配置

### 修改网站标题

编辑 `hugo.toml`:
```toml
title = '你的知识库名称'
```

### 修改域名

编辑 `hugo.toml`:
```toml
baseURL = 'https://your-domain.com/'
```

### 自定义样式

创建或编辑 `assets/_custom.scss`:
```scss
:root {
  --body-background: #ffffff;
  --body-font-color: #333333;
}

body {
  font-family: "PingFang SC", "Microsoft YaHei", sans-serif;
}
```

### 关闭搜索功能

编辑 `hugo.toml`:
```toml
[params]
  BookSearch = false
```

---

## ❓ 常见问题

### 问题 1：deploy.sh 提示找不到 Obsidian 目录

**错误信息**：
```
⚠️  警告：Obsidian 源目录不存在
   路径：.../2.hugo_books
   跳过内容同步，仅推送本地修改...
```

**解决方案**：
1. 检查 Obsidian 中是否已创建 `6. Website/2.hugo_books/` 目录
2. 确认路径是否正确（检查 deploy.sh 中的 `OBSIDIAN_CONTENT` 变量）
3. 如果路径不同，修改 deploy.sh 中的配置

### 问题 2：内容同步了但网站没更新

**可能原因**：
1. Vercel 还在构建中（等待 1-2 分钟）
2. 浏览器缓存（强制刷新：Cmd+Shift+R）
3. Git 推送失败（检查终端输出）

**检查步骤**：
```bash
# 1. 检查 Git 状态
git status

# 2. 检查最近的提交
git log --oneline -3

# 3. 检查 Vercel 部署日志
# 访问 https://vercel.com/dashboard
```

### 问题 3：图片不显示

**检查清单**：
- [ ] 图片是否在 `static/attachments/` 目录
- [ ] Markdown 中使用的是绝对路径：`/attachments/image.png`
- [ ] 文件名是否包含中文或特殊字符
- [ ] deploy.sh 是否成功同步了附件目录

**解决方案**：
```bash
# 手动检查附件目录
ls -la static/attachments/

# 手动同步附件（如果需要）
rsync -av \
  "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/LifeOS/6. Website/attachments/" \
  static/attachments/
```

### 问题 4：菜单不显示内容

**检查清单**：
- [ ] 内容是否在 `content/docs/` 目录
- [ ] 每个文件夹是否有 `_index.md`
- [ ] Front Matter 中是否设置了 `title`
- [ ] 是否设置了 `bookHidden: true`

**解决方案**：
1. 确保每个目录都有 `_index.md`
2. 检查 Front Matter 格式是否正确
3. 清除浏览器缓存后重试

### 问题 5：主题样式异常

**解决方案**：
```bash
# 重新初始化主题 submodule
git submodule update --init --recursive

# 检查主题状态
cd themes/hugo-book
git status
git log --oneline -3
```

### 问题 6：Vercel 构建失败

**常见原因**：
1. Hugo 版本不匹配
2. Git submodule 未初始化
3. 缺少必需的文件

**检查步骤**：
1. 查看 Vercel 构建日志
2. 确认 `vercel.json` 配置正确
3. 确认主题 submodule 已正确初始化

---

## 📚 相关文档

### 项目文档

- **README.md**: Hugo Book 详细使用指南
- **SETUP.md**: 完整安装设置指南
- **QUICK_START.md**: 快速开始指南
- **OBSIDIAN_SETUP.md**: Obsidian 配置说明
- **plan.md**: 技术方案和架构设计
- **AGENTS.md**: 仓库规范和开发指南

### 外部资源

- **Hugo Book 主题文档**: https://github.com/alex-shpak/hugo-book
- **Hugo 官方文档**: https://gohugo.io/documentation/
- **Markdown 语法**: https://www.markdownguide.org/
- **KaTeX 数学公式**: https://katex.org/
- **Mermaid 图表**: https://mermaid.js.org/

---

## 🎯 最佳实践

### 内容组织

1. **使用数字前缀控制顺序**
   - 文件夹：`01_Programming/`, `02_Bioinformatics/`
   - 文件：`01-intro.md`, `02-basics.md`

2. **每个目录都创建 _index.md**
   - 定义章节标题和权重
   - 控制菜单显示行为

3. **合理使用 weight 参数**
   - 数字越小越靠前
   - 建议使用 10 的倍数，便于后续插入

4. **保持文件名简洁**
   - 使用小写字母和连字符
   - 避免中文和特殊字符

### 写作规范

1. **Front Matter 标准化**
   - 必须包含 `title`
   - 建议设置 `weight` 控制顺序
   - 使用 `bookToc: true` 显示目录

2. **图片引用规范**
   - 统一放在 `attachments/` 目录
   - 使用绝对路径：`/attachments/image.png`
   - 添加有意义的 alt 文本

3. **链接使用**
   - 文档内链接使用相对路径
   - 外部链接使用完整 URL

### 版本控制

1. **提交信息规范**
   - 使用时间戳格式：`Update: YYYY-MM-DD HH:MM:SS`
   - 主题更新：`Theme update: YYYY-MM-DD HH:MM:SS`
   - 配置更新：`Site update: 描述`

2. **小步提交**
   - 每次提交只包含相关的更改
   - 便于回滚和问题定位

---

## 🔄 工作流程总结

### 完整发布流程

```
┌─────────────────────────────────────────┐
│  1. 在 Obsidian 中写作/编辑内容          │
│     LifeOS/6. Website/2.hugo_books/     │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│  2. 执行 deploy.sh                      │
│     - 同步 Obsidian → Hugo              │
│     - 同步附件                           │
│     - 检查主题修改                       │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│  3. Git 提交并推送                      │
│     - git add .                         │
│     - git commit                        │
│     - git push                          │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│  4. Vercel 自动构建                     │
│     - 检测到推送                        │
│     - 初始化 submodule                  │
│     - 使用 Hugo 构建                    │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│  5. 网站自动更新                        │
│     https://book.abysses.love/          │
└─────────────────────────────────────────┘
```

### 快速更新流程（仅配置/样式）

```
┌─────────────────────────────────────────┐
│  1. 修改配置/样式                        │
│     - hugo.toml                         │
│     - assets/_custom.scss               │
│     - layouts/*.html                    │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│  2. 执行 push.sh                        │
│     ./push.sh "修改网站标题"             │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│  3. Git 推送 → Vercel 构建 → 网站更新   │
└─────────────────────────────────────────┘
```

---

## 📊 项目统计

### 内容统计

- **文档章节**: 5 个主要分类
  - 01_Programming（编程）
  - 02_Bioinformatics（生物信息学）
  - 03_Tools_Efficiency（工具与效率）
  - 04_Games_Inspiration（游戏与灵感）
  - 05_Projects（项目）

- **文档页面**: 约 50+ 个 Markdown 文件
- **博客文章**: 5+ 篇

### 技术特性

- ✅ Obsidian 自动同步
- ✅ Git 版本控制
- ✅ Vercel 自动部署
- ✅ 搜索功能
- ✅ 深色模式
- ✅ 数学公式支持
- ✅ 图表支持

---

## 🎉 总结

这是一个完整的个人知识库解决方案，实现了从笔记到网站的自动化发布流程。通过 Obsidian 进行内容创作，通过 Hugo 生成静态网站，通过 Vercel 自动部署，整个过程高度自动化，只需一个命令即可完成发布。

### 核心优势

1. **单一来源**：Obsidian 是唯一的内容编辑位置
2. **自动化**：一键发布，无需手动操作
3. **版本控制**：所有内容纳入 Git 管理
4. **美观展示**：Hugo Book 主题提供优秀的阅读体验
5. **易于维护**：清晰的目录结构和规范

### 适用场景

- 个人知识库管理
- 技术文档编写
- 博客文章发布
- 项目文档维护
- 学习笔记整理

---

**最后更新**: 2024-12-29  
**维护者**: hcYang  
**项目地址**: https://book.abysses.love/

