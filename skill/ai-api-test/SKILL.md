---
name: ai-api-test
description: AI 接口测试 - 测试 Java 后端 API 接口。触发场景：用户请求测试接口、执行 API 测试、接口测试
disable-model-invocation: true
allowed-tools: Bash, Read, Glob, Grep
---

# AI 接口测试工作流

当用户请求测试接口时，按以下流程执行：

## 必要输入

用户需要提供：
- `token`：Bearer Token（用户手动提供）
- `baseUrl`：API 基础 URL，如 http://localhost:8080
- `目标接口`：要测试的接口路径，如 POST /api/user/login

## 执行流程

### Step 1：查找接口定义

AI 需要找到接口定义，按优先级：
1. glob 查找 openapi.yaml / openapi.json / swagger.yaml / swagger.json
2. glob 查找 *Controller.java

### Step 2：执行测试

使用 scripts/test-api.sh 执行测试：

```bash
# 基本用法
./scripts/test-api.sh -m POST -u http://localhost:8080/api/user/login \
  -t "Bearer eyJhbGciOiJIUzI1NiIs..." -b '{"username":"test","password":"123456"}'

# 带查询参数
./scripts/test-api.sh -m GET -u "http://localhost:8080/api/user/1" \
  -t "Bearer xxx"

# 带自定义头
./scripts/test-api.sh -m POST -u http://localhost:8080/api/xxx \
  -t "Bearer xxx" -H "X-Request-ID: test-001" -b '{}'
```

### Step 3：输出报告

测试结果输出 JSON 格式，包含：
- 请求信息
- 响应状态码
- 响应体
- 响应时间
- 测试结果

## 测试用例生成

### 正常用例
生成最小合法请求：
```json
{"username": "a", "password": "123456"}
```

### 边界用例
根据 Bean Validation 注解：
- @NotNull → 传 null 或不传
- @Size(min=2) → 传 1 个字符
- @Min(0) → 传 -1

### 负例
- 空字符串 ""
- 空对象 {}
- 错误格式

## 重要约束

1. **token 必须由用户提供** - 禁止自动获取
2. **禁止执行 DELETE** - 除非用户明确确认
3. **禁止批量操作**
4. **默认只读操作优先**

## 脚本参数说明

| 参数 | 说明 |
|------|------|
| -m | HTTP 方法：GET/POST/PUT/DELETE |
| -u | 完整 URL |
| -t | Authorization Token |
| -b | 请求体 JSON |
| -H | 自定义请求头（可多次使用）|
| -s | 输出格式：json（默认）或 simple |

## 相关文档

- [AI 接口测试工作流](../docs/ai接口测试工作流.md)
- [使用说明](../docs/使用说明.md)
- [设计边界与风险](../docs/设计边界与风险.md)