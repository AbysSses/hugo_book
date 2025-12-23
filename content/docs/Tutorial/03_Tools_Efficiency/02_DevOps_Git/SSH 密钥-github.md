---
title: SSH 密钥-github
date: 2025-12-20 14:08:18
draft: false
tags:
  - blog
  - tutorial
  - linux
LastMod: 2025-12-23 11:21:52
---

### 第一步：生成密钥对 (在终端执行)

打开终端，输入以下命令（把邮箱换成注册 GitHub 的邮箱，或者随便填一个都行，只是个标签）：

Bash

```
# 注意：-f 参数指定了新文件的名字
# ed25519是加密方式，目前主流
ssh-keygen -t ed25519 -C "github@AbysSses" -f ~/.ssh/id_ed25519_AbysSses_github
```

1. **按回车**：当它提示 `Enter file in which to save the key` 时，**直接按回车**（默认存在 `~/.ssh/id_ed25519`）。
    
2. **按回车**：当它提示 `Enter passphrase` 时，**直接按回车**（设置为空密码，这样以后推送就不用输密码了）。
    
3. **按回车**：再次确认密码。
    

---

### 第二步：把“公钥”告诉 GitHub

你需要把刚才生成的**公钥**（也就是锁的“副本”）上传到 GitHub。

1. **复制公钥内容：** 在终端运行这行命令，它会自动把公钥内容复制到你的剪贴板：
    
    Bash
    
    ```
    pbcopy < ~/.ssh/id_ed25519_AbysSses_github.pub
    ```
    
2. **在 GitHub 上添加：**
    
    - 打开 GitHub 网页。
        
    - 点击右上角头像 -> **Settings**。
        
    - 在左侧边栏找到 **SSH and GPG keys**。
        
    - 点击绿色的 **New SSH key** 按钮。
        
    - **Title:** 随便填（比如 "MacBook Pro"）。
        
    - **Key:** 在大框里按下 `Command + V` 粘贴刚才复制的内容。
        
    - 点击 **Add SSH key**。
        

---

### 第四步：测试连接

回到终端，输入：

Bash

```
ssh -T git@github.com
```

- 它会问你 `Are you sure you want to continue connecting?`，输入 **yes** 并回车。
    
- 如果看到 `Hi AbysSses! You've successfully authenticated...`，恭喜你，配置成功了！
    

---

### 第五步：切换你项目的连接方式 (最关键的一步)

之前的项目是用 HTTPS 连的，现在要把它切换成 SSH。
```bash
# origin 是远程仓库的别名，但习惯上用 origin
# 将下面的 URL 替换为你自己的仓库地址
git remote add origin https://github.com/YourUsername/YourProject.git
```

在你的项目目录（`~/Desktop/Github/hugo_theme_abyss/Abyss`）下执行：


```bash
# 修改远程仓库地址为 SSH 格式
git remote set-url origin git@github.com:AbysSses/hugo_theme_abyss.git

# 再次验证地址是否变了
git remote -v
```


|命令|什么时候用|
|---|---|
|`git remote add origin URL`|**第一次**绑定远端|
|`git remote set-url origin URL`|已有 origin，**只是换地址**|

### 最后：尝试推送

```bash
git push -u origin main
```

这次它**不会**再让输入任何账号密码，代码应该会直接上传到仓库。