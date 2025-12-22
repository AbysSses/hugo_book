#!/bin/bash
###
# @Author: hcYang
# @Date: 2024-12-22
# @Description: Hugo Book 知识库部署脚本
# 功能：同步 Obsidian → Hugo → GitHub → Vercel
###

export PATH="/opt/homebrew/bin:$PATH"

# ===== 配置区域 =====

# 1. Hugo Book 项目根目录
BOOK_DIR="$HOME/AI/gemini_project/hugo_site/my_book"

# 2. Obsidian 知识库源目录
OBSIDIAN_BASE="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/LifeOS/6. Website/2.hugo_books"
OBSIDIAN_DOCS="$OBSIDIAN_BASE/docs"
OBSIDIAN_POSTS="$OBSIDIAN_BASE/posts"

# 3. Hugo 目标目录
HUGO_DOCS="$BOOK_DIR/content/docs"
HUGO_POSTS="$BOOK_DIR/content/posts"

# 4. 主题目录（Git submodule）
THEME_DIR="$BOOK_DIR/themes/hugo-book"

# 5. 附件同步（可选）
OBSIDIAN_ATTACHMENTS="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/LifeOS/6. Website/attachments"
HUGO_ATTACHMENTS="$BOOK_DIR/static/attachments"

# ====================

# 进入项目目录
cd "$BOOK_DIR" || exit

# ===== 1. 同步内容 =====
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📚 同步 Obsidian 内容到 Hugo..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 1.1 同步文档（docs）
if [ ! -d "$OBSIDIAN_DOCS" ]; then
    echo "⚠️  警告：Obsidian 文档目录不存在"
    echo "   路径：$OBSIDIAN_DOCS"
    echo "   跳过文档同步..."
else
    echo "📖 同步文档 (docs)..."
    echo "  源目录: $OBSIDIAN_DOCS"
    echo "  目标目录: $HUGO_DOCS"

    rsync -a --delete \
        --exclude '.DS_Store' \
        --exclude '.obsidian' \
        --exclude '.trash' \
        --exclude '*.tmp' \
        --exclude 'drafts/' \
        "$OBSIDIAN_DOCS/" "$HUGO_DOCS/" > /dev/null 2>&1

    echo "  ✓ 文档同步完成"
fi

echo ""

# 1.2 同步博客文章（posts）
if [ ! -d "$OBSIDIAN_POSTS" ]; then
    echo "⚠️  警告：Obsidian 博客目录不存在"
    echo "   路径：$OBSIDIAN_POSTS"
    echo "   跳过博客同步..."
else
    echo "📝 同步博客文章 (posts)..."
    echo "  源目录: $OBSIDIAN_POSTS"
    echo "  目标目录: $HUGO_POSTS"

    mkdir -p "$HUGO_POSTS"
    rsync -a --delete \
        --exclude '.DS_Store' \
        --exclude '.obsidian' \
        --exclude '.trash' \
        --exclude '*.tmp' \
        --exclude 'drafts/' \
        "$OBSIDIAN_POSTS/" "$HUGO_POSTS/" > /dev/null 2>&1

    echo "  ✓ 博客同步完成"
fi

echo ""

# 1.3 同步附件（如果存在）
if [ -d "$OBSIDIAN_ATTACHMENTS" ]; then
    echo "🖼️  同步附件..."
    mkdir -p "$HUGO_ATTACHMENTS"
    rsync -a --delete \
        --exclude '.DS_Store' \
        "$OBSIDIAN_ATTACHMENTS/" "$HUGO_ATTACHMENTS/" > /dev/null 2>&1
    echo "  ✓ 附件同步完成"
fi

echo ""

# ===== 2. 处理主题 Submodule =====
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎨 检查主题修改..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ -d "$THEME_DIR/.git" ]; then
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
else
    echo "  → 主题不是 Git 仓库，跳过"
fi

echo ""

# ===== 3. 提交到 GitHub =====
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📦 提交到 GitHub..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

git add . > /dev/null 2>&1

# 检查是否有内容需要提交
if git diff-index --quiet HEAD -- 2>/dev/null; then
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
        -open "https://book.hcyang.us.kg/" \
        2>/dev/null
fi
