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
OBSIDIAN_CONTENT="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/LifeOS/6. Website/2.hugo_books"

# 3. Hugo 目标目录
HUGO_CONTENT="$BOOK_DIR/content"

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

# 检查源目录是否存在
if [ ! -d "$OBSIDIAN_CONTENT" ]; then
    echo "⚠️  警告：Obsidian 源目录不存在"
    echo "   路径：$OBSIDIAN_CONTENT"
    echo "   跳过内容同步，仅推送本地修改..."
    echo ""
else
    echo "📖 同步内容 (content)..."
    echo "  源目录: $OBSIDIAN_CONTENT"
    echo "  目标目录: $HUGO_CONTENT"
    echo ""

    # 同步整个 content 目录
    rsync -a --delete \
        --exclude '.DS_Store' \
        --exclude '.obsidian' \
        --exclude '.trash' \
        --exclude '*.tmp' \
        --exclude 'drafts/' \
        --exclude '_index.md' \
        "$OBSIDIAN_CONTENT/" "$HUGO_CONTENT/" > /dev/null 2>&1

    echo "  ✓ 内容同步完成"
    echo ""

    # 同步附件（如果存在）
    if [ -d "$OBSIDIAN_ATTACHMENTS" ]; then
        echo "🖼️  同步附件..."
        mkdir -p "$HUGO_ATTACHMENTS"
        rsync -a --delete \
            --exclude '.DS_Store' \
            "$OBSIDIAN_ATTACHMENTS/" "$HUGO_ATTACHMENTS/" > /dev/null 2>&1
        echo "  ✓ 附件同步完成"
    fi
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
