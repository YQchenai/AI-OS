# 个人 AI 操作系统 — 搭建指导手册

> **版本**: v1.0
> **适用对象**: AI/科技领域知识分享博主
> **主力工具**: SOLO
> **目标平台**: 小红书 + 微信公众号

---

## 这是什么？

这是一套由 Markdown 文档组成的个人 AI 操作系统。它不是某个具体的软件或 App，而是一堆按照五层结构组织的文档，让 AI 工具能够：

- **认识你**（身份层）——知道你是谁、你的风格、你的偏好
- **理解你**（知识层）——调用你的历史内容、素材、决策记录
- **替你干活**（工具层）——使用预定义的 Skills 执行具体任务
- **串联流程**（协作层）——按工作流自动完成多步骤任务
- **服务场景**（场景层）——针对特定场景组合所有能力

**核心优势**：
- ✅ 纯 Markdown，任何 AI 工具都能用
- ✅ 随时可迁移到新工具
- ✅ 随着使用越来越聪明（知识库持续积累）
- ✅ 随着模型能力增强而增强

---

## 五层架构总览

```
ai-os/
├── 01-identity/          ← 第1层：身份层
│   ├── CLAUDE.md         ← AI 的"入口"，每次都读
│   └── memory/           ← 记忆文件
│       ├── user_profile.md
│       ├── writing_style.md
│       ├── ai_preferences.md
│       └── current_projects.md
│
├── 02-knowledge/         ← 第2层：知识层
│   ├── identity/         ← 定位、风格、品牌
│   ├── audience/         ← 读者画像、反馈洞察
│   ├── content/          ← 内容归档
│   ├── materials/        ← 素材库
│   └── decisions/        ← 决策记录
│
├── 03-tools/             ← 第3层：工具层
│   └── skills/
│       ├── global/       ← 通用 Skills
│       ├── xiaohongshu/  ← 小红书 Skills
│       ├── wechat/       ← 公众号 Skills
│       └── utilities/    ← 辅助 Skills
│
├── 04-workflows/         ← 第4层：协作层
│   ├── idea-to-xiaohongshu.md
│   ├── idea-to-wechat.md
│   ├── repurpose-multi-platform.md
│   └── content-review.md
│
└── 05-scenes/            ← 第5层：场景层
    ├── content-production/
    ├── product-design/
    └── learning/
```

---

## 搭建步骤

### Phase 1：地基（30 分钟）

#### Step 1.1：填写身份层

打开 `01-identity/CLAUDE.md`，填写以下内容：

**必填项**：
1. **你是谁** — 用 3-5 句话描述你的核心身份
2. **你的定位** — 一句话描述你的内容定位
3. **你的风格** — 描述你的内容风格

**怎么填**：回答这 5 个问题：
1. 你的身份 / 正在做的事？
2. 你的目标读者是谁？
3. 你最满意的内容是哪 3 篇？为什么？
4. 你最讨厌 AI 写的什么东西？
5. 你希望 AI 怎么跟你说话？

#### Step 1.2：填写用户画像

打开 `01-identity/memory/user_profile.md`，填写基本信息。

#### Step 1.3：建立风格标本

打开 `01-identity/memory/writing_style.md`：
1. 把你最满意的 3-5 段文字粘贴到"风格标本"区域
2. 描述你的标题公式
3. 列出你的写作禁忌

> 💡 **提示**：身份层是整个系统的地基。花 30 分钟认真填，后面所有环节都会受益。

---

### Phase 2：燃料（1-2 小时）

#### Step 2.1：归档历史内容

1. 找到你最近发布的 10 条原创内容
2. 使用 `02-knowledge/content/_content_template.md` 模板
3. 每篇内容创建一个文件，存入对应平台文件夹
4. 填写数据表现和复盘笔记

#### Step 2.2：填写内容定位

打开 `02-knowledge/identity/positioning.md`：
1. 写清你的内容定位
2. 定义目标读者
3. 列出内容支柱（3-5 个核心主题）

#### Step 2.3：建立读者画像

打开 `02-knowledge/audience/audience_persona.md`：
1. 描述你的核心读者
2. 列出读者痛点
3. 收集常见问题

#### Step 2.4：开始收集素材

打开 `02-knowledge/materials/golden_quotes.md`：
1. 把你觉得有传播力的句子收集进来
2. 标注来源和适用场景

> 💡 **提示**：知识层不需要一次填完。先放 10 篇内容 + 基本定位，够用就行。后续每发一篇内容都往里沉淀。

---

### Phase 3：肌肉（1-2 小时）

#### Step 3.1：理解现有 Skills

浏览 `03-tools/skills/` 下的现有 Skills：
- `global/de-ai-tone.md` — 去 AI 腔
- `global/generate-title.md` — 标题生成
- `global/repurpose-content.md` — 多平台改编
- `xiaohongshu/write-xhs-post.md` — 小红书写作
- `wechat/write-wechat-article.md` — 公众号写作

#### Step 3.2：试用并优化

1. 选一个你最需要的 Skill（推荐从 `write-xhs-post.md` 开始）
2. 按照 Skill 的步骤执行一次
3. 根据实际效果修改 Skill 文件
4. 确认好用后，再试下一个

#### Step 3.3：创建你的第一个自定义 Skill

当你发现某个重复性任务没有现成 Skill 时：
1. 复制一个现有 Skill 作为模板
2. 按模板格式填写
3. 实际使用一次
4. 迭代优化

