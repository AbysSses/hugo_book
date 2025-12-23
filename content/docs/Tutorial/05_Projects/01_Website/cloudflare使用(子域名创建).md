---
title: cloudflare使用(子域名创建)
date: 2025-12-20 15:25:22
draft: false
tags:
  - blog
  - tutorial
  - website
created: 2025-12-20
LastMod: 2025-12-22 11:59:58
---

**“Cloudflare 管域名解析（DNS） + Vercel 管网站托管”** 是目前最流行、速度最快且免费的“黄金搭档”。

特别是对于 `eu.org` 这种免费域名，它本身不提供 DNS 解析面板，**必须**把它的 NS (Nameservers) 指向 Cloudflare 才能方便地添加子域名。

假设你的主域名是 `xiaoaming.eu.org`，你想创建一个博客子域名 `blog.xiaoaming.eu.org`。

---

### 第一步：在 Vercel 中添加域名 (获取目标地址)


1. 登录 Vercel，点击进入你已经部署好的项目（比如你的博客项目）。
    
2. 点击顶部导航栏的 **Settings** (设置) -> 左侧边栏的 **Domains** (域名)。
    
3. 在输入框中填入你想要的完整子域名：`blog.xiaoaming.eu.org`。
    
4. 点击 **Add**。
    
5. **关键点来了**：Vercel 会提示你配置错误（Invalid Configuration），并给你显示两个值：
    
    - **Type**: `CNAME`
        
    - **Value**: `cname.vercel-dns.com` (或者类似 `proxied.vercel-dns.com`)
        
    - _请复制这个 Value 值。_
        

---

### 第二步：在 Cloudflare 中添加记录 (指向 Vercel)

现在去 Cloudflare 告诉它：“当有人访问 `blog` 时，把路指引到 Vercel 去”。

1. 登录 Cloudflare，点击你的域名 `xiaoaming.eu.org`。
    
2. 点击左侧边栏的 **DNS** -> **Records** (记录)。
    
3. 点击蓝色的 **Add record** (添加记录) 按钮。
    
4. 按照以下格式填写（参考 Vercel 给你的信息）：
    

|**选项**|**填写内容**|**说明**|
|---|---|---|
|**Type (类型)**|`CNAME`|子域名通常使用 CNAME 类型|
|**Name (名称)**|`blog`|**这里只需要填前缀！** 不要填完整域名|
|**Target (目标)**|`cname.vercel-dns.com`|刚才在 Vercel 里复制的那个值|
|**Proxy status**|**开启 (橘色云朵)** ☁️|开启代理可以享受 CDN 加速和防攻击|
|**TTL**|Auto|默认即可|

5. 点击 **Save** (保存)。
    

---

### 第三步：处理 SSL/HTTPS 问题 (至关重要)

因为 Cloudflare 和 Vercel 都支持 HTTPS，如果配置不当，会产生“重定向次数过多”的错误。

1. 在 Cloudflare 侧边栏，点击 **SSL/TLS**。
    
2. 将加密模式设置为 **Full (Strict)** 或者 **Full**。
    
    - **不要选 Flexible**：这会导致 Vercel 无法正确签发证书或无限重定向。
        

> [!WARNING] 特别提示
> 
> 如果你在 Cloudflare 开启了“小橘云”（代理模式），Vercel 可能会一直显示“正在生成证书”。通常等待 5-10 分钟即可。
> 
> 如果一直不成功，可以先在 Cloudflare 把“小橘云”关掉（变成灰色，仅 DNS 模式），等 Vercel 显示绿色的“Valid”后，再回 Cloudflare 把小橘云打开。

---

### 总结：数据流向是怎样的？

当你配置好之后，用户访问 `blog.xiaoaming.eu.org` 的过程是：

1. **用户** -> 输入网址。
    
2. **Cloudflare** -> 拦截请求（因为你是橘色云朵），提供安全防护，然后根据 CNAME 记录，把请求转发给 Vercel。
    
3. **Vercel** -> 接收请求，识别出是你的博客项目，返回网页内容。
    

---

### 💡 扩展应用：你可以拥有无数个子域名

既然学会了这招，就可以无限套娃了：

- `cv.xiaoaming.eu.org` -> 指向你的 Notion 简历页面
    
- `tools.xiaoaming.eu.org` -> 指向你用 Python 写的生信分析小工具
    
- `status.xiaoaming.eu.org` -> 指向一个服务器监控面板
    
