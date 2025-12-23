---
title: obsidian和hugo联用----Vercel 云端构建的自动化流程
date: 2025-12-20 15:31:42
draft: false
tags:
  - tutorial
LastMod: 2025-12-23 11:19:06
---
在 Mac 上我们通常使用 **Homebrew**（包管理器）来一键安装。

以下是在 Mac 上从零开始部署 Hugo 的完整步骤：

### 第一步：安装 Hugo (使用 Homebrew)

1. 打开你的 **终端 (Terminal)**（按 `Command + Space`，输入 "Terminal" 回车）。
    
2. 输入以下命令并回车（假设你已经安装了 Homebrew，如果没有，请告诉我）：
    
    Bash
    
    ```
    brew install hugo
    ```
    
3. 安装完成后，验证是否成功：
    
    Bash
    
    ```
    hugo version
    ```
    
    _如果你看到类似 `hugo v0.120.0-extended darwin/arm64` 的输出，说明安装成功了。（注意：最好是 **extended** 版本，因为很多漂亮的主题需要它来处理 CSS，Homebrew 默认通常就是安装这个版本）。_
    

---

### 第二步：创建你的博客站点

找一个你想存放博客代码的文件夹（比如 `/Users/hcyang/AI/gemini_project/hugo_site/`），在终端里进入该目录，然后运行：

Bash

```
hugo new site my_book
```

这会生成一个名为 `my_book` 的文件夹，里面就是 Hugo 的标准骨架。

---

### 第三步：安装一个主题 (必做)

Hugo 默认是“裸奔”的，必须有了主题才能显示内容。我们以最经典的 `PaperMod` 主题为例：

1. 进入博客目录：
    
    Bash
    
    ```
    cd my-blog
    ```
    
2. 初始化 Git（这是为了方便后续管理主题）：
    
    Bash
    
    ```
    git init
    ```
    
1. 添加 Hugo-Book 主题 (必须作为 submodule 添加，否则 Vercel 拉取会报错) 
    
    ```bash
    
   git submodule add https://github.com/alex-shpak/hugo-book themes/hugo-book
    ```
    
1. 修改配置文件 `hugo.toml` (或者 `config.toml`)
 配置核心功能 (hugo.toml)

使用 VS Code 编辑 `hugo.toml`，填入以下优化后的配置（包含 LaTeX 数学公式和 Mermaid 图表支持）：

```Ini, TOML
# ⚠️ 注意：baseURL 暂时先填个假的，等 Vercel 生成域名后我们再回来改
baseURL = 'https://example.com/'
languageCode = 'zh-cn'
title = '我的知识库'
theme = 'hugo-book'

[params]
  BookSearch = true        # 开启搜索
  BookTheme = 'auto'       # 自动深色模式
  BookMenuBundle = '/menu' # 推荐：使用文件树自动生成左侧菜单

  # 开启数学公式 (LaTeX)
  BookPortableLinks = true
  [params.katex]
    enable = true

[markup]
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = true # 允许 HTML/JS (Mermaid 必需)

  [markup.tableOfContents]
    startLevel = 2
    endLevel = 4
```

---

### 第四步：写一篇文章并预览

1. **新建文章**：
    
    
    ```
    # 创建一个文档页面 
    hugo new content docs/test-page.md
    ```
    
    在 `content/docs/test-page.md` 里随便写点东西，确保本地 `hugo server` 能看到。
    
2. **本地预览**：
    
    Bash
    
    ```
    hugo server -D
    ```
    
    - `-D` 的意思是包括“草稿” (Drafts) 也要显示（因为新建的文章默认是 `draft: true`）。
        
    - 终端会提示你访问 `http://localhost:1313/`。
        
3. 打开浏览器访问这个地址，你应该就能看到你的博客雏形了！
    

---
### 第五步：上传至 GitHub (Push to GitHub)

Vercel 需要从 GitHub 拉取你的代码。

#### 1. 在 GitHub 上创建仓库

1. 登录 GitHub，点击右上角 `+` -> **New repository**。
    
2. 仓库名填 `my_book` (或你喜欢的名字)。
    
