#!/bin/bash
###
# @Author: hcYang
# @Date: 2024-12-22
# @Description: Hugo Book 快速推送脚本
# 用途：不涉及 Obsidian 同步，仅推送本地修改
# 使用：./push.sh "提交信息"
###

export PATH="/opt/homebrew/bin:$PATH"

# 获取当前 Git 分支名称
BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || echo "main")

# 提交信息
if [ -n "$1" ]; then
    MSG="$1"
else
    MSG="Site update: $(date "+%Y-%m-%d %H:%M:%S")"
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📦 准备推送到分支: $BRANCH"
echo "📝 提交信息: $MSG"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Git 操作
git add .

# 检查是否有内容需要提交
if git diff-index --quiet HEAD -- 2>/dev/null; then
    echo "  → 没有内容需要提交"
    echo ""
    exit 0
fi

git commit -m "$MSG"

echo ""
echo "🚀 正在推送到 GitHub..."
git push origin "$BRANCH" --quiet

# 检查推送结果
if [ $? -eq 0 ]; then
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "✅ 推送成功！"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "🌐 网站地址: https://book.hcyang.us.kg/"
    echo "⏱️  Vercel 构建大约需要 1-2 分钟"
    echo ""

    # 系统通知（可选）
    if command -v terminal-notifier &> /dev/null; then
        terminal-notifier \
            -message "已推送到 GitHub ($BRANCH)" \
            -title "Git Push 完成" \
            2>/dev/null
    fi
else
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "❌ 推送失败！"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "请检查："
    echo "  1. 网络连接是否正常"
    echo "  2. Git 权限是否配置正确"
    echo "  3. 远程仓库是否存在"
    echo ""

    # 失败通知
    if command -v terminal-notifier &> /dev/null; then
        terminal-notifier \
            -message "推送失败，请检查终端报错" \
            -title "Git Error" \
            2>/dev/null
    fi

    exit 1
fi
