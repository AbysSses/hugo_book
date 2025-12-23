---

title: "Abyss"

layout: landing

---

  

<style>

:root {

--cold-bg: #121722; /* 偏暖深色背景基色 */

--cold-overlay-start: rgba(18, 22, 34, 0.7); /* 背景叠层起始色 */

--cold-overlay-mid: rgba(24, 28, 40, 0.55); /* 背景叠层中间色 */

--cold-overlay-end: rgba(36, 32, 40, 0.35); /* 背景叠层结束色 */

--cold-text: #f1ebe4; /* 主文本色 */

--cold-text-soft: #d7cfc4; /* 次级文本色 */

--cold-text-dim: #b8ad9f; /* 弱强调文字色 */

--cold-accent: #ffb86b; /* 暖色强调色 */

--cold-accent-soft: rgba(255, 184, 107, 0.24); /* 强调色柔光 */

--cold-card: rgba(255, 255, 255, 0.06); /* 玻璃卡片底色（更通透） */

--cold-card-strong: rgba(20, 22, 26, 0.7); /* 主内容底色（非毛玻璃） */

--cold-border: rgba(255, 255, 255, 0.14); /* 玻璃描边 */

--cold-border-hover: rgba(255, 209, 158, 0.25); /* 悬停描边 */

--cold-card-overlay: rgba(255, 188, 130, 0.12); /* 悬停叠层起色 */

--cold-card-overlay-mid: rgba(255, 188, 130, 0.04); /* 悬停叠层中间色 */

--cold-card-shadow: rgba(255, 188, 130, 0.12); /* 悬停阴影色 */

--cold-shadow-lg: 0 24px 60px rgba(0, 0, 0, 0.32); /* 大阴影 */

--cold-shadow-sm: 0 10px 24px rgba(0, 0, 0, 0.18); /* 小阴影 */

--radius-lg: 28px; /* 大圆角 */

--radius-md: 20px; /* 中圆角 */

--blur-hero: 18px; /* Hero 玻璃模糊 */

--blur-card: 14px; /* 卡片玻璃模糊 */

}

  

body {

background: var(--cold-bg); /* 页面背景色 */

}

  

/* 页面整体容器 */

.abyss-home {

position: relative; /* 建立定位上下文 */

min-height: 100vh; /* 至少铺满视口 */

color: var(--cold-text); /* 默认文本色 */

font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", "Segoe UI", sans-serif; /* 字体 */

}

  

/* 背景视频 */

.abyss-video {

position: fixed; /* 固定在视口 */

inset: 0; /* 全屏铺满 */

width: 100%; /* 宽度 */

height: 100%; /* 高度 */

object-fit: cover; /* 裁切填满 */

opacity: 0.7; /* 视频透明度 */

z-index: 0; /* 背景层级 */

}

  

/* 背景叠层 */

.abyss-overlay {

position: fixed; /* 固定在视口 */

inset: 0; /* 全屏铺满 */

background: linear-gradient(135deg, var(--cold-overlay-start), var(--cold-overlay-mid), var(--cold-overlay-end)); /* 冷色渐变 */

z-index: 1; /* 位于视频上 */

pointer-events: none; /* 不阻挡交互 */

}

  

/* 页面内容层 */

.abyss-page {

position: relative; /* 内容层定位 */

z-index: 2; /* 高于背景 */

padding: 4rem 1.5rem 5rem; /* 页面留白 */

}

  

/* 容器宽度 */

.abyss-container {

max-width: 1120px; /* 最大宽度 */

margin: 0 auto; /* 水平居中 */

}

  

/* Hero 区域 */

.abyss-hero {

margin-bottom: 3.5rem; /* 底部间距 */

}

  

/* Hero 毛玻璃卡片 */

.abyss-hero-card {

border-radius: var(--radius-lg); /* 圆角 */

padding: 3.5rem 3rem; /* 内边距 */

border: 1px solid var(--cold-border); /* 描边 */

background: var(--cold-card-strong); /* 玻璃底色 */

box-shadow: var(--cold-shadow-lg); /* 阴影 */

text-align: center; /* 文本居中 */

}

  

/* Hero 标识 */

