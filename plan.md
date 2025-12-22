# Hugo Book 知识库 - Obsidian 同步方案

## 项目需求

### 核心目标

将 Obsidian 笔记自动同步到 Hugo Book 知识库网站，实现：

1. **写作流程**：在 Obsidian 中写作 → 自动同步 → 发布到网站
2. **单一来源**：Obsidian 作为唯一的内容源
3. **自动化**：一键发布，无需手动复制粘贴
4. **保持结构**：保留 Obsidian 的文件夹层级结构
5. **双向兼容**：同时在 Obsidian 和 Hugo 中正常显示

### 使用场景

- 在 Obsidian 中整理个人知识库
- 希望将部分笔记发布为在线文档
- 保持 Obsidian 的编辑体验和 Hugo 的展示效果
- 需要版本控制和自动部署

## 技术方案对比

### 方案 1：软链接（Symbolic Link）

**原理：**
在 Hugo 的 `content/docs/` 目录创建指向 Obsidian 文件夹的软链接。

**实现方式：**
```bash
ln -s "/path/to/Obsidian/vault/published" "/path/to/hugo/content/docs"
```

**优点：**
- ✅ 实时同步，无需手动操作
- ✅ Obsidian 修改立即反映到 Hugo
- ✅ 节省磁盘空间（不复制文件）
- ✅ 适合本地开发

**缺点：**
- ❌ Git 不能提交软链接指向的文件内容
- ❌ 需要在每个开发环境配置软链接
- ❌ Vercel/Netlify 等 CI/CD 平台无法使用
- ❌ 不便于版本控制

**适用场景：**
- 仅本地预览
- 不需要部署到云端

### 方案 2：rsync 同步（推荐）

**原理：**
使用 rsync 将 Obsidian 内容单向同步到 Hugo 目录，然后提交到 Git。

**实现方式：**
```bash
rsync -av --delete \
  "/path/to/Obsidian/vault/published/" \
  "/path/to/hugo/content/docs/"
```

**优点：**
- ✅ 完全支持 Git 版本控制
- ✅ 可以部署到 Vercel/Netlify
- ✅ 灵活：可以过滤文件、排除目录
- ✅ 稳定可靠，生产环境常用

**缺点：**
- ❌ 需要手动执行同步命令
- ❌ 占用双倍磁盘空间（源 + 副本）

**适用场景：**
- 需要部署到云端
- 需要版本控制
- 生产环境使用

### 方案 3：Hugo Mount（Hugo 模块挂载）

**原理：**
在 `hugo.toml` 中配置 `module.mounts`，将 Obsidian 目录挂载为 Hugo 的内容源。

**实现方式：**
```toml
[module]
  [[module.mounts]]
    source = "/absolute/path/to/Obsidian/vault/published"
    target = "content/docs"
```

**优点：**
- ✅ Hugo 原生支持
- ✅ 实时同步
- ✅ 配置简单

**缺点：**
- ❌ 不支持 Git 版本控制
- ❌ CI/CD 环境无法访问本地路径
- ❌ 需要绝对路径，不便于团队协作

**适用场景：**
- 个人本地开发
- 不需要部署到云端

### 方案 4：Git Submodule

**原理：**
将 Obsidian vault 作为 Git 仓库，通过 submodule 引入到 Hugo 项目。

**实现方式：**
```bash
git submodule add <obsidian-repo-url> content/docs
```

**优点：**
- ✅ 支持版本控制
- ✅ 可以部署到云端
- ✅ Obsidian 和 Hugo 分离管理

**缺点：**
- ❌ Obsidian vault 必须是 Git 仓库
- ❌ 需要管理两个仓库
- ❌ Submodule 同步复杂

**适用场景：**
- Obsidian vault 已经是 Git 仓库
- 需要独立管理笔记和网站

## 推荐方案：rsync 自动同步

### 方案架构

