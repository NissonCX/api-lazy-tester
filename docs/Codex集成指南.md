# Codex 集成指南

本文档说明如何在 OpenAI Codex 中使用本项目的接口测试工作流。

## 前提条件

Codex 是 OpenAI 推出的 AI 编程工具，与 Claude Code 类似但基于 OpenAI 模型。

## 集成方式

### 方式一：使用 OpenAI YAML 格式

本项目已提供 `skill/agents/openai.yaml`，可以将此配置导入 Codex。

### 方式二：配置自定义指令

在 Codex 项目中配置自定义指令，让它读取工作流规范：

1. 找到 Codex 的自定义指令配置
2. 添加以下内容：

```markdown
## 接口测试工作流

当用户要求测试接口时，执行以下工作流：
1. 读取项目的 OpenAPI/Swagger 文件
2. 定位要测试的接口
3. 生成测试用例
4. 执行测试
5. 输出 JSON 格式报告

参考规范：docs/ai接口测试工作流.md
```

### 方式三：直接对话

```
测试 POST /api/user/login 接口
Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
BaseUrl: http://localhost:8080
```

## OpenAI YAML 配置

本项目提供的 `skill/agents/openai.yaml` 包含：

- skill 名称和描述
- 使用说明
- 核心约束
- conversation starters

### 如何使用 YAML

1. 复制 `skill/agents/openai.yaml` 内容
2. 在 Codex 中创建新的 custom instructions
3. 粘贴配置内容

## 与 Claude Code 的区别

| 特性 | Claude Code | Codex |
|------|-------------|-------|
| Skill 格式 | JSON | YAML |
| 配置位置 | .claude/settings.json | 自定义指令 |
| 触发方式 | /skill 命令 | 自定义指令 |

## 测试验证

在 Codex 中测试：

```markdown
请测试登录接口
Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
BaseUrl: http://localhost:8080
```

预期行为：
1. Codex 读取 openapi.yaml
2. 找到 /api/user/login 接口
3. 生成 3-4 个测试用例
4. 执行测试
5. 输出 JSON 报告

## 常见问题

### Q：Codex 不执行测试？

确保自定义指令已生效，尝试重新加载项目。

### Q：如何验证配置？

可以在 Codex 中输入：

```
请告诉我如何测试 POST /api/user/login 接口
```

如果配置正确，Codex 会按照工作流回答。