.abyss-kicker {

display: inline-block; /* 行内块 */

font-size: 0.8rem; /* 字号 */

letter-spacing: 0.18em; /* 字距 */

text-transform: uppercase; /* 大写 */

color: var(--cold-text-dim); /* 文字颜色 */

margin-bottom: 1rem; /* 下边距 */

}

  

/* Hero 标题 */

.abyss-title {

font-size: 3.2rem; /* 标题字号 */

line-height: 1.1; /* 行高 */

font-weight: 700; /* 字重 */

letter-spacing: -0.02em; /* 字距 */

margin: 0 0 1rem; /* 外边距 */

}

  

/* Hero 副标题 */

.abyss-subtitle {

font-size: 1.25rem; /* 副标题字号 */

line-height: 1.6; /* 行高 */

color: var(--cold-text-soft); /* 文字颜色 */

margin: 0 auto 2.2rem; /* 外边距 */

max-width: 720px; /* 最大宽度 */

}

  

/* 头像与徽章区域 */

.abyss-hero-meta {

display: flex; /* 弹性布局 */

flex-direction: row; /* 横向排列 */

align-items: center; /* 垂直居中 */

justify-content: center; /* 水平居中 */

gap: 1.5rem; /* 间距 */

margin-bottom: 2.2rem; /* 下边距 */

}

  

/* 头像 */

.abyss-avatar {

width: 140px; /* 头像宽度 */

height: 140px; /* 头像高度 */

border-radius: 50%; /* 圆形 */

border: 1px solid rgba(255, 255, 255, 0.4); /* 描边 */

object-fit: cover; /* 图片裁切 */

box-shadow: var(--cold-shadow-sm); /* 阴影 */

}

  

/* 徽章容器 */

.abyss-badges {

display: flex; /* 弹性布局 */

flex-wrap: wrap; /* 自动换行 */

gap: 0.6rem; /* 徽章间距 */

justify-content: center; /* 居中 */

}

  

/* 徽章 */

.abyss-badge {

padding: 0.4rem 0.9rem; /* 内边距 */

border-radius: 999px; /* 胶囊圆角 */

font-size: 0.9rem; /* 字号 */

color: var(--cold-text); /* 文字颜色 */

background: rgba(255, 255, 255, 0.14); /* 背景色 */

border: 1px solid rgba(255, 255, 255, 0.25); /* 边框 */

}

  

/* 按钮区域 */

.abyss-actions {

display: flex; /* 弹性布局 */

justify-content: center; /* 居中 */

gap: 1rem; /* 间距 */

flex-wrap: wrap; /* 小屏换行 */

}

  

.abyss-sound {

position: fixed; /* 固定在视口 */

right: 1.5rem; /* 右侧间距 */

bottom: 1.5rem; /* 下方间距 */

z-index: 3; /* 覆盖内容 */

}

  

.abyss-sound button {

width: 46px; /* 按钮宽度 */

height: 46px; /* 按钮高度 */

border-radius: 50%; /* 圆形 */

border: 1px solid rgba(255, 255, 255, 0.35); /* 边框 */

background: rgba(255, 255, 255, 0.08); /* 背景 */

color: var(--cold-text); /* 文字颜色 */

font-size: 1.1rem; /* 图标大小 */

display: inline-flex; /* 居中 */

align-items: center; /* 垂直居中 */

justify-content: center; /* 水平居中 */

cursor: pointer; /* 鼠标指针 */

transition: background 0.2s ease, transform 0.2s ease; /* 过渡 */

}

  

.abyss-sound button svg {

width: 20px; /* 图标宽度 */

height: 20px; /* 图标高度 */

display: block; /* 去掉行内空隙 */

fill: currentColor; /* 使用按钮文字颜色 */

}

  

.abyss-sound button:hover {

transform: translateY(-1px); /* 悬停抬起 */

background: rgba(255, 255, 255, 0.16); /* 悬停背景 */

}

/* 按钮 */