```
┌─────────────────────────────────────────────────────────────┐
│                    Obsidian Vault                           │
│  ~/Library/Mobile Documents/iCloud~md~obsidian/...         │
│                                                             │
│  LifeOS/                                                    │
│  ├── 6. Website/                                            │
│  │   └── 2. hugo_book/                  ← 内容源目录       │
│  │       ├── programming/                                   │
│  │       │   ├── python/                                    │
│  │       │   └── javascript/                                │
│  │       ├── database/                                      │
│  │       └── tools/                                         │
│  └── (其他笔记不同步)                                       │
└─────────────────────────────────────────────────────────────┘
                          │
                          │ rsync 同步
                          │ (deploy.sh 脚本)
                          ↓
┌─────────────────────────────────────────────────────────────┐
│                    Hugo Book 项目                           │
│  ~/AI/gemini_project/hugo_site/my_book/                    │
│                                                             │
│  content/docs/                           ← 同步目标目录     │
│  ├── programming/                                           │
│  │   ├── python/                                            │
│  │   └── javascript/                                        │
│  ├── database/                                              │
│  └── tools/                                                 │
└─────────────────────────────────────────────────────────────┘
                          │
                          │ Git push
                          │ (deploy.sh 脚本)
                          ↓
┌─────────────────────────────────────────────────────────────┐
│                    GitHub 仓库                              │
│  github.com/your-username/my_book                          │
└─────────────────────────────────────────────────────────────┘
                          │
                          │ 自动构建
                          │ (Vercel)
                          ↓
┌─────────────────────────────────────────────────────────────┐
│                    线上网站                                 │
│  https://book.hcyang.us.kg/                                │
└─────────────────────────────────────────────────────────────┘
```

### Obsidian 目录结构设计

#### 在 Obsidian 中创建专门的发布目录

```
Obsidian Vault (LifeOS)/
├── 1. Inbox/                    # 收集箱（不同步）
├── 2. Projects/                 # 项目（不同步）
├── 3. Areas/                    # 领域（不同步）
├── 4. Resources/                # 资源（不同步）
├── 5. Archives/                 # 归档（不同步）
└── 6. Website/                  # 网站发布专用
    ├── 1. hugo_siyu/            # 博客网站（已有）
    │   └── posts/
    └── 2. hugo_book/            # 知识库网站（新建）★
        ├── _index.md            # 首页
        ├── programming/         # 编程
        │   ├── _index.md
        │   ├── python/
        │   │   ├── _index.md
        │   │   ├── basics.md
        │   │   └── advanced.md
        │   └── javascript/
        │       ├── _index.md
        │       └── async.md
        ├── database/            # 数据库
        │   ├── _index.md
        │   ├── sql.md
        │   └── nosql.md
        ├── tools/               # 工具
        │   ├── _index.md
        │   ├── git.md
        │   └── docker.md
        └── reference/           # 参考
            ├── _index.md
            └── glossary.md
```

#### Front Matter 标准化

**Obsidian 中的 Front Matter（兼容 Hugo）：**

```markdown
---
title: "Python 基础教程"
weight: 1
bookToc: true
bookCollapseSection: false
tags:
  - python
  - 编程
  - 基础
created: 2024-12-22
updated: 2024-12-22
---

# Python 基础教程

内容...
```

**字段说明：**
- `title`：页面标题（Hugo 和 Obsidian 都显示）
- `weight`：Hugo 菜单排序权重
- `bookToc`：Hugo Book 右侧目录
- `tags`：Obsidian 标签（Hugo 也支持）
- `created/updated`：时间戳（可选）

### 部署脚本设计

#### deploy.sh 脚本

