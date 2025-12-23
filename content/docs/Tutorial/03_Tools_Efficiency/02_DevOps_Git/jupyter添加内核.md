---
title: 1. 激活你的环境
draft: false
weight:
tags:
  - bioinformatics
  - jupyter
  - knowledge-management
  - tutorial
  - linux
date: 2025-04-28 13:41:57
dg-publish: true
LastMod: 2025-12-23 15:11:43
---
## PY

# 1. 激活你的环境
conda activate ov

# 2. 安装 ipykernel
conda install ipykernel

# 3. 将环境添加到 Jupyter
python -m ipykernel install --user --name=ov --display-name "Python (ov)"
python -m ipykernel install --user --name ov



## R
将一个新的 R 环境添加为 Jupyter (Notebook 或 Lab) 的内核。

假设新 R 环境名称为 `your_r_env_name`

1. 激活你的 Conda R 环境：
    
    打开终端或 Anaconda Prompt，运行：
    
    Bash
    
    ```
    conda activate your_r_env_name
    ```
    
2. 在激活的环境中安装 r-irkernel 包：
    
    这个 R 包是让 Jupyter 能够识别和连接到 R 环境的关键。
    
    ```sh
    conda install -c conda-forge r-irkernel
    # 或者
    # mamba install -c conda-forge r-irkernel -y
    ```
    
    _请确保是在已激活的 `your_r_env_name` 环境下执行此命令。_
    
3. **启动 R 并注册内核：**
    
    - 首先，在当前激活的终端中输入 `R` 命令，启动 R 会话。
    - 然后，在 R 控制台内部，运行 `IRkernel` 包提供的函数来注册这个环境：
        
        代码段
        
        ```
        # 在 R 控制台内运行以下命令：
        IRkernel::installspec(name = 'your_r_env_name', displayname = 'R (your_r_env_name)', user = TRUE)
        ```
        
        - `name = 'your_r_env_name'`: 这是内核的内部标识符，建议使用你的环境名，方便管理。
        - `displayname = 'R (your_r_env_name)'`: 这个是显示在 Jupyter 界面内核列表中的名称，可以自定义，使其易于识别。
        - `user = TRUE`: 将内核配置安装到当前用户目录下，这是推荐的方式，可以避免权限问题。
    - 注册成功后，R 控制台会显示安装路径。然后输入 `q()` 并按回车，退出 R 会话。
4. 重启 Jupyter Notebook / JupyterLab:
    
    关闭当前所有正在运行的 Jupyter 实例，然后重新启动它。
    

完成以上步骤后，就能在 Jupyter 的内核菜单（例如 "Kernel" -> "Change kernel"）或者新建 Notebook 时的启动器 (Launcher) 中看到你刚刚添加的内核。