.abyss-actions a {

text-decoration: none; /* 去下划线 */

padding: 0.8rem 2rem; /* 内边距 */

border-radius: 999px; /* 胶囊圆角 */

font-weight: 600; /* 字重 */

font-size: 1rem; /* 字号 */

border: 1px solid rgba(255, 255, 255, 0.3); /* 边框 */

color: var(--cold-text) !important; /* 文字颜色 */

background: rgba(255, 255, 255, 0.08); /* 背景色 */

text-shadow: none !important; /* 去掉主题默认文本阴影 */

filter: none !important; /* 防止字体滤镜偏色 */

mix-blend-mode: normal; /* 禁止混合模式 */

transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease; /* 过渡动画 */

}

  

/* 主按钮 */

.abyss-actions a.is-primary {

background: rgba(106, 169, 255, 0.25); /* 主按钮底色 */

border-color: rgba(106, 169, 255, 0.45); /* 主按钮描边 */

box-shadow: 0 14px 30px rgba(80, 140, 220, 0.25); /* 主按钮阴影 */

color: #f5f5f5 !important; /* 主按钮文字 */

}

  

/* 按钮悬停 */

.abyss-actions a:hover {

transform: translateY(-2px); /* 上浮 */

background: rgba(255, 255, 255, 0.16); /* 悬停背景 */

}

  

/* 区块标题 */

.abyss-section-title {

font-size: 1.6rem; /* 标题字号 */

margin: 2.5rem 0 0.6rem; /* 外边距 */

text-align: center; /* 居中 */

}

  

/* 区块副标题 */

.abyss-section-subtitle {

text-align: center; /* 居中 */

color: var(--cold-text-soft); /* 文字颜色 */

margin-bottom: 2.4rem; /* 下边距 */

}

  

/* Bento Grid */

.abyss-grid {

display: grid; /* 网格布局 */

grid-template-columns: repeat(12, minmax(0, 1fr)); /* 12 栅格 */

gap: 1.4rem; /* 栅格间距 */

}

  

/* Bento 卡片 */

.abyss-card {

grid-column: span 4; /* 默认占 4 列 */

border-radius: var(--radius-md); /* 圆角 */

padding: 2rem; /* 内边距 */

border: 1px solid var(--cold-border); /* 边框 */

background: linear-gradient(135deg, rgba(255, 255, 255, 0.08), rgba(255, 255, 255, 0.02)); /* 卡片底色 */

backdrop-filter: blur(var(--blur-card)) saturate(140%); /* 毛玻璃 */

-webkit-backdrop-filter: blur(var(--blur-card)) saturate(140%); /* Safari 兼容 */

box-shadow: var(--cold-shadow-sm); /* 阴影 */

display: flex; /* 弹性布局 */

flex-direction: column; /* 纵向排列 */

gap: 0.75rem; /* 内容间距 */

min-height: 220px; /* 最小高度 */

transition: transform 0.35s ease, box-shadow 0.35s ease, border-color 0.35s ease; /* 动效 */

position: relative; /* 供叠层定位 */

overflow: hidden; /* 裁切叠层 */

}

  

/* Bento 宽卡片 */

.abyss-card.wide {

grid-column: span 7; /* 占 7 列 */

}

  

/* Bento 高卡片 */

.abyss-card.tall {

grid-column: span 5; /* 占 5 列 */

}

  

/* Bento 悬停 */

.abyss-card::before {

content: ""; /* 悬停叠层 */

position: absolute; /* 绝对定位 */

inset: 0; /* 覆盖卡片 */

background: linear-gradient(135deg, var(--cold-card-overlay), var(--cold-card-overlay-mid)); /* 悬停光效 */

opacity: 0; /* 默认隐藏 */

transition: opacity 0.35s ease; /* 渐显 */

border-radius: var(--radius-md); /* 圆角 */

pointer-events: none; /* 不影响交互 */

}

  

.abyss-card:hover {

transform: translateY(-8px) scale(1.02); /* 悬停抬起 */

border-color: var(--cold-border-hover); /* 悬停描边 */

box-shadow: 0 25px 50px var(--cold-card-shadow); /* 悬停阴影 */

}

  

.abyss-card:hover::before {

opacity: 1; /* 悬停显示叠层 */

}

  

/* 卡片图标 */

.abyss-card-icon {

font-size: 1.9rem; /* 图标字号 */

}

  

/* 卡片标题 */

.abyss-card-title {

font-size: 1.25rem; /* 标题字号 */

font-weight: 600; /* 字重 */

}

  

