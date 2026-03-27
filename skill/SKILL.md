# AI 接口测试工作流 Skill

## 概述

这是一个面向 AI Agent 的接口测试工作流 Skill，帮助 AI Agent 自动执行 Java 后端接口测试。

## 触发场景

当用户请求以下操作时触发此 Skill：
- "测试接口"
- "测试 API"
- "接口测试"
- "API 测试"
- "测试登录接口"
- "测试用户模块"

## 使用方法

### 基本调用

```markdown
请使用 /skill ai-api-workflow

用户请求：测试 POST /api/user/login 接口
Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
BaseUrl: http://localhost:8080
```

### 输入要求

| 参数 | 必需 | 说明 |
|------|------|------|
| token | 是 | 用户提供的 Bearer Token |
| baseUrl | 是 | API 基础 URL |
| 目标接口 | 否 | 要测试的接口路径 |

## 工作流

1. **接收输入**：获取 token、baseUrl、目标接口
2. **定位接口**：查找接口定义
3. **读取定义**：从 OpenAPI 或源码获取信息
4. **生成用例**：生成测试用例
5. **执行测试**：发送请求
6. **输出报告**：返回 JSON 格式结果

## 核心原则

- token 必须由用户提供，本 Skill 不实现自动获取
- 优先使用 OpenAPI 定义
- 禁止高风险操作（DELETE）除非确认
- 默认只读操作

## 文档

详细工作流请参考：
- `docs/ai接口测试工作流.md`
- `docs/使用说明.md`
- `docs/设计边界与风险.md`

## 示例

### 示例 1：测试单个接口

```
用户：测试登录接口
Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
BaseUrl: http://localhost:8080
```

### 示例 2：测试模块

```
用户：测试用户模块
Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
BaseUrl: http://localhost:8080
模块：UserController
```

## 限制

- 不支持 WebSocket
- 不支持文件上传（V1）
- 不支持并发测试（V1）
- 不支持定时任务（V1）

## Claude Code 集成

### 方式一：使用 skill 命令

在 Claude Code 中可以直接调用此 skill：

```
/skill ai-api-test
```

### 方式二：配置自动启用

在项目的 `.claude/settings.json` 中添加：

```json
{
  "enabledSkills": ["ai-api-test"]
}
```

### 方式三：直接使用

当你在 Claude Code 中工作，直接告诉它：

```
请测试 POST /api/user/login 接口
Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
BaseUrl: http://localhost:8080
```

Claude Code 会读取项目中的 `docs/ai接口测试工作流.md` 了解工作流规范。

## 版本

- V1：核心工作流，基础测试用例生成