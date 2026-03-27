---
name: api-lazy-tester
description: 接口测试 - 帮懒人测试接口。触发：用户请求测试接口、测试新写的接口
argument-hint: [描述要测试的接口或模块]
disable-model-invocation: false
allowed-tools: Bash, Read, Glob, Grep
effort: medium
---

# Codex API 测试工作流

当用户请求测试接口时，按以下流程执行。

## 自动获取 baseUrl

1. 用户提供的 BaseUrl
2. 读取 application.yml: `grep -E "port:" src/main/resources/application.yml`
3. 默认 `http://localhost:8080`

## 发现新接口

```bash
git diff --name-only HEAD~1 | grep -i controller
```

## 读取接口定义

优先级：OpenAPI > Controller 源码 > DTO 验证注解

## 生成测试用例

- 正常用例：最小合法数据
- 边界用例：根据 @NotNull、@Size、@Min 等注解
- 负例：空字符串、null、错误数据

## 执行测试

```bash
./skill/api-lazy-tester/scripts/test-api.sh -m POST \
  -u "http://localhost:8080/api/login" \
  -t "Bearer 用户token" \
  -b '{"username":"test"}' -T 30
```

## 输出报告

```json
{
  "接口": "POST /api/user/login",
  "结果": "通过 3/3",
  "用例": [...]
}
```

## 约束

1. token 必须由用户提供
2. 禁止自动 DELETE（除非确认）
3. 先测 GET 再测 POST/PUT
4. 超时默认 30 秒