/* 卡片正文 */

.abyss-card-text {

color: var(--cold-text-soft); /* 正文颜色 */

line-height: 1.6; /* 行高 */

}

  

/* 页脚文案 */

.abyss-footer {

text-align: center; /* 居中 */

color: var(--cold-text-dim); /* 文字颜色 */

margin-top: 3rem; /* 上边距 */

font-size: 0.95rem; /* 字号 */

}

  

@media (max-width: 960px) {

.abyss-hero-card {

padding: 3rem 2.2rem; /* 缩小内边距 */

}

.abyss-title {

font-size: 2.6rem; /* 缩小标题 */

}

.abyss-hero-meta {

flex-direction: column; /* 头像与徽章改为竖排 */

}

.abyss-grid {

grid-template-columns: repeat(6, minmax(0, 1fr)); /* 6 栅格 */

}

.abyss-card,

.abyss-card.wide,

.abyss-card.tall {

grid-column: span 6; /* 卡片占满一行 */

}

}

  

@media (max-width: 640px) {

.abyss-page {

padding: 3rem 1rem 4rem; /* 缩小页面留白 */

}

.abyss-hero-card {

padding: 2.5rem 1.6rem; /* 缩小内边距 */

}

.abyss-title {

font-size: 2.1rem; /* 缩小标题 */

}

.abyss-subtitle {

font-size: 1.05rem; /* 缩小副标题 */

}

.abyss-avatar {

width: 120px; /* 缩小头像 */

height: 120px; /* 缩小头像 */

}

.abyss-grid {

grid-template-columns: 1fr; /* 单列布局 */

}

.abyss-card,

.abyss-card.wide,

.abyss-card.tall {

grid-column: span 1; /* 单列占满 */

}

}

</style>

  

{{< html >}}

<div class="abyss-home">

<video class="abyss-video" id="bg-video" autoplay loop playsinline>

<source src="/bg.mp4" type="video/mp4">

</video>

<div class="abyss-overlay"></div>

  

<div class="abyss-page">

<section class="abyss-hero">

<div class="abyss-container">

<div class="abyss-hero-card">

<span class="abyss-kicker">Abyss Knowledge Base</span>

<h1 class="abyss-title">Calm. Clear. Connected.</h1>

<p class="abyss-subtitle">Bioinformatics experiments, systems thinking, and digital gardening — distilled.</p>

  

<div class="abyss-hero-meta">

<img src="/avatar.jpg" alt="Avatar" class="abyss-avatar">

<div class="abyss-badges">

<span class="abyss-badge">Focus · Thesis Writing</span>

<span class="abyss-badge">Stack · R · Python · Hugo</span>

</div>

</div>

  

<div class="abyss-actions">

<a class="is-primary" href="/posts">Read the Blog</a>

<a href="https://github.com/AbysSses">GitHub</a>

</div>

  

<div class="abyss-sound">

<button type="button" id="sound-toggle" aria-label="开启声音"></button>

</div>

</div>

</div>

</section>

  

<section>

<div class="abyss-container">

<h2 class="abyss-section-title">What lives here</h2>

<p class="abyss-section-subtitle">A mix of ongoing research, systems, and reflections.</p>

  

<div class="abyss-grid">

<article class="abyss-card wide">

<div class="abyss-card-icon">🌱</div>

<div class="abyss-card-title">Digital Garden</div>

<p class="abyss-card-text">Living notes with rough edges, evolving ideas, and visible learning.</p>

</article>

  

<article class="abyss-card tall">

<div class="abyss-card-icon">🧬</div>

<div class="abyss-card-title">Bioinformatics</div>

<p class="abyss-card-text">Single-cell pipelines, Linux workflows, and reproducible research practice.</p>

</article>

  

<article class="abyss-card">

<div class="abyss-card-icon">⚙️</div>

<div class="abyss-card-title">Systems</div>

<p class="abyss-card-text">Obsidian setups, automation scripts, and productivity experiments.</p>

</article>

  

<article class="abyss-card">

<div class="abyss-card-icon">📚</div>

<div class="abyss-card-title">Reflections</div>

<p class="abyss-card-text">Books, films, and small sparks worth keeping.</p>

