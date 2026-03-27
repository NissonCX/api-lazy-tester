# OpenAI Codex API Testing Skill

name: api-lazy-tester
description: 自动测试后端 API 接口。发现新接口、生成测试用例、执行测试、输出报告。

## 核心能力

- 自动发现新接口（git diff）
- 读取 OpenAPI/Swagger 定义
- 生成测试用例（正常+边界+负例）
- 自动执行 HTTP 请求测试
- 输出结构化测试报告

## 使用场景

- 用户说"测试新写的接口"
- 用户指定具体接口测试
- 批量测试某个模块

## 工作流

### Step 1: 获取 baseUrl

优先级：
1. 用户提供的 BaseUrl
2. 读取 application.yml 中的 server.port + context-path
3. 默认 http://localhost:8080

### Step 2: 发现新接口

```bash
# 找出新增/修改的文件
git diff --name-only HEAD~1
git diff --name-only origin/main...HEAD
```

找到新增的 Controller.java 文件。

### Step 3: 读取接口定义

优先级：
1. OpenAPI/Swagger 文件 (openapi.yaml, openapi.json, swagger.yaml)
2. Controller 源码中的 @RequestMapping, @GetMapping, @PostMapping 等注解
3. DTO 源码中的验证注解 (@NotNull, @Size, @Min 等)

### Step 4: 生成测试用例

根据接口定义生成：
- 正常用例：最小合法数据
- 边界用例：根据验证注解生成
- 负例：空字符串、空对象、null 值

### Step 5: 执行测试

使用脚本执行 HTTP 请求：

```bash
./skill/api-lazy-tester/scripts/test-api.sh \
  -m POST \
  -u "http://localhost:8080/api/login" \
  -t "Bearer 你的token" \
  -b '{"username":"test"}' \
  -T 30
```

参数说明：
- -m: HTTP 方法 (GET/POST/PUT/DELETE)
- -u: 完整 URL
- -t: Token (Bearer xxx)
- -b: 请求体 JSON
- -T: 超时秒数 (默认 30)
- -s: 输出格式 (json/simple，默认 json)

### Step 6: 输出报告

JSON 格式：
```json
{
  "接口": "POST /api/user/login",
  "结果": "通过 3/3",
  "用例": [
    {"名称": "正常登录", "状态码": 200, "结果": "通过"},
    {"名称": "用户名为空", "状态码": 400, "结果": "通过"},
    {"名称": "密码错误", "状态码": 401, "结果": "通过"}
  ]
}
```

## 重要约束

1. **token 必须由用户提供** - 禁止自动获取
2. **禁止执行 DELETE** - 除非用户明确确认
3. **先测试读接口** - GET 优先
4. **默认超时 30 秒**

## 用户输入处理

| 用户输入 | 处理方式 |
|----------|----------|
| 测试新接口 | git diff + 自动发现 |
| 测试 POST /api/xxx | 直接测试指定接口 |
| 测试 localhost:8080 | 使用提供的 baseUrl |

## 快速验证

```bash
./skill/api-lazy-tester/scripts/test-api.sh \
  -m GET \
  -u "https://jsonplaceholder.typicode.com/posts/1" \
  -t "test"
```