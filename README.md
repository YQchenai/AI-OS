# 个人 AI 操作系统 (AI-OS)

[![License](https://img.shields.io/badge/License-Non--Commercial-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/Version-1.1.0-green.svg)]()

> 一套由 Markdown 文档组成的个人 AI 协作框架，让 AI 真正认识你、替你干活。开箱即用，复制即开始。

## 特性

- **开箱即用** — 复制文件夹到工作目录，填写身份层，立即开始
- **个性化定制** — 根据你的身份、风格、偏好配置 AI 协作方式
- **工具无关** — 纯 Markdown，支持 SOLO、Claude Code、ChatGPT 等任何 AI 工具
- **越用越聪明** — 知识库持续积累，AI 对你的理解越来越深
- **零迁移成本** — 换工具只需复制文件夹，无需任何修改

## 快速开始

### 1. 复制文件夹

将整个 `AI-OS/` 文件夹复制到你的 AI 工具工作目录：

```bash
cp -r AI-OS/ /你的工作目录/
```

### 2. 填写身份层

打开 `01-identity/CLAUDE.md`，将 `[占位符]` 替换为你的真实信息：

- 你是谁（核心身份）
- 你的定位（一句话）
- 你的风格（内容风格描述）
- 目标读者

再打开 `01-identity/memory/writing_style.md`，粘贴 3-5 段你最满意的文字作为风格标本。

### 3. 开始使用

告诉 AI 你的需求，它会自动读取配置并按你的风格工作。

## 不同 AI 工具如何使用

| 工具 | 使用方式 |
|------|----------|
| **SOLO** | 将文件夹放在工作目录，SOLO 自动读取 `CLAUDE.md`，其他文件按需调用 |
| **Claude Code** | 启动时指定项目目录为 `AI-OS/` 所在路径，Claude Code 会自动发现 `CLAUDE.md` |
| **ChatGPT** | 将 `01-identity/CLAUDE.md` 的内容粘贴到 Custom Instructions 或 System Prompt 中，其他文件在需要时手动上传 |

> 所有工具通用原则：AI 会先读 `CLAUDE.md` 了解你，再按需读取其他层的文件。

## 目录结构

```
AI-OS/
├── 01-identity/              # 身份层 — AI 认识你的"名片"
│   ├── CLAUDE.md             # 全局配置（AI 入口）
│   └── memory/               # 记忆文件
│       ├── user_profile.md   # 用户画像
│       ├── writing_style.md  # 风格标本
│       ├── ai_preferences.md # AI 偏好 & 踩坑记录
│       └── current_projects.md # 当前项目
│
├── 02-knowledge/             # 知识层 — 你的知识"燃料库"
│   ├── README.md
│   ├── identity/             # 定位
│   │   └── positioning.md
│   ├── audience/             # 读者画像
│   │   └── audience_persona.md
│   ├── content/              # 内容归档模板
│   │   └── _content_template.md
│   ├── materials/            # 素材库
│   │   └── golden_quotes.md
│   └── decisions/            # 决策记录
│
├── 03-tools/                 # 工具层 — AI 的"肌肉记忆"
│   ├── README.md
│   └── skills/
│       ├── global/           # 通用 Skills
│       │   ├── de-ai-tone.md
│       │   ├── generate-title.md
│       │   └── repurpose-content.md
│       ├── xiaohongshu/     # 小红书 Skills
│       │   └── write-xhs-post.md
│       ├── wechat/           # 公众号 Skills
│       │   └── write-wechat-article.md
│       └── video/            # 短视频 Skills
│           └── write-video-script.md
│
├── 04-workflows/             # 协作层 — 串联技能的"剧本"
│   ├── README.md
│   ├── idea-to-xiaohongshu.md
│   ├── idea-to-wechat.md
│   ├── repurpose-multi-platform.md
│   └── content-review.md
│
├── 05-scenes/                # 场景层 — 垂直输出"管线"
│   ├── README.md
│   ├── content-production/
│   │   └── scene-content-production.md
│   └── learning/
│       └── scene-learning.md
│
├── docs/
│   └── setup-guide.md        # 详细搭建指南
├── LICENSE
└── .gitignore
```

## 五层架构

```
┌─────────────────────────────────────────────────────────┐
│                    05 场景层                              │
│     内容生产 / 持续学习（组合使用下四层）                    │
├─────────────────────────────────────────────────────────┤
│                    04 协作层                              │
│     工作流：想法→发布 / 一鱼多吃 / 内容复盘                 │
├─────────────────────────────────────────────────────────┤
│                    03 工具层                              │
│     Skills：去AI腔 / 标题生成 / 小红书写作 / 公众号写作     │
├─────────────────────────────────────────────────────────┤
│                    02 知识层                              │
│     知识库：内容归档 / 素材库 / 读者画像 / 决策记录         │
├─────────────────────────────────────────────────────────┤
│                    01 身份层                              │
│     CLAUDE.md + Memory：你是谁 / 你的风格 / 你的偏好       │
└─────────────────────────────────────────────────────────┘
```

## 预置 Skills

| Skill | 功能 | 位置 |
|-------|------|------|
| `de-ai-tone` | 去 AI 腔调，让文字更像人写的 | `03-tools/skills/global/` |
| `generate-title` | 生成多个标题选项 | `03-tools/skills/global/` |
| `repurpose-content` | 一篇内容改编为多平台版本 | `03-tools/skills/global/` |
| `write-xhs-post` | 按风格写小红书文案 | `03-tools/skills/xiaohongshu/` |
| `write-wechat-article` | 按风格写公众号长文 | `03-tools/skills/wechat/` |
| `write-video-script` | 短视频文案生成（文案/分镜/封面/BGM） | `03-tools/skills/video/` |

## 工作流

| 工作流 | 说明 | 文件 |
|--------|------|------|
| 想法 → 小红书 | 从选题到小红书发布 | `04-workflows/idea-to-xiaohongshu.md` |
| 想法 → 公众号 | 从选题到公众号发布 | `04-workflows/idea-to-wechat.md` |
| 一鱼多吃 | 一篇内容改编多平台 | `04-workflows/repurpose-multi-platform.md` |
| 内容复盘 | 发布后数据复盘与知识沉淀 | `04-workflows/content-review.md` |

## 使用示例

### 写一篇小红书

```
你：帮我写一篇关于 [选题] 的小红书文案

AI：
1. 读取 writing_style.md 获取风格指南
2. 读取 audience_persona.md 获取读者画像
3. 调用 write-xhs-post Skill
4. 自动去 AI 腔
5. 生成标题选项

你：审核 → 微调 → 发布 → 归档
```

### 写一篇公众号

```
你：帮我写一篇关于 [选题] 的公众号文章

AI：
1. 读取风格指南和素材
2. 调用 write-wechat-article Skill
3. 先出大纲，等你确认
4. 写正文，去 AI 腔
5. 生成标题和摘要

你：审核 → 排版 → 发布 → 归档
```

## 维护建议

### 每周
- 复盘本周内容数据
- 归档新发布的内容

### 每月
- 更新读者画像
- 更新金句库

### 每季度
- 更新内容定位
- 更新风格指南
- 评估是否需要新增 Skill

## 适用人群

- 内容创作者 / 博主
- 知识工作者
- 任何想系统化用好 AI 的人

## 许可证

本项目采用**非商业使用许可协议**。详见 [LICENSE](LICENSE)。

- 个人学习使用
- 非商业研究
- 商业使用需授权
- 禁止再分发

如需商业授权，请通过 GitHub Issues 反馈。