3. **不要** 勾选 "Add a README file" 或 .gitignore (保持仓库为空)。
    
4. 点击 **Create repository**。
    

#### 2. 推送代码

回到你的终端（确保在项目根目录下）：

```Bash
# 1. 创建 .gitignore 文件 (这很重要，防止垃圾文件上传)
echo "public/" >> .gitignore
echo "resources/" >> .gitignore
echo ".DS_Store" >> .gitignore

# 2. 提交所有文件
git add .
git commit -m "Initial commit with hugo-book theme"

# 3. 关联远程仓库 (把下面的 URL 换成你刚才创建的 GitHub 仓库地址)
git branch -M main
git remote add origin git@github.com:AbysSses/hugo_book.git

# 4. 推送
git push -u origin main
```

---

### 第六步：Vercel 部署 (Deploy on Vercel)

这一步是将你的代码变成网站的关键。
详见 (Vercel)[[cloudflare使用(子域名创建)]]

#### 错误解决
如果页面不能正常显示则添加vercel的配置文件：
在仓库根目录下创建`vercel.json`内容如下
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

### 第七步：闭环修正 (Final Configuration)

现在你的网站已经上线了，但还有最重要的一步：**修正 `baseURL`**。如果这一步不做，你的样式可能会乱，或者搜索功能无法使用。

#### 1. 获取 Vercel 域名
1. 你的子域名'https://book.hcyang.us.kg/'
2. 在 Vercel 控制台，点击 **"Visit"** 按钮，复制浏览器地址栏里的链接（例如 `https://my-knowledge-base-alpha.vercel.app/`）。

#### 2. 修改本地配置

回到你的本地电脑，打开 `hugo.toml`，把第一行的 `baseURL` 改成你刚才复制的真实域名：

Ini, TOML

```
# 修改前
baseURL = 'https://example.com/'

# 修改后 (注意最后要加斜杠 /)
baseURL = 'https://book.hcyang.us.kg/'
```

#### 3. 再次推送

修改完配置后，需要告诉 Vercel 更新。在终端运行：

Bash

```
git add hugo.toml
git commit -m "Fix baseURL"
git push
```

**此时，Vercel 会自动检测到你的 Push，并自动触发重新部署。** 等个几十秒，你的网站就完美上线了！





### 第八步：与 Obsidian 完美结合 (Mac 版工作流)

这是最酷的部分。由于 Mac 的文件系统非常规范，你可以直接把 Obsidian 的**库 (Vault)** 或者库里的**某个文件夹**，指定为 Hugo 的 `content` 文件夹。

**操作逻辑：**

1. **软链接 (Symbolic Link)**：你可以不用把文件拷来拷去。 假设你的 Obsidian 笔记在 `~/Documents/Obsidian/Posts`，你的 Hugo 博客在 `~/Documents/Blog`。 你可以把 Obsidian 的文件夹“映射”到 Hugo 里：
    
    Bash
    
    ```
    # 先删除 Hugo 默认生成的 posts 文件夹
    rm -rf ~/Documents/Blog/content/posts
    
    # 建立软链接：让 Hugo 的 posts 文件夹直接指向你的 Obsidian 文件夹
    ln -s /Users/hcyang/Library/Mobile Documents/iCloud~md~obsidian/Documents/LifeOS/6. Website/1. hugo_siyu/posts /Users/hcyang/AI/gemini_project/hugo_site/my-blog/content/posts
    ```
    
    _这样，你在 Obsidian 里写的任何东西，保存的一瞬间，Hugo 本地预览就会自动刷新！_
    

---
## 发布

核心逻辑是：**利用 Obsidian 的插件去触发一个 Mac 脚本，脚本自动把代码推送到 GitHub，然后 Vercel 自动检测更新并发布。**

### 第一步：准备自动化脚本 (`deploy.sh`)

这个脚本只负责把你的改动推送到 GitHub。因为我们之前已经决定用 **Vercel** 来托管，所以**不需要**在本地运行 `hugo` 生成网页，这一步交给 Vercel 云端去跑，既省心又不用担心本地环境问题。

1. 打开你的终端 (Terminal)。
    
