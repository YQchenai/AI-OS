#!/bin/bash
# ============================================================
#  AI-OS 个人 AI 操作系统 — 一键初始化脚本
#  版本: v1.0.0
#  适用: SOLO / Claude Code / 任何支持 Bash 的 AI 工具
# ============================================================

set -e

# ---------- 颜色定义 ----------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# ---------- 工具函数 ----------
print_banner() {
    echo ""
    echo -e "${CYAN}╔══════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                                                  ║${NC}"
    echo -e "${CYAN}║        ${BOLD}AI-OS 个人 AI 操作系统${NC}                    ${CYAN}║${NC}"
    echo -e "${CYAN}║        ${BOLD}一键初始化向导${NC}                            ${CYAN}║${NC}"
    echo -e "${CYAN}║                                                  ║${NC}"
    echo -e "${CYAN}║        版本 v1.0.0                                ${CYAN}║${NC}"
    echo -e "${CYAN}║                                                  ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_step() {
    echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BOLD}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_info() {
    echo -e "${CYAN}💡 $1${NC}"
}

print_warn() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

ask() {
    local prompt="$1"
    local default="$2"
    if [ -n "$default" ]; then
        echo -ne "${BOLD}${prompt}${NC} [${default}]: "
    else
        echo -ne "${BOLD}${prompt}${NC}: "
    fi
    read -r answer
    echo "${answer:-$default}"
}

