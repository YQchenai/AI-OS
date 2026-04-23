# 工具层 — 说明文档

> Skill 是 AI 的"肌肉记忆"。一次性 prompt 是肌肉抽搐，Skill 是肌肉记忆。
> 好 Skill 的标准：**做一次，用一万次。**

---

## 核心原则

1. **按场景分库**：不要全部塞在一起，按工作场景分类存放
2. **命名规范**：`动词-对象.md`，例如 `write-xhs-post.md`、`analyze-competitor.md`
3. **每个 Skill 一个文件**：包含触发条件、输入、输出、步骤
4. **持续迭代**：用一次优化一次，记录版本变更

---

## 目录结构

```
03-tools/skills/
├── global/              ← 全局通用 Skills（任何场景都能用）
├── content-writing/     ← 内容写作 Skills（公众号/通用写作）
├── xiaohongshu/         ← 小红书垂直 Skills
├── wechat/              ← 微信公众号垂直 Skills
└── utilities/           ← 辅助工具 Skills（搜索、整理、分析）
```

---

## Skill 文件模板

每个 Skill 文件遵循以下结构：

```markdown
# [Skill 名称]

> 版本：v1.0 | 更新：YYYY-MM-DD | 使用次数：[次数]

## 触发条件
[什么情况下使用这个 Skill]

## 输入
- [需要的输入1]
- [需要的输入2]

## 输出
- [产出的内容1]
- [产出的内容2]

## 执行步骤
1. [步骤1]
2. [步骤2]
3. [步骤3]

## 注意事项
- [注意点1]
- [注意点2]

## 变更记录
- v1.0 (YYYY-MM-DD): 初始版本
```

---

## 推荐优先创建的 Skills

### 第一批（最高频）
1. `write-xhs-post.md` — 按风格写小红书文案
2. `write-wechat-article.md` — 按风格写公众号长文
3. `generate-title.md` — 生成多个标题选项
4. `de-ai-tone.md` — 去 AI 腔调，让文字更像人写的

### 第二批（提升效率）
5. `analyze-content-data.md` — 分析内容数据表现
6. `repurpose-content.md` — 一篇内容改编为多平台版本
7. `research-topic.md` — 围绕一个选题做信息搜集
8. `extract-insights.md` — 从评论/反馈中提取洞察

### 第三批（进阶）
9. `create-content-calendar.md` — 生成内容排期表
10. `competitor-monitor.md` — 同行内容监控与分析

---

## 快速启动

1. 先从第一批中选 1-2 个你最需要的 Skill
2. 复制模板，填入你的具体要求
3. 实际使用一次，根据效果调整
4. 确认好用后，再创建下一个