2. 进入你的 Hugo 博客根目录（假设是 `~/Documents/Blog`）：
    
    Bash
    
    ```
    cd ~/Documents/Blog
    ```
    
3. 创建脚本文件：
    
    Bash
    
    ```
    nano deploy.sh
    ```
    
4. 把下面的代码粘贴进去（**请修改第一行的路径为你实际的博客路径**）：
    

Bash

```
#!/bin/bash

# --- 配置区域 ---
# 必须写绝对路径，因为Obsidian插件执行环境可能不同
BLOG_DIR="$HOME/Documents/Blog" 
# ----------------

cd "$BLOG_DIR" || exit

# 1. 添加所有变动 (包括新文章、修改的内容)
git add .

# 2. 提交变动 (自动带上当前时间作为备注)
current_time=$(date "+%Y-%m-%d %H:%M:%S")
git commit -m "Obsidian Update: $current_time"

# 3. 推送到 GitHub
# 这一步会触发 Vercel 的自动构建
git push origin main

# 4. (可选) 发送 macOS 系统通知告诉你完成了
osascript -e 'display notification "博客已成功推送到 GitHub！" with title "Hugo 发布助手"'
```

5. 按 `Ctrl + O` 回车保存，按 `Ctrl + X` 退出。
    
6. **关键一步**：给脚本赋予执行权限，否则点不动。
    
    Bash
    
    ```
    chmod +x deploy.sh
    ```
    

---

### 第二步：安装 Obsidian 插件 (Shell Commands)

Obsidian 默认不能运行外部脚本，我们需要一个免费的强力插件。

1. 打开 Obsidian **设置** -> **第三方插件** -> **关闭安全模式**。
    
2. 浏览插件市场，搜索并安装 **Shell Commands**。
    
3. 启用该插件。
    

---

### 第三步：配置“一键发布”按钮

现在我们把刚才的脚本绑在 Obsidian 的界面上。

1. 打开 **设置** -> **Shell Commands**。
    
2. 点击 `New command` (新建命令)。
    
3. 在命令输入框里填入你的脚本路径：
    
    Bash
    
    ```
    ~/Documents/Blog/deploy.sh
    ```
    
    _(如果你的路径有空格，请用双引号包起来，比如 `"/Users/yourname/My Blog/deploy.sh"`)_
    
4. **给它起个名字**：点击上面的 "Untitled command"，改成 "🚀 发布博客"。
    
5. **添加到侧边栏 (可选)**：
    
    - 点击命令旁边的 **齿轮图标** (Settings)。
        
    - 找到 **Ribbon icon** (侧边栏图标) 选项，开启它。
        
    - 挑一个你喜欢的图标（比如 `upload-cloud` 或 `paper-plane`）。
        

---

### 🎉 大功告成！

现在，你的工作流是这样的：

1. 在 Obsidian 里写好一篇日记或文章。
    
2. 点击 Obsidian 左侧边栏那个**“🚀 小飞机”**按钮。
    
3. 你会看到 Mac 右上角弹出一个通知：“**博客已成功推送到 GitHub！**”
    
4. 喝口水，大概 1-2 分钟后，访问 `blog.xiaoaming.eu.org`，你的新文章就出现了。
    

---

### ⚠️ 可能遇到的坑 (Troubleshooting)

**1. 第一次 Git Push 报错？** 如果是第一次配置，终端可能会问你要 GitHub 的账号密码。为了避免脚本卡住，建议配置 **SSH Key** 或者在终端里手动运行一次 `git push`，让它记住你的凭证（使用 macOS 的 Keychain）。

**2. 脚本没反应？** 在 Shell Commands 插件设置里，点击那个命令的小齿轮，找到 **Output** (输出) 选项卡，把 "Show output" (显示输出) 设为 **Always** 或 **Errors only**。这样如果脚本出错，它会弹窗告诉你哪里不对（通常是路径没写对）。

**3. Vercel 构建失败？** 如果通知说推送成功了，但网站没更新，去 Vercel 的控制台 (Dashboard) 看看 Build Logs，通常是因为文章 Markdown 里的 Frontmatter 格式有点小问题。

快去试试你的新按钮吧！