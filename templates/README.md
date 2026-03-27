# 测试输入模板

本目录存放测试输入模板文件。

## 模板列表

### 1. 单接口测试模板

```json
{
  "token": "your-token-here",
  "baseUrl": "http://localhost:8080",
  "target": {
    "method": "POST",
    "path": "/api/user/login"
  }
}
```

### 2. 模块测试模板

```json
{
  "token": "your-token-here",
  "baseUrl": "http://localhost:8080",
  "target": {
    "type": "controller",
    "name": "UserController"
  }
}
```

### 3. 完整测试模板

```json
{
  "token": "your-token-here",
  "baseUrl": "http://localhost:8080",
  "target": {
    "type": "module",
    "name": "用户模块"
  },
  "options": {
    "reportFormat": "json",
    "includeDetails": true,
    "timeout": 30000
  }
}
```

## 使用方法

1. 复制模板到新文件
2. 替换 token 和 baseUrl
3. 指定目标接口或模块
4. 交由 AI Agent 执行测试