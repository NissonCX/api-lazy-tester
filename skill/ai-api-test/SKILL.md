---
name: ai-api-test
description: AI 接口测试 - 测试 Java 后端 API 接口。触发：用户请求测试接口、执行 API 测试、接口测试
argument-hint: <method> <url> [token] [body]
disable-model-invocation: true
allowed-tools: Bash, Read, Glob, Grep
effort: medium
---

# AI 接口测试工作流

当用户请求测试接口时，按以下流程执行。

## 必要输入（用户必须提供）

- `token`：Bearer Token
- `baseUrl`：API 基础 URL，如 https://api.example.com
- `目标接口`：要测试的接口路径，如 POST /api/user/login

## 自动发现项目接口

!`find . -type f \( -name "openapi.yaml" -o -name "openapi.json" -o -name "swagger.yaml" -o -name "swagger.json" -o -name "*Controller.java" \) 2>/dev/null | head -10`

## 执行流程

### Step 1：定位接口

AI 需要找到接口定义，按优先级：
1. glob 查找 openapi*.yaml / openapi*.json
2. glob 查找 *Controller.java

### Step 2：执行测试

使用脚本执行测试（从技能目录引用）：

```bash
# 基础调用
${CLAUDE_SKILL_DIR}/scripts/test-api.sh -m POST -u "http://your-api-host:port/api/login" -t "Bearer xxx" -b '{"username":"test"}'

# 带超时
${CLAUDE_SKILL_DIR}/scripts/test-api.sh -m GET -u "http://your-api-host:port/api/user/1" -t "Bearer xxx" -T 60

# 简单输出
${CLAUDE_SKILL_DIR}/scripts/test-api.sh -m GET -u "http://your-api-host:port/api/xxx" -t "Bearer xxx" -s simple
```

### Step 3：输出报告

测试结果输出 JSON 格式：

```json
{
  "request": {"method": "POST", "url": "..."},
  "response": {"status": 200, "time": 0.123, "body": {...}},
  "result": "通过"
}
```

## 测试用例生成规则

### 正常用例
生成最小合法请求：
```json
{"username": "a", "password": "123456"}
```

### 边界用例（根据 Bean Validation 注解）
| 注解 | 测试值 |
|------|--------|
| @NotNull | null / 不传 |
| @Size(min=2) | "a" |
| @Min(0) | -1 |
| @Max(100) | 101 |
| @Pattern(regexp) | "abc" |

### 负例
- 空字符串 ""
- 空对象 {}
- 错误格式

## 重要约束

1. **token 必须由用户提供** - 禁止自动获取
2. **禁止执行 DELETE** - 除非用户明确确认
3. **禁止批量操作**
4. **默认只读操作优先**
5. **默认超时 30 秒** - 可用 -T 参数调整

## 脚本参数

| 参数 | 说明 | 示例 |
|------|------|------|
| -m | HTTP 方法 | GET/POST/PUT/DELETE |
| -u | 完整 URL | https://api.com/api/login |
| -t | Token | Bearer xxx |
| -b | 请求体 JSON | '{"key":"value"}' |
| -H | 自定义头 | X-Request-ID: test |
| -s | 输出格式 | json / simple |
| -T | 超时秒数 | 30 |

## 快速验证

使用公开 API 快速验证脚本可用：

```bash
${CLAUDE_SKILL_DIR}/scripts/test-api.sh -m GET -u "https://jsonplaceholder.typicode.com/posts/1" -t "test"
```

## 相关文档

- [快速开始](../../docs/快速开始.md)
- [AI 接口测试工作流](../../docs/ai接口测试工作流.md)
- [使用说明](../../docs/使用说明.md)
- [设计边界与风险](../../docs/设计边界与风险.md)