---
tags:
  - blog
  - tutorial
  - linux
created: 2025-12-20
---

推送本地项目到远程仓库（如 GitHub、GitLab 或 Gitee）通常分为四个主要步骤。

以下是完整的操作指南，包含针对**密码验证失败**（现在的常见问题）的解决方案。

```bash
git status

git remote -v

git add .

git commit -m "卡片样式修改"

git push origin main

```



### 第一步：初始化本地仓库

如果你已经在项目里使用了 Git（即有 `.git` 文件夹），请跳过此步。 打开终端（Terminal 或 Git Bash），进入你的项目文件夹：

Bash

```
cd /path/to/your/project  # Windows用户可以直接在文件夹右键选择 "Open Git Bash here"
git init                  # 初始化 git
git add .                 # 添加所有文件到暂存区
git commit -m "Initial commit"  # 提交第一次修改
```

### 第二步：关联远程仓库

你需要先在网页端（如 GitHub）创建一个**空仓库**（不要勾选“Initialize with README”以免产生冲突）。创建后，复制仓库的 URL（以 `.git` 结尾）。

回到终端执行：

Bash

```
# origin 是远程仓库的别名，你可以随便取，但习惯上用 origin
# 将下面的 URL 替换为你自己的仓库地址
git remote add origin https://github.com/YourUsername/YourProject.git
```

> **注意：** 如果提示 `error: remote origin already exists`，说明你之前关联过。可以用 `git remote remove origin` 删除旧的关联，再重新添加。

### 第三步：推送代码 (Push)

执行以下命令将本地代码推送到远程：

Bash

```
# -u 参数会将本地分支与远程分支关联，下次只需要输入 git push 即可
git push -u origin main
```

_(注意：旧版本 Git 的默认主分支名可能是 `master`，如果是那样请将 `main` 换成 `master`)_

---

### 🚨 常见问题与解决方案

#### 1. 遇到 "Support for password authentication was removed"

这是目前最常见的问题。GitHub 在 2021 年取消了使用账户密码直接推送的支持。你需要使用 **个人访问令牌 (Personal Access Token, PAT)** 或 **[[SSH 密钥-github]]**。

- **解决方法 (最快)：使用 Token**
    
    1. 去 GitHub 点击头像 -> **Settings** -> **Developer settings** -> **Personal access tokens** -> **Tokens (classic)** -> **Generate new token**。
        
    2. 勾选 `repo` 权限（这是推送代码必须的）。
        
    3. 生成后**复制 Token**（以 `ghp_` 开头）。
        
    4. 在终端再次执行 `git push`。
        
    5. 当提示输入 Password 时，**粘贴这个 Token**（注意：粘贴时屏幕上不会显示任何字符，直接回车即可）。
        

#### 2. 遇到 "rejected - non-fast-forward"

这通常发生在你试图推送到一个非空仓库（例如你在 GitHub 创建仓库时顺手勾选了“创建 README”）。远程仓库有一些你本地没有的文件。

- **解决方法：** 先把远程的更改拉取下来合并，再推送。
    
    Bash
    
    ```
    git pull origin main --allow-unrelated-histories
    # 处理完可能出现的冲突后，再次提交并推送
    git push -u origin main
    ```
    

#### 3. 遇到 "Permission denied (publickey)"

这说明你配置了 SSH 地址（`git@github.com:...`）但电脑上没有对应的 SSH 密钥。

- **解决方法：** 使用 HTTPS 地址（`https://github.com/...`）重新关联，或者按照官方文档生成 SSH key。




## 后续使用教程

```bash
# 在仓库根目录下
git add .
git commit -m "Sec commit"
git push origin main
```