# AI IDE 接口测试工作流

提供一套面向 AI IDE 的 Java 后端接口自动测试工作流，支持读取 Swagger/OpenAPI、Controller、DTO 生成测试用例。

## 适用场景

- 个人开发者日常 API 接口验证
- AI Agent 辅助接口测试
- 快速冒烟测试
- 接口契约验证

## 工作流核心

```
用户手动提供 token → AI 读取接口定义 → 生成测试用例 → 执行测试 → 输出报告
```

## 快速开始

请阅读 [docs/使用说明.md](docs/使用说明.md) 了解详细使用方法。

## 文档

- [项目介绍](docs/项目介绍.md)
- [AI 接口测试工作流](docs/ai接口测试工作流.md)
- [使用说明](docs/使用说明.md)
- [设计边界与风险](docs/设计边界与风险.md)

## 为什么这个项目

传统的 API 测试工具需要手动配置，而 AI Agent 虽然能理解代码，但缺乏一套系统化的测试工作流。本项目定义了 AI Agent 执行接口测试的规范流程，让 AI 能够：

1. 读取 OpenAPI/Swagger 定义
2. 理解 Controller 和 DTO 结构
3. 生成合理的测试用例
4. 执行测试并输出结构化结果

## 核心原则

- **token 由用户提供**：不实现自动获取 token 功能
- **先可用后增强**：V1 聚焦核心工作流
- **强调规范而非工具**：重在定义工作流规范
- **安全优先**：默认禁止高风险写操作

## Claude Code 集成

在 Claude Code 中使用此工作流：

### 方式一：直接对话

```
请测试 POST /api/user/login 接口
Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
BaseUrl: http://localhost:8080
```

### 方式二：使用 skill 命令

```
/skill ai-api-test
```

### 方式三：配置自动启用

在项目的 `.claude/settings.json` 中添加：

```json
{
  "enabledSkills": ["ai-api-test"]
}
```

详细说明见 [skill/SKILL.md](skill/SKILL.md)

## License

MIT License