```bash
#!/bin/bash
###
# Hugo Book 知识库部署脚本
# 功能：同步 Obsidian → Hugo → GitHub → Vercel
###

export PATH="/opt/homebrew/bin:$PATH"

# ===== 配置区域 =====

# 1. Hugo Book 项目根目录
BOOK_DIR="$HOME/AI/gemini_project/hugo_site/my_book"

# 2. Obsidian 知识库源目录
OBSIDIAN_BOOK="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/LifeOS/6. Website/2. hugo_book"

# 3. Hugo 目标目录
HUGO_DOCS="$BOOK_DIR/content/docs"

# 4. 主题目录（Git submodule）
THEME_DIR="$BOOK_DIR/themes/hugo-book"

# ====================

# 进入项目目录
cd "$BOOK_DIR" || exit

# ===== 1. 同步内容 =====
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📚 同步 Obsidian 知识库到 Hugo..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 检查源目录是否存在
if [ ! -d "$OBSIDIAN_BOOK" ]; then
    echo "❌ 错误：Obsidian 源目录不存在"
    echo "   路径：$OBSIDIAN_BOOK"
    exit 1
fi

# 使用 rsync 同步
# -a: 归档模式（保留权限、时间戳等）
# -v: 显示详细过程
# --delete: 删除 Hugo 中多余的文件（保持一致）
# --exclude: 排除不需要的文件
rsync -av --delete \
    --exclude '.DS_Store' \
    --exclude '.obsidian' \
    --exclude '.trash' \
    --exclude '*.tmp' \
    "$OBSIDIAN_BOOK/" "$HUGO_DOCS/"

echo "✅ 内容同步完成"
echo ""

# ===== 2. 处理主题 Submodule =====
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎨 检查主题修改..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

cd "$THEME_DIR" || exit

if [[ -n $(git status -s) ]]; then
    echo "  → 发现主题有修改，正在提交..."
    git add . > /dev/null 2>&1
    git commit -m "Theme update: $(date '+%Y-%m-%d %H:%M:%S')" > /dev/null 2>&1
    git push origin main --quiet > /dev/null 2>&1
    echo "  ✓ 主题已更新"
else
    echo "  → 主题无变化"
fi

cd "$BOOK_DIR" || exit
echo ""

# ===== 3. 提交到 GitHub =====
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📦 提交到 GitHub..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

git add . > /dev/null 2>&1

# 检查是否有内容需要提交
if git diff-index --quiet HEAD --; then
    echo "  → 没有内容需要提交"
else
    current_time=$(date "+%Y-%m-%d %H:%M:%S")
    git commit -m "Update: $current_time" > /dev/null 2>&1
    git push origin main --quiet > /dev/null 2>&1
    echo "  ✓ 已推送到 GitHub"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ 发布完成！"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🌐 网站地址: https://book.hcyang.us.kg/"
echo "⏱️  Vercel 构建大约需要 1-2 分钟"
echo ""

# ===== 4. 系统通知（可选） =====
if command -v terminal-notifier &> /dev/null; then
    terminal-notifier \
        -message "知识库已发布，点击查看" \
        -title "Hugo Book 部署完成" \
        -open "https://book.hcyang.us.kg/"
fi
```

#### push.sh 快速推送脚本

```bash
#!/bin/bash
###
# Hugo Book 快速推送脚本
# 用途：不涉及 Obsidian 同步，仅推送本地修改
###

BRANCH=$(git symbolic-ref --short HEAD)

if [ -n "$1" ]; then
    MSG="$1"
else
    MSG="Site update: $(date "+%Y-%m-%d %H:%M:%S")"
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📦 准备推送到分支: $BRANCH"
echo "📝 提交信息: $MSG"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

git add .
git commit -m "$MSG"
git push origin "$BRANCH"

if [ $? -eq 0 ]; then
    echo "✅ 推送成功！"
    terminal-notifier \
        -message "已推送到 GitHub ($BRANCH)" \
        -title "Git Push 完成"
else
    echo "❌ 推送失败！"
    exit 1
fi
```

### 内容处理策略

#### 1. Obsidian 链接转换

**Obsidian 内部链接格式：**
```markdown
[[其他笔记]]
[[文件夹/笔记名称]]
[[笔记|显示文本]]
```

**Hugo 需要的格式：**
```markdown
[其他笔记]({{< relref "其他笔记.md" >}})
[显示文本]({{< relref "文件夹/笔记名称.md" >}})
```

**处理方案：**

选项 1：手动使用 Hugo 格式（推荐）
- 在发布目录（6. Website/2. hugo_book）中直接使用 Hugo 格式
- 优点：简单可靠
- 缺点：Obsidian 中链接不可点击

选项 2：使用脚本自动转换
- 在 deploy.sh 中添加 sed 替换
- 优点：两边都可用
- 缺点：复杂，可能有遗漏

选项 3：使用 Hugo 短代码
```markdown
{{</* ref "page.md" */>}}
```

**推荐做法：**
在 Obsidian 发布目录中直接使用相对路径：
```markdown
[Python 基础](../python/basics.md)
```

#### 2. 图片处理

**Obsidian 图片引用：**
```markdown
![[image.png]]
![描述](attachments/image.png)
```

**统一方案：**
1. 在 Obsidian vault 中创建 `attachments/` 目录
2. 配置 Obsidian 将附件保存到此目录
3. Hugo 中对应 `static/attachments/`
4. 使用标准 Markdown 语法：
```markdown
![描述](/attachments/image.png)
```

