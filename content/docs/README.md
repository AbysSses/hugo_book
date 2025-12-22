# Abyss Hugo 博客

基于 Hugo 的个人博客项目，使用 Abyss 主题，支持从 Obsidian 同步文章，自动部署到 Vercel。
## 项目信息
- 网站地址: https://siyu.hcyang.us.kg/

- Hugo 版本: v0.153.0

- 主题: [Abyss](https://github.com/AbysSses/hugo_theme_abyss)

- 托管平台: Vercel
- 仓库本地目录
```
/Users/hcyang/AI/gemini_project/hugo_site/siyu
```
## 目录结构

```

my-blog/

├── content/posts/ # 文章内容（从 Obsidian 同步）

├── static/

│ ├── images/ # 背景图片资源

│ └── videos/ # 视频背景资源

├── themes/

│ └── Abyss/ # 主题（Git submodule）

├── hugo.toml # Hugo 配置文件

├── vercel.json # Vercel 部署配置

├── deploy.sh # 完整部署脚本

└── push.sh # 快速推送脚本

```

## 使用说明

## 部署流程

  

1. **本地修改** → 编辑文章/主题/资源

2. **运行脚本** → `./deploy.sh` 或 `./push.sh`

3. **推送到 GitHub** → 脚本自动完成

4. **Vercel 构建** → 自动检测推送并构建（约 1-2 分钟）

5. **网站更新** → https://siyu.hcyang.us.kg/

### 1. 日常写作发布

从 Obsidian 的LifeOS/6. Website/1. hugo_siyu/posts写文章并发布到网站：

使用Linter快速格式化文件:
<font color="#ff0000">快捷键 command + L</font>
- 文章格式：
```
---
title: "我的第一篇文章"
subtitle: "副标题（可选）"
date: 2025-12-20
draft: false
excerpt: "这是文章摘要，将显示在卡片上"（可选）
backgroundImage: "/images/my-bg.jpg"
categories: ["随笔"]
tags: ["思考", "感悟"]
---

这里是文章正文内容...
```

```bash

cd /Users/hcyang/AI/gemini_project/hugo_site/my-blog

./deploy.sh

```
以上内容通过Obsidian插件Shell commands实现一键自动部署。点击左侧命令按钮即可
  
**deploy.sh 执行流程：**

1. 从 Obsidian 同步文章到 `content/posts/`

2. 检查并提交主题 submodule 的修改

3. 提交并推送主仓库到 GitHub

4. Vercel 自动检测推送并重新构建网站

### 2. 添加图片/视频资源

添加背景图片到 `static/images/` 或视频到 `static/videos/`：

```bash

# 方法 1: 使用 push.sh (推荐，更快)

./push.sh "添加新背景图片"

  

# 方法 2: 使用 deploy.sh (也可以)

./deploy.sh

```

### 3. 修改主题

修改 `themes/Abyss/` 目录下的主题文件：

```bash

# 必须使用 deploy.sh（会自动处理 submodule）

./deploy.sh

```


**注意：** 主题是 Git submodule，deploy.sh 会自动：

- 提交主题仓库的修改

- 推送主题仓库

- 更新主仓库的 submodule 引用

### 4. 本地预览

在本地预览网站效果：

```bash

hugo server -D

# 访问 http://localhost:1313

```

## 脚本说明

### deploy.sh - 完整部署脚本

**适用场景：**

- 日常写作发布（从 Obsidian）

- 修改主题文件

- 不确定用哪个脚本时

**功能：**

- 同步 Obsidian 文章

- 自动处理主题 submodule

- 提交并推送所有修改

### push.sh - 快速推送脚本


**适用场景：**

- 添加图片/视频资源

- 修改配置文件

- 不涉及 Obsidian 和主题的快速修改

**用法：**

```bash

./push.sh # 使用默认提交信息

./push.sh "自定义提交信息" # 使用自定义提交信息

```

## 配置说明

### Hugo 配置 (hugo.toml)

关键配置项：

```toml

baseURL = "https://siyu.hcyang.us.kg/"

theme = "Abyss"

  

[params]

videoBackground = "/videos/Burn_bg.mp4"

videoOpacity = 0.6

enableVideoBackground = true

cardColumns = 2

excerptLength = 100

```

### Vercel 配置 (vercel.json)

```json

{

"build": {

"env": {

"HUGO_VERSION": "0.153.0"

}

},

"installCommand": "git submodule update --init --recursive"

}

```

  
**重要：** Vercel 会自动初始化 Git submodules 并构建 Hugo 网站。
## 重要注意事项

### 不要提交 public/ 目录

项目已配置 `.gitignore` 排除以下目录：

- `public/` - Hugo 构建输出

- `resources/_gen/` - Hugo 生成的资源

- `.hugo_build.lock` - Hugo 锁文件

  

**原因：** Vercel 会从源代码重新构建，不需要提交构建产物。

### 主题是 Git Submodule


`themes/Abyss` 是独立的 Git 仓库：

- 仓库地址: https://github.com/AbysSses/hugo_theme_abyss

- 修改主题需要两次提交（submodule + 主仓库）

- deploy.sh 会自动处理这个流程

### Obsidian 文章路径

文章源目录（在 deploy.sh 中配置）：

```bash

OBSIDIAN_POSTS="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/LifeOS/6. Website/1. hugo_siyu/posts"

```


## 故障排除

  

### 网站不显示新内容

  

1. 检查 Vercel 构建状态: https://vercel.com/dashboard

2. 清除浏览器缓存（Cmd + Shift + R）

3. 确认 Git 推送成功：`git log --oneline -3`

  

### 主题修改没有生效

  

确保使用 `deploy.sh` 而不是 `push.sh`，因为需要提交 submodule。

  

检查 submodule 状态：

```bash

git submodule status

```

  

### 图片/视频不显示

  

1. 确认文件路径正确：

- 图片: `static/images/filename.jpg`

- 访问: `/images/filename.jpg`

2. 检查文件大小（建议 < 5MB）

3. 确认文件已提交并推送

  

## 开发环境

  

- macOS (Darwin 24.5.0)

- Hugo v0.153.0+extended

- Git 2.x

- terminal-notifier (系统通知)

  

## 相关链接

  

- Hugo 官方文档: https://gohugo.io/documentation/

- Abyss 主题仓库: https://github.com/AbysSses/hugo_theme_abyss

- Vercel 文档: https://vercel.com/docs