</article>

  

<article class="abyss-card">

<div class="abyss-card-icon">🚀</div>

<div class="abyss-card-title">Build in Public</div>

<p class="abyss-card-text">Sharing the process, including failures and half-formed ideas.</p>

</article>

</div>

</div>

</section>

  

<p class="abyss-footer">Designed for clarity, built for iteration.</p>

</div>

</div>

  

<script>

const video = document.getElementById('bg-video');

const toggle = document.getElementById('sound-toggle');

const iconOn = '<svg viewBox="0 0 1024 1024" aria-hidden="true"><path d="M468.992 169.6c29.312-22.528 64.128-40.832 101.312-25.088 36.864 15.552 48.64 53.12 53.76 89.984 5.248 37.824 5.248 89.92 5.248 154.688V634.88c0 64.768 0 116.864-5.184 154.688-5.12 36.928-16.96 74.432-53.76 89.984-37.248 15.744-72.064-2.56-101.376-25.024-30.016-23.04-66.112-59.904-110.912-105.6l-1.92-2.048c-23.04-23.488-38.336-34.88-53.76-41.28-15.616-6.4-34.496-9.152-67.456-9.152h-1.664c-28.544 0-52.416 0-71.68-1.984-20.288-2.112-39.104-6.72-56.064-18.24-32.192-22.016-44.544-54.208-49.28-83.84C52.864 570.24 53.248 545.92 53.568 526.464a907.84 907.84 0 0 0 0-28.928C53.184 478.08 52.864 453.76 56.32 431.68c4.672-29.568 17.024-61.824 49.28-83.84 16.896-11.52 35.712-16.128 55.936-18.176a750.72 750.72 0 0 1 71.68-2.048h1.728c32.96 0 51.84-2.688 67.392-9.152 15.488-6.4 30.72-17.728 53.76-41.216l1.984-2.048c44.8-45.76 80.896-82.56 110.912-105.6z m38.976 50.752c-25.92 19.84-58.88 53.44-106.112 101.632-25.152 25.6-47.616 44.288-75.072 55.68-27.328 11.264-56.32 13.952-91.84 13.952-30.656 0-51.2 0-66.752 1.664-15.04 1.6-21.952 4.352-26.56 7.488-12.416 8.448-19.008 21.184-22.144 40.96-2.56 16-2.24 32.512-1.92 51.136l0.128 19.2c0 6.592-0.064 12.992-0.192 19.136-0.256 18.56-0.512 35.072 1.984 51.136 3.136 19.712 9.728 32.512 22.144 40.96 4.608 3.136 11.52 5.888 26.56 7.424 15.616 1.6 36.096 1.664 66.752 1.664 35.456 0 64.512 2.688 91.84 14.016 27.456 11.328 49.92 29.952 75.072 55.616 47.232 48.192 80.192 81.728 106.112 101.696 27.008 20.736 35.136 17.856 37.44 16.832 2.624-1.088 10.56-5.44 15.296-39.808 4.544-32.896 4.608-80.512 4.608-148.672V391.936c0-68.096 0-115.712-4.608-148.608-4.736-34.368-12.672-38.784-15.36-39.872-2.24-0.96-10.368-3.84-37.376 16.896zM705.92 358.592a32 32 0 0 1 44.864 6.016c30.912 40.448 49.28 91.776 49.28 147.392s-18.368 106.88-49.28 147.392a32 32 0 1 1-50.88-38.784A178.56 178.56 0 0 0 736 512a178.56 178.56 0 0 0-36.096-108.608 32 32 0 0 1 6.016-44.8zM876.928 277.056a32 32 0 0 0-47.168 43.2c48.448 52.992 76.928 119.68 76.928 191.744s-28.48 138.752-76.928 191.68a32 32 0 0 0 47.168 43.264c58.24-63.616 93.76-145.408 93.76-234.944 0-89.6-35.52-171.328-93.76-234.944z"/></svg>';

