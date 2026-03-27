---
name: ai-api-test
description: AI 接口测试 - 测试刚写好的 Java 后端 API 接口。触发：用户请求测试接口、测试新写的接口、接口测试
argument-hint: [描述要测试的接口或模块]
disable-model-invocation: true
allowed-tools: Bash, Read, Glob, Grep
effort: medium
---

# AI 接口测试工作流

当用户请求测试接口时，按以下流程执行。

## 完整工作流（自动）

### Step 1: 发现新接口

当用户说"测试新写的接口"时，首先执行：

```bash
# 找出本次新增/修改的文件
git diff --name-only HEAD~1

# 或对比分支
git diff --name-only main...HEAD
```

找到新增的 *Controller.java 文件，重点关注。

### Step 2: 读取接口定义

按优先级读取接口信息：

**优先级 1: OpenAPI/Swagger**
```bash
find . -type f \( -name "openapi.yaml" -o -name "openapi.json" -o -name "swagger.yaml" -o -name "swagger.json" \) 2>/dev/null
```

**优先级 2: Controller 源码**
```bash
# 找到新写的 Controller
git diff --name-only HEAD~1 | grep -i controller

# 读取新增的接口方法
grep -A 10 "@RequestMapping\|@GetMapping\|@PostMapping\|@PutMapping\|@DeleteMapping" 新增的Controller文件
```

**优先级 3: DTO 源码**
```bash
# 找到相关的 DTO
git diff --name-only HEAD~1 | grep -i -E "(DTO|Entity|Request|Response)"
```

### Step 3: 生成测试用例

根据接口定义生成测试数据：

```javascript
// 正常用例 - 最小合法数据
{"username": "a", "password": "123456"}

// 边界用例 - 根据注解
// @NotNull → 传 null / 不传该字段
// @Size(min=2) → 传 "a"（1字符）
// @Min(0) → 传 -1
// @Pattern(regexp="^\\d+$") → 传 "abc"

// 负例
// 空字符串 ""
// 空对象 {}
```

### Step 4: 执行测试

使用脚本执行请求：

```bash
${CLAUDE_SKILL_DIR}/scripts/test-api.sh \
  -m POST \
  -u "http://localhost:8080/api/xxx" \
  -t "Bearer 用户提供的token" \
  -b '{"测试数据"}' \
  -T 30
```

### Step 5: 输出报告

测试结果输出为可读格式：

```
✅ POST /api/user/login - 通过 3/3
├── 正常登录 - 200 ✓
├── 用户名为空 - 400 ✓
└── 密码错误 - 401 ✓
```

## 必要输入（用户必须提供）

- `token`：Bearer Token（必须）
- `baseUrl`：API 地址，如 http://localhost:8080
- 可选：具体接口路径（如不提供则自动发现）

## 重要约束

1. **token 必须由用户提供** - 禁止自动获取
2. **禁止执行 DELETE** - 除非用户明确确认
3. **先测试读接口** - GET 优先，再测写接口
4. **默认超时 30 秒**

## 脚本参数速查

| 参数 | 说明 | 示例 |
|------|------|------|
| -m | HTTP 方法 | GET/POST/PUT/DELETE |
| -u | 完整 URL | https://api.com/api/login |
| -t | Token | Bearer xxx |
| -b | 请求体 | '{"key":"value"}' |
| -T | 超时秒 | 30 |

## 快速验证

```bash
# 先验证脚本可用
${CLAUDE_SKILL_DIR}/scripts/test-api.sh -m GET -u "https://jsonplaceholder.typicode.com/posts/1" -t "test"
```

## 相关文档

- [快速开始](../../docs/快速开始.md)
- [AI 接口测试工作流](../../docs/ai接口测试工作流.md)
- [使用说明](../../docs/使用说明.md)