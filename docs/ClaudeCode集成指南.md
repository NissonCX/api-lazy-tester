# Claude Code 集成指南

本文档说明如何在 Claude Code 中使用本项目的接口测试工作流。

## 方式一：在项目中启用（推荐）

### Step 1: 复制 skill 配置

将本项目的 `skill/claude-code.json` 复制到你的项目根目录：

```bash
# 方式 A：手动复制
cp skill/claude-code.json 你的项目路径/.claude/

# 方式 B：克隆本项目后链接
ln -s $(pwd)/skill/claude-code.json 你的项目路径/.claude/
```

### Step 2: 创建 settings.json

在 `.claude/` 目录下创建或编辑 `settings.json`：

```json
{
  "enabledSkills": ["ai-api-test"]
}
```

### Step 3: 使用

在 Claude Code 中直接告诉它：

```
请测试 POST /api/user/login 接口
Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
BaseUrl: http://localhost:8080
```

## 方式二：全局配置

如果你希望在所有项目中使用，可以配置全局 settings。

### 找到全局 settings 位置

```
~/.claude/settings.json  # macOS/Linux
%USERPROFILE%\.claude\settings.json  # Windows
```

### 添加 skill

```json
{
  "skills": [
    {
      "name": "ai-api-test",
      "description": "AI 接口测试工作流"
    }
  ]
}
```

## 方式三：直接对话（无需配置）

即使不做任何配置，你也可以直接与 Claude Code 对话：

```
用户：测试 POST /api/user/login 接口
Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
BaseUrl: http://localhost:8080
项目中有 openapi.yaml 文件
```

Claude Code 会：
1. 读取你项目中的 `openapi.yaml`
2. 找到 `/api/user/login` 接口定义
3. 生成测试用例
4. 执行测试
5. 输出 JSON 格式报告

## 关键：让 Claude 读取工作流规范

为了让 Claude Code 正确执行工作流，你需要让它读取规范文档：

### 方法 1：克隆项目

```bash
git clone https://github.com/NissonCX/ai-api-workflow.git
```

然后告诉 Claude：

```
请先阅读 /Users/nissoncx/workplace/code/skill-writer/docs/ai接口测试工作流.md
然后测试 POST /api/user/login 接口
Token: xxx
BaseUrl: http://localhost:8080
```

### 方法 2：复制文档

将 `docs/` 目录复制到你的项目：

```bash
cp -r docs/ai接口测试工作流.md 你的项目/docs/
```

### 方法 3：使用 CLAUDE.md

在你的项目根目录创建 `CLAUDE.md`，添加：

```markdown
## 接口测试

当用户要求测试接口时，请阅读 docs/ai接口测试工作流.md 了解工作流规范。
```

## 完整示例

### 场景：测试本地 Spring Boot 项目

1. **你的 Spring Boot 项目结构**：

```
my-spring-boot-project/
├── src/main/java/.../
├── openapi.yaml          # Swagger 导出
└── .claude/
    ├── settings.json     # 启用 skill
    └── claude-code.json  # 复制过来的 skill
```

2. **settings.json 内容**：

```json
{
  "enabledSkills": ["ai-api-test"]
}
```

3. **在 Claude Code 中对话**：

```
请测试用户模块的所有接口
Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
BaseUrl: http://localhost:8080
```

4. **Claude Code 会**：

   - 读取 openapi.yaml
   - 找到 UserController 的所有接口
   - 生成测试用例
   - 执行测试
   - 输出 JSON 报告

## 故障排除

### Q：skill 不生效？

检查 `.claude/settings.json` 格式是否正确：

```json
{
  "enabledSkills": ["ai-api-test"]
}
```

### Q：找不到接口定义？

确保 OpenAPI 文件存在：
- `openapi.yaml`
- `openapi.json`
- `swagger.yaml`
- `swagger.json`

### Q：token 错误？

确保 token 格式正确：
- 需要包含完整的 Bearer Token
- 不要包含换行符

### Q：无法连接？

- 确认服务已启动：`curl http://localhost:8080/actuator/health`
- 确认 baseUrl 正确

## 相关文档

- [AI 接口测试工作流](docs/ai接口测试工作流.md)
- [使用说明](docs/使用说明.md)
- [设计边界与风险](docs/设计边界与风险.md)