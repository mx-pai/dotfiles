# 我的 Dotfiles

本仓库使用 [chezmoi](https://chezmoi.io) 管理我的个人开发环境配置。

它包含了我的 Shell、编辑器、命令行工具以及其他应用的配置文件，旨在实现开发环境的快速、自动化部署。

## 核心组件

- **操作系统**: WSL (Debian)
- **配置管理**: `chezmoi`
- **Shell 环境**:
  - **Shell**: Fish
  - **提示符**: Starship
  - **目录跳转**: Zoxide
  - **模糊搜索**: fzf
  - **`ls` 替代**: eza
  - **`cat` 替代**: bat
- **Python 工作流**: `miniconda` + `uv`
- **其他工具**: `lazydocker`, `go`

---

## 部署流程

提供了两种在新机器上部署环境的方案。

### 方案 A: 从 WSL 备份恢复 (推荐)

此方案通过迁移整个 WSL 实例，实现最快速、最完整的环境恢复。

1.  **在旧机器上 (备份)**:
    打开 Windows PowerShell 或 CMD，执行以下命令将当前的 Debian 环境打包成一个 `.tar` 文件。
    ```powershell
    wsl --export Debian D:\wsl-backups\debian-latest.tar
    ```

2.  **在新机器上 (恢复)**:
    a. 确保 Windows 的 WSL 功能已开启 (`wsl --install --no-distribution`)。
    b. 将 `debian-latest.tar` 文件拷贝到新机器。
    c. 打开 PowerShell 或 CMD，执行以下命令导入 WSL 实例。
    ```powershell
    # wsl --import <自定义名称> <安装路径> <备份文件路径>
    wsl --import Debian C:\wsl\debian D:\wsl-backups\debian-latest.tar
    ```
    d. 启动 WSL (`wsl -d Debian`)，所有环境和文件都将恢复原样。如果需要同步最新的 dotfiles，只需运行 `chezmoi apply`。

### 方案 B: 在全新的 WSL 环境中从零开始

此方案适用于没有 `.tar` 备份，需要在纯净的 WSL 环境中完全通过自动化脚本重建环境的场景。

1.  **安装 WSL 和 Debian**:
    在 Windows Store 中安装 `Debian`，或通过 `wsl --install Debian` 命令安装。

2.  **安装 chezmoi**:
    启动 Debian，执行以下命令安装 `chezmoi`。
    ```bash
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin
    ```

3.  **初始化并应用配置**:
    执行 `chezmoi init` 命令，并带上 `--apply` 参数。`chezmoi` 会自动克隆本仓库，并执行内置的一次性安装脚本 (`run_once_before_10-install-packages.sh`) 来安装所有工具。
    ```bash
    chezmoi init git@github.com:mx-pai/dotfiles.git --apply
    ```

4.  **切换默认 Shell**:
    安装脚本会自动安装 `fish`，但需要手动将其设置为默认 Shell。
    ```bash
    chsh -s $(which fish)
    ```

5.  **完成**:
    重新登录 WSL。您的现代化开发环境已准备就绪。

---

## 日常维护

- **添加新配置**:
  ```bash
  chezmoi add ~/.config/new-app
  ```
- **提交变更**:
  ```bash
  # 在 chezmoi 的源目录中操作
  git -C ~/.local/share/chezmoi add .
  git -C ~/.local/share/chezmoi commit -m "feat: Add new-app config"
  git -C ~/.local/share/chezmoi push
  ```
- **应用变更到本地**:
  ```bash
  chezmoi apply
  ```