> 💡 **提示**：Skill 的核心是"做一次，用一万次"。不要为偶尔才做的任务创建 Skill。

---

### Phase 4：流水线（30 分钟）

#### Step 4.1：跑通第一条工作流

推荐从 `04-workflows/idea-to-xiaohongshu.md` 开始：
1. 选一个你想写的选题
2. 按工作流的步骤一步步执行
3. 记录每步的实际耗时
4. 标记哪些步骤 AI 做得好、哪些需要人工介入

#### Step 4.2：优化工作流

根据实际使用体验：
1. 调整步骤顺序
2. 增加或删除步骤
3. 更新预计耗时
4. 记录优化原因

#### Step 4.3：跑通第二条工作流

确认第一条工作流顺畅后，尝试 `idea-to-wechat.md`。

> 💡 **提示**：先跑通 1 条工作流，再复制思路到其他场景。不要一次设计太多。

---

### Phase 5：场景（持续优化）

#### Step 5.1：激活内容生产场景

打开 `05-scenes/content-production/scene-content-production.md`：
1. 填写你的目标指标
2. 理解完整管线
3. 开始按管线运转

#### Step 5.2：建立复盘习惯

每周花 30 分钟执行 `04-workflows/content-review.md`：
1. 看数据
2. 归档内容
3. 提取洞察
4. 更新知识库

#### Step 5.3：持续迭代

- 发现新需求 → 创建新 Skill
- 发现可自动化的环节 → 更新工作流
- 发现新的高频场景 → 创建新场景
- 知识库积累多了 → 优化目录结构

---

## 日常使用指南

### 写一篇小红书
1. 告诉 AI 你的选题
2. AI 调用 `write-xhs-post` Skill
3. AI 自动读取风格指南和素材
4. 你审核、微调、发布
5. 发布后归档到知识库

### 写一篇公众号
1. 告诉 AI 你的选题
2. AI 调用 `write-wechat-article` Skill
3. AI 先出大纲，你确认
4. AI 写正文，去 AI 腔
5. 你审核、排版、发布
6. 发布后归档到知识库

### 一篇内容多发
1. 选一篇已发布的内容
2. AI 调用 `repurpose-content` Skill
3. 自动适配目标平台
4. 你审核、发布

---

## 维护清单

### 每周
- [ ] 复盘本周内容数据
- [ ] 归档新发布的内容
- [ ] 提取评论洞察

### 每月
- [ ] 更新读者画像
- [ ] 更新金句库
- [ ] 评估 Skills 使用频率，淘汰不常用的

### 每季度
- [ ] 更新内容定位
- [ ] 更新风格指南
- [ ] 审视整体架构，优化目录结构
- [ ] 评估是否需要新增场景

---

## 常见问题

### Q: 我需要一次填完所有文件吗？
**A**: 不需要。按 Phase 1-5 的顺序来，每个 Phase 完成后就可以开始用了。知识库和 Skills 是逐步积累的。

### Q: 这些文件放在哪里？
**A**: 放在你的 SOLO 工作目录下。SOLO 每次启动时会读取 `CLAUDE.md`，其他文件在需要时按路径调用。

### Q: 换了 AI 工具怎么办？
**A**: 这套系统是纯 Markdown，任何支持读取文件的 AI 工具都能用。迁移时只需要：
1. 把整个 `ai-os/` 文件夹复制到新工具的工作目录
2. 调整身份层配置文件格式（如果新工具用不同的配置文件名）
3. 其他层基本不需要改动

### Q: Skill 和 Prompt 有什么区别？
**A**: Prompt 是一次性指令，Skill 是可复用的"肌肉记忆"。好的 Skill 包含触发条件、输入输出定义、执行步骤、注意事项，是经过验证的标准化流程。

### Q: 知识库会不会越来越大？
**A**: 会的，但这是好事。AI 每次调用知识时只会读取相关文件，不会一次性加载所有内容。定期清理过时内容即可。

---

## 附录：文件速查表

| 文件 | 用途 | 使用频率 |
|------|------|----------|
| `01-identity/CLAUDE.md` | AI 入口配置 | 每次启动 |
| `01-identity/memory/writing_style.md` | 风格指南 | 每次写作 |
| `01-identity/memory/user_profile.md` | 用户画像 | 需要个性化时 |
| `02-knowledge/identity/positioning.md` | 内容定位 | 选题时 |
| `02-knowledge/audience/audience_persona.md` | 读者画像 | 写作时 |
| `02-knowledge/materials/golden_quotes.md` | 金句库 | 写作时 |
| `02-knowledge/content/` | 内容归档 | 复盘时 |
| `03-tools/skills/xiaohongshu/write-xhs-post.md` | 小红书写作 | 写小红书时 |
| `03-tools/skills/wechat/write-wechat-article.md` | 公众号写作 | 写公众号时 |
| `03-tools/skills/global/de-ai-tone.md` | 去 AI 腔 | 每次写作后 |
| `03-tools/skills/global/generate-title.md` | 标题生成 | 需要标题时 |
| `04-workflows/idea-to-xiaohongshu.md` | 小红书工作流 | 写小红书时 |
| `04-workflows/idea-to-wechat.md` | 公众号工作流 | 写公众号时 |
| `04-workflows/content-review.md` | 内容复盘 | 发布后 |
| `05-scenes/content-production/` | 内容生产场景 | 日常运营 |

---

> 📌 **最后提醒**：这套系统的价值不在于"搭建完成"，而在于"持续使用和迭代"。先从 Phase 1 开始，边用边建，你会发现它越来越聪明。