**deploy.sh 中添加图片同步：**
```bash
# 同步附件
OBSIDIAN_ATTACHMENTS="$OBSIDIAN_BOOK/../attachments"
HUGO_ATTACHMENTS="$BOOK_DIR/static/attachments"

if [ -d "$OBSIDIAN_ATTACHMENTS" ]; then
    rsync -av --delete "$OBSIDIAN_ATTACHMENTS/" "$HUGO_ATTACHMENTS/"
fi
```

#### 3. Front Matter 处理

**保持兼容性：**
```yaml
---
# Hugo 必需
title: "页面标题"
weight: 1

# Hugo Book 特定
bookToc: true
bookCollapseSection: false
bookHidden: false

# Obsidian 友好（Hugo 忽略）
tags: [tag1, tag2]
created: 2024-12-22
updated: 2024-12-22

# 可选
description: "页面描述"
---
```

## 实施步骤

### 第 1 步：在 Obsidian 中创建发布目录

```bash
# 在 Obsidian vault 中创建目录结构
cd "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/LifeOS/6. Website"
mkdir -p "2. hugo_book"
cd "2. hugo_book"

# 创建示例结构
mkdir -p programming/python
mkdir -p programming/javascript
mkdir -p database
mkdir -p tools
mkdir -p reference

# 创建 _index.md 文件
cat > _index.md << 'EOF'
---
title: "知识库首页"
type: docs
---

# 欢迎来到我的知识库

这是基于 Hugo Book 主题构建的个人知识库。
EOF

# 创建示例章节
cat > programming/_index.md << 'EOF'
---
title: "编程"
weight: 1
bookCollapseSection: false
---

# 编程

编程相关笔记。
EOF
```

### 第 2 步：配置 Obsidian 设置

在 Obsidian 中：

1. **文件与链接设置**：
   - 附件文件夹路径：`attachments`
   - 新建笔记位置：`6. Website/2. hugo_book`

2. **编辑器设置**：
   - 开启：严格换行
   - 开启：显示 Front Matter

3. **模板设置**（可选）：
   创建 Hugo 页面模板：
   ```markdown
   ---
   title: "{{title}}"
   weight: 1
   bookToc: true
   created: {{date}}
   ---

   # {{title}}

   ```

### 第 3 步：创建部署脚本

在 Hugo Book 项目根目录创建脚本：

```bash
cd /Users/hcyang/AI/gemini_project/hugo_site/my_book

# 创建 deploy.sh
touch deploy.sh
chmod +x deploy.sh

# 创建 push.sh
touch push.sh
chmod +x push.sh

# 编辑脚本内容（复制上面的脚本代码）
```

### 第 4 步：配置 .gitignore

确保不提交构建产物：

```bash
cat >> .gitignore << 'EOF'
# Hugo 构建输出
public/
resources/_gen/
.hugo_build.lock

# macOS 系统文件
.DS_Store

# 编辑器
.vscode/
.idea/
*.swp
*.swo
EOF
```

### 第 5 步：初始同步测试

```bash
cd /Users/hcyang/AI/gemini_project/hugo_site/my_book

# 执行首次同步
./deploy.sh

# 本地预览
hugo server -D
# 访问 http://localhost:1313
```

### 第 6 步：Vercel 部署配置

确保 `vercel.json` 正确配置：

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

推送到 GitHub 后，Vercel 会自动构建部署。

## 日常使用工作流

### 写作并发布

1. **在 Obsidian 中写作**
   - 打开 Obsidian
   - 在 `6. Website/2. hugo_book/` 目录下创建/编辑笔记
   - 使用标准 Markdown 语法
   - 设置 Front Matter（title、weight 等）

2. **预览（可选）**
   ```bash
   cd ~/AI/gemini_project/hugo_site/my_book
   hugo server -D
   ```

3. **发布**
   ```bash
   ./deploy.sh
   ```

4. **等待部署**
   - Vercel 自动检测推送
   - 约 1-2 分钟后访问 https://book.hcyang.us.kg/

### 仅修改配置/主题

```bash
# 不涉及 Obsidian 内容同步
cd ~/AI/gemini_project/hugo_site/my_book
./push.sh "修改主题样式"
```

## 进阶配置

### 自动化发布（可选）

#### 方案 A：使用 cron 定时任务

```bash
# 编辑 crontab
crontab -e

# 每天 23:00 自动发布
0 23 * * * cd ~/AI/gemini_project/hugo_site/my_book && ./deploy.sh >> ~/hugo_book_deploy.log 2>&1
```

