# Codex 集成指南

本文档说明如何在 OpenAI Codex 中使用本项目的接口测试工作流。

## 前提条件

- Codex 已安装并配置
- 项目已克隆到本地

## 快速开始

### 方式一：使用内置 Skill（推荐）

Codex 已自动加载 `skill/codex-api-tester/SKILL.md`，可以直接使用：

```
测试我新写的接口
Token: Bearer xxx
BaseUrl: http://localhost:8080
```

### 方式二：导入 Agent 配置

复制 `skill/codex-api-tester/agent.yaml` 内容到 Codex 的自定义指令中：

1. 打开 Codex 设置 → Custom Instructions
2. 粘贴 `agent.yaml` 内容
3. 保存并重新加载项目

### 方式三：直接对话

```
测试 POST /api/user/login
Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
BaseUrl: http://localhost:8080
```

## 文件说明

| 文件 | 用途 |
|------|------|
| `skill/codex-api-tester/SKILL.md` | Codex Skill 定义 |
| `skill/codex-api-tester/agent.yaml` | Agent 配置文件 |
| `skill/codex-api-tester/instructions.md` | 详细使用说明 |

## 与 Claude Code 的区别

| 特性 | Claude Code | Codex |
|------|-------------|-------|
| Skill 格式 | YAML (SKILL.md) | YAML (SKILL.md) |
| disable-model-invocation | true | false |
| 执行方式 | 直接调用脚本 | 直接调用脚本 |

## 测试验证

```bash
# 快速验证脚本可用
./skill/api-lazy-tester/scripts/test-api.sh \
  -m GET \
  -u "https://jsonplaceholder.typicode.com/posts/1" \
  -t "test"
```

## 常见问题

### Q：Codex 不执行测试？

确保在 Custom Instructions 中正确配置了 agent.yaml 内容。

### Q：如何验证配置？

在 Codex 中输入：
```
请告诉我如何测试 POST /api/user/login 接口
```

如果配置正确，Codex 会按照工作流回答。