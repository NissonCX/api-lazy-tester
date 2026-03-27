# AGENTS.md

本文档是 AI Agent 的技术规范文档。

## 项目背景

这是一个开源规范项目，定义了 AI Agent 执行 Java 后端接口测试的工作流程。

## Agent 工作流程

### Step 1: 接收任务

用户需要提供：
- token（必需）
- baseUrl（必需）
- 目标接口/模块（可选）

### Step 2: 信息收集

按优先级读取信息源：
1. OpenAPI / Swagger 文件（.yaml / .json）
2. Controller 源码
3. DTO / Entity 源码

### Step 3: 解析接口定义

提取：
- 请求方法（GET/POST/PUT/DELETE）
- 请求路径
- 参数（路径、查询、请求头、请求体）
- 响应状态码和结构

### Step 4: 生成测试用例

生成规则：
- 最小合法请求（正常用例）
- 边界值请求（边界用例）
- 异常请求（负用例）

### Step 5: 执行测试

使用 curl 或 HTTP 客户端执行请求：
```bash
curl -X POST http://localhost:8080/api/user/login \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <token>" \
  -d '{"username":"test","password":"123456"}'
```

### Step 6: 输出报告

生成 JSON 格式报告：
```json
{
  "接口": "POST /api/user/login",
  "用例数": 4,
  "通过": 4,
  "结果": [...]
}
```

## 关键约束

### 输入约束

| 输入 | 必须 | 说明 |
|------|------|------|
| token | 是 | 用户手动提供 |
| baseUrl | 是 | API 基础 URL |
| 目标接口 | 否 | 可指定或不指定 |
| OpenAPI | 否 | 优先使用 |

### 操作约束

- DELETE 操作需要确认
- 批量操作需要确认
- 生产环境操作需要确认

### 输出约束

- 使用 JSON 格式
- 包含请求、响应、结果
- 标注信息来源

## 信息源优先级

```
1. OpenAPI/Swagger 文件（最高优先级）
   ↓
2. Controller 源码
   ↓
3. DTO/Entity 源码
   ↓
4. 枚举/常量
```

## 测试用例生成规则

### 正常用例

```json
{
  "username": "a",
  "password": "123456"
}
```

### 边界用例

| 参数约束 | 测试值 |
|----------|--------|
| @NotNull | null 或不传 |
| @NotEmpty | "" |
| @Size(min=2) | "a" |
| @Min(0) | -1 |
| @Max(100) | 101 |

## 错误处理

| 错误类型 | 处理方式 |
|----------|----------|
| 无法定位接口 | 请求用户提供更多信息 |
| 无法连接 | 提示检查服务 |
| 响应异常 | 记录原始响应 |
| 解析失败 | 使用通用测试 |

## 禁止操作

1. 不自动获取 token
2. 不存储 token
3. 不执行未确认的 DELETE
4. 不执行批量操作
5. 不上传数据到第三方

## 扩展点

Agent 可根据需要扩展：
- 测试报告格式（添加 HTML、Markdown 支持）
- 断言库（添加 JSONAssert、Hamcrest）
- 并发测试（添加压力测试）
- 录制回放（添加请求录制）

## 相关文件

- `docs/ai接口测试工作流.md` - 详细工作流规范
- `docs/使用说明.md` - 使用指南
- `docs/设计边界与风险.md` - 边界和风险说明
- `examples/示例输入.md` - 输入示例
- `examples/示例输出.md` - 输出示例