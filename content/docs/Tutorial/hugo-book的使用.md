# 关于目录层级(章节内容)

- 每个文件夹都应该有一个 `_index.md`。开头应该是他的Front Matter(属性)

- 作用：定义该章节的标题、权重、是否折叠等

- 示例：

```

---

title: "第一章：基础知识" ##此参数控制显示名字。如果不设置就会显示文件或文件夹的名字

weight: 1 # 章节排序

bookCollapseSection: true # 是否默认折叠子章节

bookFlatSection: false # 是否平铺显示（不显示层级）

---
```

# 页面内容
每个页面同样需要他的Front Matter (属性)
```markdown

---

title: "页面标题"

weight: 1 # 排序权重，数字越小越靠前

bookToc: true # 是否显示右侧目录

bookHidden: false # 是否在菜单中隐藏

bookCollapseSection: false # 如果有子页面，是否折叠

bookComments: false # 是否启用评论

bookSearchExclude: false # 是否从搜索中排除

---

  

# 页面内容

  

这里是 Markdown 内容...

```