#### 方案 B：使用 Hazel/Automator

在 macOS 上使用 Hazel 监控 Obsidian 目录变化，自动触发 deploy.sh。

#### 方案 C：Git hooks

在 Obsidian vault 中设置 Git hook（如果 vault 是 Git 仓库）。

### 内容过滤与转换

#### 排除草稿

在 deploy.sh 中添加：
```bash
rsync -av --delete \
    --exclude '.DS_Store' \
    --exclude '.obsidian' \
    --exclude 'drafts/' \
    --exclude '*draft*' \
    "$OBSIDIAN_BOOK/" "$HUGO_DOCS/"
```

#### 自动添加 Front Matter

对于没有 Front Matter 的文件，自动添加：
```bash
# 在 deploy.sh 中添加
for file in "$HUGO_DOCS"/**/*.md; do
    if ! grep -q "^---$" "$file"; then
        filename=$(basename "$file" .md)
        sed -i '' "1i\\
---\\
title: \"$filename\"\\
weight: 1\\
---\\
" "$file"
    fi
done
```

### 链接自动转换脚本

```bash
# 转换 Obsidian 链接为 Hugo 链接
convert_links() {
    local file="$1"
    # [[link]] → [link]({{< relref "link.md" >}})
    sed -i '' -E 's/\[\[([^|\]]+)\]\]/[\1]({{< relref "\1.md" >}})/g' "$file"
    # [[link|text]] → [text]({{< relref "link.md" >}})
    sed -i '' -E 's/\[\[([^|\]]+)\|([^\]]+)\]\]/[\2]({{< relref "\1.md" >}})/g' "$file"
}

# 在 deploy.sh 中应用
find "$HUGO_DOCS" -name "*.md" -exec bash -c 'convert_links "$0"' {} \;
```

## 故障排除

### 内容不同步

检查：
```bash
# 验证源目录
ls "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/LifeOS/6. Website/2. hugo_book"

# 验证目标目录
ls ~/AI/gemini_project/hugo_site/my_book/content/docs

# 手动测试 rsync
rsync -avn --delete \
    "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/LifeOS/6. Website/2. hugo_book/" \
    ~/AI/gemini_project/hugo_site/my_book/content/docs/
```

### 图片不显示

确保：
1. 图片在 `static/attachments/` 目录
2. 使用绝对路径：`/attachments/image.png`
3. 文件名不含中文或特殊字符

### 菜单结构混乱

检查：
1. 每个目录都有 `_index.md`
2. Front Matter 中 `weight` 设置正确
3. `title` 参数存在

### Vercel 构建失败

查看 Vercel 日志，常见问题：
1. Hugo 版本不匹配
2. Git submodule 未初始化
3. 缺少必需的文件

## 总结

### 推荐方案

**✅ 使用 rsync + deploy.sh 脚本**

- 在 Obsidian 中创建专门的发布目录
- 使用部署脚本自动同步到 Hugo
- 提交到 Git，由 Vercel 自动构建
- 简单可靠，适合生产环境

### 关键要点

1. **单一来源**：Obsidian 是唯一的内容编辑位置
2. **自动化**：一键发布，无需手动操作
3. **兼容性**：Front Matter 同时兼容 Obsidian 和 Hugo
4. **结构化**：使用 `_index.md` 组织层级结构
5. **版本控制**：所有内容纳入 Git 管理

### 文件清单

需要创建的文件：
- ✅ `deploy.sh` - 部署脚本
- ✅ `push.sh` - 快速推送脚本
- ✅ `.gitignore` - Git 忽略配置
- ✅ `vercel.json` - Vercel 构建配置

需要在 Obsidian 中创建：
- 📁 `6. Website/2. hugo_book/` - 发布目录
- 📄 各层级的 `_index.md` 文件
- 📝 具体的内容页面

### 下一步

1. 在 Obsidian 中创建发布目录结构
2. 创建并测试 deploy.sh 脚本
3. 编写第一篇测试文章
4. 本地预览确认效果
5. 执行 deploy.sh 发布到线上
6. 验证网站显示正常

---

**项目架构总结**

```
Obsidian (写作)
      ↓
   rsync 同步 (deploy.sh)
      ↓
Hugo Book (本地)
      ↓
   Git Push (deploy.sh)
      ↓
  GitHub 仓库
      ↓
Vercel 自动构建
      ↓
   线上网站
```