ask_choice() {
    local prompt="$1"
    shift
    local options=("$@")
    echo -e "${BOLD}${prompt}${NC}"
    for i in "${!options[@]}"; do
        echo -e "  ${CYAN}$((i+1)).${NC} ${options[$i]}"
    done
    echo -ne "${BOLD}请选择 [1-${#options[@]}]${NC}: "
    read -r choice
    while [[ -z "$choice" || "$choice" -lt 1 || "$choice" -gt ${#options[@]} ]]; do
        echo -ne "${RED}无效选择，请重新输入${NC}: "
        read -r choice
    done
    echo "${options[$((choice-1))]}"
}

ask_multi() {
    local prompt="$1"
    shift
    local options=("$@")
    echo -e "${BOLD}${prompt}${NC} (输入编号，多个用空格分隔)"
    for i in "${!options[@]}"; do
        echo -e "  ${CYAN}$((i+1)).${NC} ${options[$i]}"
    done
    echo -ne "${BOLD}请选择${NC}: "
    read -r choices
    local result=""
    for c in $choices; do
        if [[ "$c" -ge 1 && "$c" -le ${#options[@]} ]]; then
            if [ -n "$result" ]; then result+="、"; fi
            result+="${options[$((c-1))]}"
        fi
    done
    echo "$result"
}

# ---------- 主流程 ----------
main() {
    print_banner

    # ===== Step 0: 确认安装路径 =====
    print_step "Step 0: 确认安装路径"
    print_info "AI-OS 将安装到你的工作目录下"
    INSTALL_DIR=$(ask "安装目录名称" "ai-os")
    FULL_PATH="$(pwd)/${INSTALL_DIR}"

    if [ -d "$FULL_PATH" ]; then
        print_warn "目录 ${INSTALL_DIR} 已存在"
        OVERWRITE=$(ask_choice "是否覆盖？" "是，覆盖现有文件" "否，安装到新目录")
        if [ "$OVERWRITE" = "否，安装到新目录" ]; then
            INSTALL_DIR="${INSTALL_DIR}-$(date +%Y%m%d-%H%M%S)"
            FULL_PATH="$(pwd)/${INSTALL_DIR}"
            print_info "将安装到: ${INSTALL_DIR}"
        fi
    fi

    echo ""
    print_info "安装路径: ${FULL_PATH}"
    echo ""

    # ===== Step 1: 基础信息收集 =====
    print_step "Step 1: 告诉 AI 你是谁"

    NICKNAME=$(ask "你的昵称/笔名" "")
    ROLE=$(ask_choice "你的主要身份" "内容创作者/博主" "创业者/产品经理" "技术开发者" "职场人/其他")
    FIELD=$(ask "你的专业领域" "AI/科技")
    PLATFORMS=$(ask_multi "你主要在哪些平台发布内容" "小红书" "微信公众号" "抖音/B站" "知乎/即刻" "其他")
    CONTENT_TYPE=$(ask_choice "你的内容类型" "知识分享/干货教程" "生活方式/日常" "测评/种草" "观点/评论" "其他")
    CONTENT_STYLE=$(ask "用一句话描述你的内容风格" "说人话、给干货")

    print_success "基础信息收集完成"

    # ===== Step 2: 深度偏好 =====
    print_step "Step 2: 告诉 AI 你的偏好"

    echo -e "${BOLD}你的沟通偏好（AI 回复时遵循）${NC}"
    TONE=$(ask_choice "语调风格" "朋友聊天式" "专业但不刻板" "轻松幽默" "简洁干练")
    PERSON=$(ask_choice "人称偏好" "第一人称'我'" "第二人称'你'" "混合使用")
    FORMAT=$(ask_choice "排版偏好" "短段落+列表" "结构化+表格" "自由排版")

    echo ""
    echo -e "${BOLD}你讨厌 AI 的哪些行为？${NC}"
    AI_HATE_1=$(ask "最讨厌的一点" "用'首先、其次、最后'八股结构")
    AI_HATE_2=$(ask "第二讨厌的" "过度使用emoji")
    AI_HATE_3=$(ask "第三讨厌的" "废话铺垫太多")

    echo ""
    echo -e "${BOLD}一句话定位（你的内容解决什么问题？）${NC}"
    POSITIONING=$(ask "你的内容定位" "帮[目标人群]用[方法]实现[结果]")

    echo ""
    echo -e "${BOLD}目标读者是谁？${NC}"
    TARGET_READER=$(ask "目标读者描述" "[年龄段]的[职业人群]，他们[核心痛点]")

    print_success "偏好设置完成"

    # ===== Step 3: 创建目录结构 =====
    print_step "Step 3: 创建五层架构目录"

    mkdir -p "${FULL_PATH}/01-identity/memory"
    mkdir -p "${FULL_PATH}/02-knowledge/identity"
    mkdir -p "${FULL_PATH}/02-knowledge/audience"
    mkdir -p "${FULL_PATH}/02-knowledge/content/xiaohongshu"
    mkdir -p "${FULL_PATH}/02-knowledge/content/wechat"
    mkdir -p "${FULL_PATH}/02-knowledge/content/other"
    mkdir -p "${FULL_PATH}/02-knowledge/materials"
    mkdir -p "${FULL_PATH}/02-knowledge/decisions"
    mkdir -p "${FULL_PATH}/03-tools/skills/global"
    mkdir -p "${FULL_PATH}/03-tools/skills/content-writing"
    mkdir -p "${FULL_PATH}/03-tools/skills/xiaohongshu"
    mkdir -p "${FULL_PATH}/03-tools/skills/wechat"
    mkdir -p "${FULL_PATH}/03-tools/skills/utilities"
    mkdir -p "${FULL_PATH}/04-workflows"
    mkdir -p "${FULL_PATH}/05-scenes/content-production"
    mkdir -p "${FULL_PATH}/05-scenes/product-design"
    mkdir -p "${FULL_PATH}/05-scenes/learning"
    mkdir -p "${FULL_PATH}/docs"

    print_success "目录结构创建完成"

    # ===== Step 4: 生成个性化文件 =====
    print_step "Step 4: 生成个性化配置文件"

    # --- 4.1 CLAUDE.md ---
    cat > "${FULL_PATH}/01-identity/CLAUDE.md" << CLAUDE_EOF
# AI-OS — 个人 AI 操作系统配置

> **版本**: v1.0.0
> **初始化日期**: $(date +%Y-%m-%d)
> **适用工具**: SOLO / Claude Code / ChatGPT / 任何支持 Markdown 上下文的 AI 工具

---

## 我是谁

- **昵称**: ${NICKNAME}
- **身份**: ${ROLE}
- **领域**: ${FIELD}
- **平台**: ${PLATFORMS}
- **定位**: ${POSITIONING}
- **风格**: ${CONTENT_STYLE}

## 我正在做的事

<!-- 列出当前最重要的 1-3 个项目 -->
- [ ] 项目1：[名称] — [一句话描述]
- [ ] 项目2：[名称] — [一句话描述]
- [ ] 项目3：[名称] — [一句话描述]

## 我的工作方式

### 沟通偏好
- **语言**: 中文
- **语调**: ${TONE}
- **人称**: ${PERSON}
- **排版**: ${FORMAT}
- **禁忌**: 不要${AI_HATE_1}、不要${AI_HATE_2}、不要${AI_HATE_3}

### 内容偏好
- **内容类型**: ${CONTENT_TYPE}
- **目标读者**: ${TARGET_READER}
- **内容长度**:
  - 短内容（小红书等）：300-800字，配图为主
  - 长内容（公众号等）：1500-3000字，深度内容
- **标题风格**: 数字+痛点+方案 / 反常识+解释 / 身份+场景+结果

## 我的知识库结构

\`\`\`
ai-os/
├── 01-identity/     ← 身份层：AI 认识你的"名片"
├── 02-knowledge/    ← 知识层：你的知识"燃料库"
├── 03-tools/        ← 工具层：AI 的"肌肉记忆"
├── 04-workflows/    ← 协作层：串联技能的"剧本"
└── 05-scenes/       ← 场景层：垂直输出"管线"
\`\`\`

## 重要规则

1. **按需读取 memory**：
   - 写作任务 → 先读 \`memory/writing_style.md\`（风格标本、标题公式、禁忌）
   - 需要了解我的背景/身份 → 读 \`memory/user_profile.md\`
   - 需要了解我当前在做什么 → 读 \`memory/current_projects.md\`
   - 避免重复犯错 → 读 \`memory/ai_preferences.md\`（踩坑记录）
2. **调用知识**: 需要背景信息时，去 \`02-knowledge/\` 查找
3. **使用工具**: 有现成 Skill 时优先使用，不要重复造轮子
4. **保持风格**: 所有输出都要符合上面定义的风格偏好
5. **记录决策**: 重要的讨论和决策要沉淀到 \`02-knowledge/decisions/\`

---

> 💡 **提示**: 这份文件是你的 AI 操作系统的"入口"。AI 每次启动时都会读取它，所以保持简洁、准确、及时更新。
CLAUDE_EOF
    print_success "✅ 01-identity/CLAUDE.md"

    # --- 4.2 user_profile.md ---
    cat > "${FULL_PATH}/01-identity/memory/user_profile.md" << PROFILE_EOF
# 用户画像

> 最后更新：$(date +%Y-%m-%d)

## 基本信息
- **昵称/笔名**: ${NICKNAME}
- **身份**: ${ROLE}
- **领域**: ${FIELD}

## 核心能力
- [能力1：填写你最擅长的技能]
- [能力2：填写你的第二项技能]
- [能力3：填写你的第三项技能]

## 内容数据
- **发布平台**: ${PLATFORMS}
- **月均产出**: [填写月均发布篇数]
- **最受欢迎的内容类型**: [填写]

## 个人标签
- [标签1]
- [标签2]
- [标签3]

## 成长经历
<!-- 简述你的背景故事，AI 可以用来理解你的视角 -->
- [经历1]
- [经历2]
- [经历3]
PROFILE_EOF
    print_success "✅ 01-identity/memory/user_profile.md"

    # --- 4.3 writing_style.md ---
    cat > "${FULL_PATH}/01-identity/memory/writing_style.md" << STYLE_EOF
# 内容风格指南

> 最后更新：$(date +%Y-%m-%d)

## 写作风格
- **语调**: ${TONE}
- **人称**: ${PERSON}
- **排版**: ${FORMAT}
- **整体风格**: ${CONTENT_STYLE}

## 标题公式
<!-- 记录你验证过有效的标题模式 -->
1. 数字+痛点+方案：\`[数字]个[痛点解决方案]，[效果]\`
2. 反常识+解释：\`[反常识观点]，[原因]\`
3. 身份+场景+结果：\`[身份]如何[场景]实现[结果]\`

## 开头模板
<!-- 记录你常用的开头方式 -->
- [模板1：填写你常用的开头方式]
- [模板2：填写你常用的开头方式]

## 结尾模板
<!-- 记录你常用的结尾方式 -->
- [模板1：填写你常用的结尾方式]
- [模板2：填写你常用的结尾方式]

## 禁忌清单
- ❌ 不要${AI_HATE_1}
- ❌ 不要${AI_HATE_2}
- ❌ 不要${AI_HATE_3}

## 风格标本
<!-- 放 3-5 段你觉得最能代表你风格的文字片段，AI 会模仿这些风格 -->
### 标本 1
> [粘贴一段你最满意的文字]

### 标本 2
> [粘贴一段你最满意的文字]

### 标本 3
> [粘贴一段你最满意的文字]
STYLE_EOF
    print_success "✅ 01-identity/memory/writing_style.md"

    # --- 4.4 ai_preferences.md ---
    cat > "${FULL_PATH}/01-identity/memory/ai_preferences.md" << PREF_EOF
# AI 偏好与踩坑记录

> 最后更新：$(date +%Y-%m-%d)

## AI 使用偏好

### 喜欢的 ✅
- 先给结论再展开说明
- 用表格对比时，关键差异要加粗
- 给出具体可执行的步骤，不说空话

### 讨厌的 ❌
- ${AI_HATE_1}
- ${AI_HATE_2}
- ${AI_HATE_3}

## 踩坑记录
<!-- 记录 AI 帮你做事时出过的错，避免重复 -->

### 坑 1：[简述问题]
- **场景**: [什么情况下发生的]
- **表现**: [AI 具体做错了什么]
- **解决**: [怎么修的/怎么避免的]

## Prompt 优化心得
<!-- 记录你觉得好用的 prompt 技巧 -->
1. [技巧1]
2. [技巧2]
3. [技巧3]
PREF_EOF
    print_success "✅ 01-identity/memory/ai_preferences.md"

    # --- 4.5 current_projects.md ---
    cat > "${FULL_PATH}/01-identity/memory/current_projects.md" << PROJ_EOF
# 当前项目

> 最后更新：$(date +%Y-%m-%d)

## 项目列表

### 项目 1：[项目名称]
- **状态**: 🟡 规划中
- **目标**: [一句话描述目标]
- **截止日期**: [日期]
- **当前进展**: [简述]

### 项目 2：[项目名称]
- **状态**: 🟡 规划中
- **目标**: [一句话描述目标]
- **截止日期**: [日期]
- **当前进展**: [简述]

## 优先级排序
1. [最高优先级项目]
2. [次高优先级项目]
PROJ_EOF
    print_success "✅ 01-identity/memory/current_projects.md"

    # ===== Step 5: 生成知识层文件 =====
    print_step "Step 5: 生成知识层模板"

    # --- 5.1 positioning.md ---
    cat > "${FULL_PATH}/02-knowledge/identity/positioning.md" << POS_EOF
# 内容定位

> 最后更新：$(date +%Y-%m-%d)

## 一句话定位
${POSITIONING}

## 目标读者
- **核心人群**: ${TARGET_READER}
- **读者痛点**:
  1. [痛点1：填写读者最核心的痛点]
  2. [痛点2]
  3. [痛点3]

## 内容差异化
<!-- 你和同领域其他创作者最大的不同是什么？ -->
- [差异点1]
- [差异点2]
- [差异点3]

## 内容支柱
<!-- 你的内容围绕哪 3-5 个核心主题展开？ -->
1. **[支柱1名称]**: [描述]
2. **[支柱2名称]**: [描述]
3. **[支柱3名称]**: [描述]

## 内容边界
### 我会写的 ✅
- [内容类型1]
- [内容类型2]

### 我不会写的 ❌
- [内容类型1]
- [内容类型2]
POS_EOF
    print_success "✅ 02-knowledge/identity/positioning.md"

    # --- 5.2 audience_persona.md ---
    cat > "${FULL_PATH}/02-knowledge/audience/audience_persona.md" << AUD_EOF
# 目标读者画像

> 最后更新：$(date +%Y-%m-%d)

## 核心读者

### 基本信息
- **年龄段**: [例如：22-35岁]
- **职业**: [例如：互联网从业者、自媒体新手]
- **城市**: [例如：一二线城市为主]

### 心理特征
- [特征1]
- [特征2]

### 信息获取习惯
- **主要平台**: ${PLATFORMS}
- **活跃时间**: [例如：晚上8-11点]
- **内容偏好**: [例如：喜欢图文并茂、干货清单]

## 读者需求地图
| 需求 | 频次 | 已有内容 | 待开发 |
|------|------|----------|--------|
| [需求1] | 高 | ❌ | ✅ |
| [需求2] | 中 | ❌ | ✅ |
| [需求3] | 低 | ❌ | ✅ |

## 常见问题收集
<!-- 从评论、私信中收集的高频问题 -->
1. [问题1]
2. [问题2]
3. [问题3]

## 读者反馈洞察
<!-- 定期更新的读者反馈总结 -->
### $(date +%Y-%m-%d) 初始版本
- 待收集第一波反馈后更新
AUD_EOF
    print_success "✅ 02-knowledge/audience/audience_persona.md"

    # --- 5.3 golden_quotes.md ---
    cat > "${FULL_PATH}/02-knowledge/materials/golden_quotes.md" << QUOTES_EOF
# 金句库

> 最后更新：$(date +%Y-%m-%d)

## 使用说明
- 收集你觉得有传播力的句子
- 标注来源（原创/引用/改写）
- 标注适用场景（开头/结尾/金句卡）

---

## ${FIELD}类
1. > "[金句内容]"
   - 来源：[原创/引用]
   - 适用：[场景]

## 效率/方法论类
1. > "[金句内容]"
   - 来源：[原创/引用]
   - 适用：[场景]

## 个人成长类
1. > "[金句内容]"
   - 来源：[原创/引用]
   - 适用：[场景]
QUOTES_EOF
    print_success "✅ 02-knowledge/materials/golden_quotes.md"

    # --- 5.4 content template ---
    cat > "${FULL_PATH}/02-knowledge/content/_content_template.md" << TPL_EOF
# 内容归档模板

> 将此模板复制为每篇内容的归档文件
> 文件名格式：\`YYYY-MM-DD_标题关键词.md\`

---

## 元数据
- **标题**: [文章标题]
- **平台**: 小红书 / 公众号 / 其他
- **发布日期**: YYYY-MM-DD
- **标签**: [标签1, 标签2, 标签3]
- **内容支柱**: [对应的内容支柱名称]

## 数据表现
| 指标 | 数值 |
|------|------|
| 阅读量 | |
| 点赞 | |
| 收藏 | |
| 评论 | |
| 转发 | |

## 内容正文
[粘贴完整正文]

## 复盘笔记
### 做对了什么
- [亮点1]

### 可以改进
- [改进点1]

### 素材可复用
- [可以复用到其他内容的素材/观点]
TPL_EOF
    print_success "✅ 02-knowledge/content/_content_template.md"

    # --- 5.5 knowledge README ---
    cat > "${FULL_PATH}/02-knowledge/README.md" << KREADME_EOF
# 知识层 — 说明文档

> 这层是你的 AI 操作系统的"燃料库"。

## 核心原则
1. **纯文件 + Markdown**: AI 能 \`read\` 就够了
2. **按用途分文件夹**: 不要按时间分，按"AI 什么时候需要它"来分
3. **持续沉淀**: 每完成一次重要任务，把有价值的产出扔进来
4. **定期清理**: 过时的内容归档

## 目录结构
\`\`\`
02-knowledge/
├── identity/       ← 定位、风格、品牌资料
├── audience/       ← 粉丝画像、评论洞察
├── content/        ← 内容归档（按平台分）
│   ├── xiaohongshu/
│   ├── wechat/
│   └── other/
├── materials/      ← 金句、案例、数据
└── decisions/      ← 战略讨论、决策记录
\`\`\`

## 快速启动
1. 把最近 10 条原创内容扔进 \`content/\` 对应平台文件夹
2. 把你觉得自己最满意的 3-5 条内容标记为风格标本
3. 在 \`audience/\` 下写一个简单的读者画像
4. 其他文件夹可以先空着，用到再填
KREADME_EOF
    print_success "✅ 02-knowledge/README.md"

    # ===== Step 6: 生成工具层文件 =====
    print_step "Step 6: 生成工具层 Skills"

    # --- 6.1 tools README ---
    cat > "${FULL_PATH}/03-tools/README.md" << TREADME_EOF
# 工具层 — 说明文档

> Skill 是 AI 的"肌肉记忆"。一次性 prompt 是肌肉抽搐，Skill 是肌肉记忆。
> 好 Skill 的标准：**做一次，用一万次。**

## 核心原则
1. **按场景分库**: 不要全部塞在一起
2. **命名规范**: \`动词-对象.md\`，例如 \`write-xhs-post.md\`
3. **每个 Skill 一个文件**: 包含触发条件、输入、输出、步骤
4. **持续迭代**: 用一次优化一次

## 目录结构
\`\`\`
03-tools/skills/
├── global/              ← 全局通用 Skills
├── content-writing/     ← 内容写作 Skills
├── xiaohongshu/         ← 小红书垂直 Skills
├── wechat/              ← 微信公众号垂直 Skills
└── utilities/           ← 辅助工具 Skills
\`\`\`

## 推荐优先创建的 Skills
1. \`write-xhs-post.md\` — 按风格写小红书文案
2. \`write-wechat-article.md\` — 按风格写公众号长文
3. \`generate-title.md\` — 生成多个标题选项
4. \`de-ai-tone.md\` — 去 AI 腔调
TREADME_EOF
    print_success "✅ 03-tools/README.md"

    # --- 6.2 de-ai-tone.md ---
    cat > "${FULL_PATH}/03-tools/skills/global/de-ai-tone.md" << DEAI_EOF
# 去 AI 腔调

> 版本：v1.0 | 更新：$(date +%Y-%m-%d)

## 触发条件
AI 生成的文案有明显的"AI味"时使用。建议在所有写作 Skill 的最后一步自动调用。

## 输入
- AI 生成的文案

## 输出
- 去 AI 腔后的文案

## 执行步骤

### Step 1: 检测 AI 腔特征
扫描以下常见表达并替换：

| AI 腔 | 替换为 |
|--------|--------|
| 值得注意的是 | [直接说重点] |
| 不可否认 | [删掉，直接说] |
| 总的来说 | [删掉或换成"说白了"] |
| 让我们一起 | [换成"咱们来"] |
| 在当今社会 | [删掉，直接进入主题] |
| 随着XX的发展 | [删掉，直接说结论] |
| 旨在 | [换成"为了"] |
| 赋能 | [换成"帮助/支持"] |
| 颗粒度 | [换成"细节"] |
| 闭环 | [换成"完整流程"] |
| 打法 | [换成"方法/策略"] |
| 沉淀 | [换成"积累/总结"] |

### Step 2: 修复结构问题
- ❌ 每段都以"首先...其次...最后..."开头 → 改为自然过渡
- ❌ 过度使用排比句 → 保留最有力的一个
- ❌ 每段结尾都有总结句 → 删掉多余的总结
- ❌ 过度使用"不仅...而且..." → 换成更自然的连接

### Step 3: 注入个人风格
- 读取 \`01-identity/memory/writing_style.md\` 中的风格标本
- 模仿标本中的句式和表达方式
- 加入 1-2 个口语化表达
- 适当加入个人观点和态度

### Step 4: 最终检查
- 读一遍，问自己："这像是一个真人写的吗？"
- 如果不像，回到 Step 2 继续调整

## 注意事项
- 去 AI 腔不是让文字变"糙"，而是让文字有"人味"
- 保留专业性，去掉机器感
- 每个人的"人味"不同，要参考风格标本来校准
DEAI_EOF
    print_success "✅ 03-tools/skills/global/de-ai-tone.md"

    # --- 6.3 generate-title.md ---
    cat > "${FULL_PATH}/03-tools/skills/global/generate-title.md" << TITLE_EOF
# 标题生成器

> 版本：v1.0 | 更新：$(date +%Y-%m-%d)

## 触发条件
需要为内容生成标题选项时使用。

## 输入
- 内容主题/核心观点
- 目标平台：小红书 / 公众号 / 其他
- 内容类型：干货教程 / 工具测评 / 观点分享 / 清单盘点

## 输出
- 5-8 个标题选项，按公式分类

## 执行步骤

### Step 1: 读取上下文
- 读取 \`01-identity/memory/writing_style.md\` 中的标题公式
- 读取 \`02-knowledge/content/\` 中历史高表现内容的标题

### Step 2: 按公式生成

**小红书标题公式：**
1. **数字+结果**: \`[数字]个[方法/工具]，[具体效果]\`
2. **反常识**: \`[反常识观点]，[解释]\`
3. **身份+场景**: \`[身份]必看的[内容类型]\`
4. **痛点+方案**: \`[痛点]？[解决方案]来了\`
5. **对比**: \`[A] vs [B]，[结论]\`

**公众号标题公式：**
1. **观点型**: \`[有力观点]\`
2. **故事型**: \`[故事性描述]\`
3. **方法论型**: \`如何[做某事]：[核心方法]\`
4. **数据型**: \`[数据]告诉你[结论]\`
5. **疑问型**: \`[好问题]？\`

### Step 3: 筛选优化
- 剔除过于标题党的选项
- 确保标题准确反映内容
- 每个标题附带简短说明

## 注意事项
- 标题要包含"信息差"
- 小红书标题控制在 20 字以内
- 公众号标题控制在 30 字以内
TITLE_EOF
    print_success "✅ 03-tools/skills/global/generate-title.md"

    # --- 6.4 repurpose-content.md ---
    cat > "${FULL_PATH}/03-tools/skills/global/repurpose-content.md" << REPO_EOF
# 内容多平台改编

> 版本：v1.0 | 更新：$(date +%Y-%m-%d)

## 触发条件
有一篇内容需要改编为其他平台版本时使用。

## 输入
- 原始内容（或指向原始内容的路径）
- 目标平台

## 输出
- 改编后的内容 + 平台适配说明

## 执行步骤

### 长文 → 短内容（公众号→小红书）
1. 提取核心观点和 3-5 个关键信息点
2. 压缩至 300-800 字
3. 改写为口语化表达
4. 添加 emoji 适度点缀
5. 生成标题和标签

### 短内容 → 长文（小红书→公众号）
1. 扩展每个要点，补充论据和案例
2. 增加开头故事/引入
3. 增加结尾升华
4. 调整为公众号排版风格

## 注意事项
- 改编不是简单缩放，要适配平台调性
- 短内容重"快+实用"，长内容重"深+观点"
- 保留核心观点，调整表达方式
REPO_EOF
    print_success "✅ 03-tools/skills/global/repurpose-content.md"

    # --- 6.5 write-xhs-post.md ---
    cat > "${FULL_PATH}/03-tools/skills/xiaohongshu/write-xhs-post.md" << XHS_EOF
# 小红书文案写作

> 版本：v1.0 | 更新：$(date +%Y-%m-%d)

## 触发条件
需要写小红书图文/视频文案时使用。

## 输入
- 选题/主题（一句话描述即可）
- 内容类型：干货教程 / 工具测评 / 观点分享 / 清单盘点

## 输出
- 3-5 个标题选项
- 正文文案（300-800字）
- 标签建议（5-10个）
- 封面文案建议

## 执行步骤

### Step 1: 读取上下文
- 读取 \`01-identity/memory/writing_style.md\` 获取风格指南
- 读取 \`02-knowledge/audience/audience_persona.md\` 获取读者画像
- 读取 \`02-knowledge/materials/golden_quotes.md\` 获取可用金句

### Step 2: 生成标题
按以下公式各生成 1-2 个：
- 数字+痛点+方案
- 反常识+解释
- 身份+场景+结果

### Step 3: 写正文
1. **钩子**（前2行）：用痛点或反常识抓住注意力
2. **价值**（中间）：核心干货内容，分点列出
3. **行动**（结尾）：引导互动（收藏/关注/评论）

### Step 4: 优化
- 检查是否符合风格指南
- 检查是否有 AI 腔（如有，执行去 AI 腔处理）
- 确保每段不超过 3 行
- 适当使用 emoji（但不过度）

### Step 5: 补充
- 生成 5-10 个相关标签
- 提供封面文案建议

## 注意事项
- 小红书文案要"说人话"，避免书面语
- 段落要短，适合手机阅读
- 标题要有"信息差"或"好奇心缺口"
XHS_EOF
    print_success "✅ 03-tools/skills/xiaohongshu/write-xhs-post.md"

    # --- 6.6 write-wechat-article.md ---
    cat > "${FULL_PATH}/03-tools/skills/wechat/write-wechat-article.md" << WX_EOF
# 公众号长文写作

> 版本：v1.0 | 更新：$(date +%Y-%m-%d)

## 触发条件
需要写微信公众号长文时使用。

## 输入
- 选题/主题
- 目标字数：1500-3000字
- 内容类型：深度教程 / 观点文章 / 工具测评 / 行业分析

## 输出
- 3-5 个标题选项
- 完整正文
- 摘要（50字以内）
- 配图建议

## 执行步骤

### Step 1: 读取上下文
- 读取 \`01-identity/memory/writing_style.md\`
- 读取 \`02-knowledge/audience/audience_persona.md\`
- 读取 \`02-knowledge/materials/\` 中相关素材

### Step 2: 生成大纲
先输出文章大纲：
- 核心观点（一句话）
- 章节结构（3-5个部分）
- 每部分的关键论点

### Step 3: 写正文
1. **开头**（200-300字）：用故事/痛点/数据引入
2. **正文**（1000-2000字）：分章节展开，每章节有小标题
3. **结尾**（200-300字）：总结升华 + 行动号召

### Step 4: 优化
- 检查逻辑连贯性
- 检查"干货密度"（每300字至少一个有价值的信息点）
- 去 AI 腔处理

### Step 5: 补充
- 生成标题选项
- 写摘要
- 提供配图建议

## 注意事项
- 开头必须在前 3 行抓住注意力
- 善用小标题分割长文
- 每个章节控制在 300-500 字
- 关键信息加粗标注
WX_EOF
    print_success "✅ 03-tools/skills/wechat/write-wechat-article.md"

    # ===== Step 7: 生成协作层文件 =====
    print_step "Step 7: 生成协作层工作流"

    # --- 7.1 workflows README ---
    cat > "${FULL_PATH}/04-workflows/README.md" << WREADME_EOF
# 协作层 — 说明文档

> Skill 是单个能力，工作流是把 Skills 串起来的**剧本**。

## 核心原则
1. **先跑通一条，再复制思路**
2. **每条工作流解决一个高频场景**
3. **明确人机分工**: 每一步标注是 AI 做、人做、还是人机协作

## 推荐优先创建的工作流
1. **从想法到发布** — 最核心的内容生产流程
2. **一鱼多吃** — 一篇内容改编为多平台版本
3. **内容复盘** — 发布后的数据分析与知识沉淀
WREADME_EOF
    print_success "✅ 04-workflows/README.md"

    # --- 7.2 idea-to-publish.md ---
    cat > "${FULL_PATH}/04-workflows/idea-to-publish.md" << PUB_EOF
# 工作流：从想法到发布

> 版本：v1.0 | 更新：$(date +%Y-%m-%d)

## 概述
将一个内容想法转化为可发布的内容。

## 触发条件
有一个想分享的主题、工具、或观点。

## 输入
- 内容想法（一句话描述即可）
- 目标平台

## 输出
- 可直接发布的内容文案
- 标题选项
- 标签/摘要
- 配图建议

## 步骤链

\`\`\`
[想法]
  ↓
Step 1: 选题验证 ─────────── 🤖 AI + 👤 人
  │  AI: 搜索相关话题热度
  │  人: 确认选题角度
  ↓
Step 2: 素材收集 ─────────── 🤖 AI
  │  从 knowledge/materials/ 提取相关素材
  ↓
Step 3: 写文案 ───────────── 🤖 AI
  │  小红书: 调用 write-xhs-post Skill
  │  公众号: 调用 write-wechat-article Skill
  ↓
Step 4: 去 AI 腔 ─────────── 🤖 AI
  │  调用: de-ai-tone Skill
  ↓
Step 5: 生成标题 ─────────── 🤖 AI
  │  调用: generate-title Skill
  ↓
Step 6: 人工审核 ─────────── 👤 人
  │  审核: 内容准确性、个人观点
  │  微调: 修改不满意的表述
  ↓
[发布就绪]
\`\`\`

## 预计耗时
- **优化前**（手动）：60-180 分钟
- **优化后**（AI辅助）：15-60 分钟

## 优化记录
- v1.0 ($(date +%Y-%m-%d)): 初始版本
PUB_EOF
    print_success "✅ 04-workflows/idea-to-publish.md"

    # --- 7.3 repurpose-multi-platform.md ---
    cat > "${FULL_PATH}/04-workflows/repurpose-multi-platform.md" << MULTI_EOF
# 工作流：一鱼多吃 — 多平台分发

> 版本：v1.0 | 更新：$(date +%Y-%m-%d)

## 概述
将一篇内容改编为其他平台版本，最大化内容价值。

## 步骤链

\`\`\`
[原始内容]
  ↓
Step 1: 提取核心 ─────────── 🤖 AI
  │  提取: 核心观点、关键论据、金句
  ↓
Step 2: 平台适配 ─────────── 🤖 AI
  │  调用: repurpose-content Skill
  ↓
Step 3: 去 AI 腔 ─────────── 🤖 AI
  │  调用: de-ai-tone Skill
  ↓
Step 4: 人工审核 ─────────── 👤 人
  │  确保有增量价值
  ↓
[多平台版本就绪]
\`\`\`

## 预计耗时
- 每个平台版本：10-15 分钟
MULTI_EOF
    print_success "✅ 04-workflows/repurpose-multi-platform.md"

    # --- 7.4 content-review.md ---
    cat > "${FULL_PATH}/04-workflows/content-review.md" << REVIEW_EOF
# 工作流：内容复盘与知识沉淀

> 版本：v1.0 | 更新：$(date +%Y-%m-%d)

## 概述
发布内容后进行数据分析和经验沉淀，形成正向循环。

## 触发条件
内容发布 24-48 小时后，或每周固定时间。

## 步骤链

\`\`\`
[发布24-48h后]
  ↓
Step 1: 数据收集 ─────────── 👤 人
  │  从各平台导出数据
  ↓
Step 2: 数据分析 ─────────── 🤖 AI
  │  分析: 表现好的点、表现差的点
  ↓
Step 3: 归档内容 ─────────── 🤖 AI + 👤 人
  │  按模板归档到 02-knowledge/content/
  ↓
Step 4: 提取洞察 ─────────── 🤖 AI
  │  从评论中提取读者需求
  │  更新 audience_persona.md
  ↓
Step 5: 优化系统 ─────────── 👤 人
  │  更新 writing_style.md
  │  更新相关 Skill
  │  记录新选题想法
  ↓
[知识库更新完成]
\`\`\`

## 预计耗时
- 每篇复盘：10-15 分钟
- 每周汇总：30 分钟
REVIEW_EOF
    print_success "✅ 04-workflows/content-review.md"

    # ===== Step 8: 生成场景层文件 =====
    print_step "Step 8: 生成场景层配置"

    # --- 8.1 scenes README ---
    cat > "${FULL_PATH}/05-scenes/README.md" << SREADME_EOF
# 场景层 — 说明文档

> 前四层是通用底座，第五层是"你的皮肤"——把上面所有层组合成特定场景的流水线。

## 核心原则
1. **场景 = 特定目标 + 资源组合**
2. **场景可叠加**: 一个人可以同时有多个场景
3. **场景会演化**: 随着需求变化而新增、合并、或淘汰
SREADME_EOF
    print_success "✅ 05-scenes/README.md"

    # --- 8.2 content-production ---
    cat > "${FULL_PATH}/05-scenes/content-production/scene-content-production.md" << SCENE_EOF
# 场景：内容生产

> 版本：v1.0 | 更新：$(date +%Y-%m-%d)

## 场景定义
作为${ROLE}，高效地生产高质量内容并分发到${PLATFORMS}。

## 目标
- 周均产出：[目标篇数] 篇
- 效率目标：从想法到发布 < 30 分钟（短内容）/ < 2 小时（长内容）

## 资源映射

| 层级 | 使用的资源 |
|------|-----------|
| 身份层 | CLAUDE.md、writing_style.md |
| 知识层 | positioning.md、audience_persona.md、content归档、materials |
| 工具层 | write-xhs-post、write-wechat-article、de-ai-tone、generate-title |
| 协作层 | idea-to-publish、repurpose-multi-platform、content-review |

## 内容生产完整管线

\`\`\`
选题 → 创作 → 发布 → 复盘 → 选题（循环）
\`\`\`

详细流程参考 \`04-workflows/idea-to-publish.md\`

## 度量指标
| 指标 | 目标 |
|------|------|
| 周产出量 | [目标] 篇 |
| 平均创作时间 | 短内容 < 30min / 长内容 < 2h |
| AI 替代率 | 创作阶段 > 70% |
| 知识沉淀率 | 每篇内容都有归档 |

## 持续优化清单
- [ ] 每周复盘一次内容数据
- [ ] 每月更新一次 audience_persona.md
- [ ] 每季度更新一次 writing_style.md
- [ ] 发现新的高频需求时创建新 Skill
SCENE_EOF
    print_success "✅ 05-scenes/content-production/scene-content-production.md"

    # --- 8.3 learning ---
    cat > "${FULL_PATH}/05-scenes/learning/scene-learning.md" << LEARN_EOF
# 场景：持续学习

> 版本：v1.0 | 更新：$(date +%Y-%m-%d)

## 场景定义
作为${ROLE}，持续学习新知识、新工具、新趋势，并将学习成果转化为内容。

## 学习闭环
\`\`\`
发现新主题 → AI搜索整理 → 学习+笔记 → 沉淀到知识库 → 转化为内容 → 发布复盘
\`\`\`
LEARN_EOF
    print_success "✅ 05-scenes/learning/scene-learning.md"

    # ===== Step 9: 生成文档 =====
    print_step "Step 9: 生成使用指南"

    cat > "${FULL_PATH}/docs/setup-guide.md" << GUIDE_EOF
# AI-OS 使用指南

> **版本**: v1.0.0 | **初始化日期**: $(date +%Y-%m-%d)

---

## 🎉 恭喜！你的 AI 操作系统已初始化完成

以下是你的系统概览：

\`\`\`
${INSTALL_DIR}/
├── 01-identity/          ← 身份层（已个性化配置 ✅）
│   ├── CLAUDE.md
│   └── memory/
│       ├── user_profile.md
│       ├── writing_style.md
│       ├── ai_preferences.md
│       └── current_projects.md
├── 02-knowledge/         ← 知识层（模板已就绪，待填充）
├── 03-tools/             ← 工具层（5个预置 Skills ✅）
├── 04-workflows/         ← 协作层（3条预置工作流 ✅）
└── 05-scenes/            ← 场景层（2个预置场景 ✅）
\`\`\`

---

## 📋 接下来做什么？

### 第一步：完善身份层（30 分钟）⭐ 最重要

1. 打开 \`01-identity/CLAUDE.md\`，检查自动生成的信息是否准确
2. 打开 \`01-identity/memory/writing_style.md\`，粘贴 3-5 段你最满意的文字到"风格标本"
3. 打开 \`01-identity/memory/user_profile.md\`，补充你的核心能力和数据

> 💡 身份层是整个系统的地基。花 30 分钟认真填，后面所有环节都会受益。

### 第二步：填充知识层（1-2 小时）

1. 把最近 10 条原创内容归档到 \`02-knowledge/content/\` 对应平台文件夹
2. 使用 \`02-knowledge/content/_content_template.md\` 模板
3. 完善 \`02-knowledge/identity/positioning.md\` 中的内容定位
4. 在 \`02-knowledge/materials/golden_quotes.md\` 收集金句

### 第三步：试用 Skills（1 小时）

1. 选一个你想写的选题
2. 让 AI 调用 \`03-tools/skills/xiaohongshu/write-xhs-post.md\` 或 \`wechat/write-wechat-article.md\`
3. 检查输出是否符合你的风格
4. 根据效果调整 Skill 文件

### 第四步：跑通工作流（持续）

1. 按 \`04-workflows/idea-to-publish.md\` 的步骤执行一次完整的内容生产
2. 记录每步的实际耗时
3. 根据体验优化工作流

---

## 🔧 日常使用

### 写一篇内容
1. 告诉 AI 你的选题
2. AI 自动读取风格指南和素材
3. AI 写初稿 → 去 AI 腔 → 生成标题
4. 你审核、微调、发布
5. 发布后归档到知识库

### 一篇内容多发
1. 选一篇已发布的内容
2. AI 自动适配目标平台
3. 你审核、发布

---

## 📅 维护清单

### 每周
- [ ] 复盘本周内容数据
- [ ] 归档新发布的内容

### 每月
- [ ] 更新读者画像
- [ ] 更新金句库

### 每季度
- [ ] 更新内容定位
- [ ] 更新风格指南
- [ ] 评估是否需要新增 Skill 或场景

---

## ❓ 常见问题

**Q: 我需要一次填完所有文件吗？**
A: 不需要。先完善身份层，然后边用边填充知识库。

**Q: 这些文件放在哪里？**
A: 放在你的 SOLO 工作目录下。SOLO 每次启动时会读取 CLAUDE.md。

**Q: 换了 AI 工具怎么办？**
A: 这套系统是纯 Markdown，任何支持读取文件的 AI 工具都能用。

**Q: Skill 和 Prompt 有什么区别？**
A: Prompt 是一次性指令，Skill 是可复用的"肌肉记忆"——包含触发条件、执行步骤、注意事项。

---

## 📞 获取帮助

如有问题，请联系 AI-OS 提供者：[联系方式]
GUIDE_EOF
    print_success "✅ docs/setup-guide.md"

    # --- 9.2 Main README ---
    cat > "${FULL_PATH}/README.md" << MAINREADME_EOF
# AI-OS 个人 AI 操作系统

> **版本**: v1.0.0 | **初始化日期**: $(date +%Y-%m-%d)
> **所有者**: ${NICKNAME} | **身份**: ${ROLE} | **领域**: ${FIELD}

## 这是什么？

一套由 Markdown 文档组成的个人 AI 协作框架，让 AI 工具能够：
- **认识你**（身份层）— 知道你是谁、你的风格、你的偏好
- **理解你**（知识层）— 调用你的历史内容、素材、决策记录
- **替你干活**（工具层）— 使用预定义的 Skills 执行具体任务
- **串联流程**（协作层）— 按工作流自动完成多步骤任务
- **服务场景**（场景层）— 针对特定场景组合所有能力

## 五层架构

\`\`\`
01-identity/     身份层 — AI 认识你的"名片"
02-knowledge/    知识层 — 你的知识"燃料库"
03-tools/        工具层 — AI 的"肌肉记忆"
04-workflows/    协作层 — 串联技能的"剧本"
05-scenes/       场景层 — 垂直输出"管线"
\`\`\`

## 快速开始

📖 **阅读使用指南**: [docs/setup-guide.md](docs/setup-guide.md)

## 核心理念

1. **纯 Markdown，工具无关** — 可迁移到任何 AI 工具
2. **做一次，用一万次** — Skill 是肌肉记忆
3. **先跑通一条，再复制思路** — 不要一次设计太多
4. **持续沉淀，越来越聪明** — 知识库是最大的资产
MAINREADME_EOF
    print_success "✅ README.md"

    # ===== 完成 =====
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                                                  ║${NC}"
    echo -e "${GREEN}║     🎉 AI-OS 初始化完成！                        ${GREEN}║${NC}"
    echo -e "${GREEN}║                                                  ║${NC}"
    echo -e "${GREEN}║     安装路径: ${FULL_PATH}       ${GREEN}║${NC}"
    echo -e "${GREEN}║                                                  ║${NC}"
    echo -e "${GREEN}║     已生成文件:                                   ${GREEN}║${NC}"
    echo -e "${GREEN}║     • 身份层: 5 个文件（已个性化配置）            ${GREEN}║${NC}"
    echo -e "${GREEN}║     • 知识层: 5 个模板文件                       ${GREEN}║${NC}"
    echo -e "${GREEN}║     • 工具层: 5 个预置 Skills                    ${GREEN}║${NC}"
    echo -e "${GREEN}║     • 协作层: 3 条预置工作流                     ${GREEN}║${NC}"
    echo -e "${GREEN}║     • 场景层: 2 个预置场景                       ${GREEN}║${NC}"
    echo -e "${GREEN}║     • 文档: 使用指南 + README                    ${GREEN}║${NC}"
    echo -e "${GREEN}║                                                  ║${NC}"
    echo -e "${GREEN}║     📖 下一步: 阅读 docs/setup-guide.md          ${GREEN}║${NC}"
    echo -e "${GREEN}║                                                  ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════╝${NC}"
    echo ""
}

main "$@"