const iconOff = '<svg viewBox="0 0 1024 1024" aria-hidden="true"><path d="M62.72 62.72a32 32 0 0 1 45.248 0l252.032 252.032c1.472 1.216 2.816 2.56 4.096 4.096l597.184 597.184a32 32 0 1 1-45.248 45.248l-286.72-286.72c-0.192 46.592-1.088 85.184-5.184 114.944-5.12 36.928-16.96 74.432-53.76 89.984-37.184 15.744-72.064-2.56-101.376-25.024-29.952-23.04-66.112-59.904-110.912-105.6l-1.92-2.048c-23.04-23.488-38.336-34.88-53.76-41.28-15.552-6.4-34.496-9.152-67.456-9.152h-1.664c-28.544 0-52.352 0-71.68-1.984-20.288-2.112-39.04-6.72-56-18.24-32.256-22.016-44.608-54.208-49.28-83.84C52.8 570.24 53.248 545.984 53.568 526.464a908.032 908.032 0 0 0 0-28.928C53.248 478.08 52.8 453.76 56.32 431.68c4.672-29.568 17.024-61.824 49.28-83.84 16.896-11.52 35.712-16.064 56-18.176 19.328-2.048 43.136-2.048 71.68-2.048h1.664c6.208 0 11.84 0.128 17.152 0.192 11.136 0.192 20.544 0.32 30.016-0.448L62.72 107.968a32 32 0 0 1 0-45.248z m230.528 327.872a369.088 369.088 0 0 1-45.824 1.216l-12.48-0.192c-30.592 0-51.136 0.064-66.752 1.664-15.04 1.6-21.952 4.352-26.56 7.488-12.416 8.448-19.008 21.248-22.08 40.96-2.56 16-2.304 32.512-2.048 51.136a1252.864 1252.864 0 0 1 0 38.336c-0.256 18.56-0.512 35.072 2.048 51.2 3.072 19.648 9.664 32.448 22.08 40.896 4.608 3.136 11.52 5.888 26.56 7.424 15.616 1.6 36.16 1.664 66.752 1.664 35.52 0 64.576 2.752 91.904 14.016 27.392 11.328 49.92 30.016 75.008 55.68 47.232 48.128 80.192 81.728 106.112 101.632 27.008 20.736 35.136 17.856 37.44 16.896 2.624-1.152 10.56-5.504 15.36-39.872 4.48-32.896 4.608-80.512 4.608-148.672V610.56L334.464 379.776a136.128 136.128 0 0 1-41.216 10.816zM449.28 278.4c30.72-30.592 53.632-52.288 72.064-65.088a66.56 66.56 0 0 1 19.328-10.112c3.2-0.896 4.288-0.384 4.672-0.256 2.688 1.152 10.624 5.568 15.36 40 4.544 32.96 4.608 80.704 4.608 148.992v13.44a32 32 0 1 0 64 0V389.12c0-64.896 0-117.12-5.184-155.008-5.12-36.928-16.96-74.56-53.76-90.112-31.808-13.504-62.144 0.512-85.376 16.64-24.064 16.576-51.008 42.624-80.896 72.32a32 32 0 0 0 45.12 45.44zM705.024 401.92a32 32 0 0 1 45.056 4.48c31.104 37.888 49.92 84.992 49.92 136.32 0 22.4-3.584 44.032-10.24 64.512a32 32 0 0 1-60.864-19.84c4.608-14.208 7.104-29.184 7.104-44.672 0-35.2-12.8-68.224-35.392-95.744a32 32 0 0 1 4.48-45.056zM875.776 318.528a32 32 0 0 0-44.864 45.632c48.192 47.36 75.776 106.304 75.776 169.216 0 52.288-19.072 101.76-53.12 144.128a32 32 0 0 0 49.92 40.064c42.112-52.48 67.2-115.712 67.2-184.192 0-82.624-36.416-157.312-94.912-214.848z"/></svg>';

  

if (video && toggle) {

video.muted = false;

video.volume = 0.7;

video.play().catch(() => {

video.muted = true;

toggle.setAttribute('aria-label', '开启声音');

});

toggle.innerHTML = iconOff;

toggle.addEventListener('click', () => {

const muted = video.muted;

video.muted = !muted;

toggle.innerHTML = video.muted ? iconOff : iconOn;

toggle.setAttribute('aria-label', video.muted ? '开启声音' : '关闭声音');

if (!video.muted) {

video.volume = 0.7;

}

});

}

</script>

{{< /html >}}