# GitHub 发布步骤

## 1. 在 GitHub 上创建新仓库

1. 登录 GitHub
2. 点击右上角 `+` → `New repository`
3. 填写仓库信息：
   - **Repository name**: `个人AI操作系统` 或 `AI-OS`
   - **Description**: 一套由 Markdown 文档组成的个人 AI 协作框架
   - **可见性**: Public（公开）或 Private（私有）
   - **不要勾选** "Add a README file"（我们已经有了）

## 2. 在本地初始化 Git

打开终端，进入项目目录：

```bash
cd /path/to/AI-OS

# 初始化 Git 仓库
git init

# 添加所有文件
git add .

# 提交
git commit -m "🎉 初始提交：个人 AI 操作系统 v1.0.0"
```

## 3. 推送到 GitHub

```bash
# 添加远程仓库（替换为你的用户名）
git remote add origin https://github.com/你的用户名/AI-OS.git

# 推送到 main 分支
git branch -M main
git push -u origin main
```

## 4. 完成发布

刷新 GitHub 页面，你应该能看到完整的项目文件。

---

## 可选：添加 GitHub Topics

在仓库页面点击 ⚙️ Settings 旁边的设置，添加标签：

- `ai`
- `claude`
- `chatgpt`
- `markdown`
- `productivity`
- `knowledge-management`
- `chinese`

## 可选：创建 Release

1. 点击 `Releases` → `Create a new release`
2. 填写：
   - **Tag**: `v1.0.0`
   - **Title**: `v1.0.0 - 首次发布`
   - **Description**:
     ```
     ## 新功能
     - 五层架构完整实现
     - 交互式初始化脚本
     - 5 个预置 Skills
     - 3 条预置工作流
     - 博主场景优先
     ```

---

## 发布后的文件结构

```
AI-OS/
├── LICENSE              # 非商业使用许可
├── README.md            # GitHub 风格说明文档
├── .gitignore           # Git 忽略文件
├── init.sh              # 一键初始化脚本
├── templates/           # 通用模板文件包
│   └── ...（完整五层架构模板）
└── docs/
    └── setup-guide.md   # 详细使用指南
```
