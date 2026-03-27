<p align="center">
  <a href="https://github.com/NissonCX/api-lazy-tester">
    <img src="https://api-lazy-tester.github.io/logo.png" alt="api-lazy-tester" width="120"/>
  </a>
</p>

<h1 align="center">api-lazy-tester</h1>

<p align="center">
  面向 Claude Code & Codex 的 AI 接口测试工具
  <br>
  <a href="https://github.com/NissonCX/api-lazy-tester/stargazers"><img src="https://img.shields.io/github/stars/NissonCX/api-lazy-tester?style=flat&color=orange" alt="stars"></a>
  <a href="https://github.com/NissonCX/api-lazy-tester/releases"><img src="https://img.shields.io/github/v/release/NissonCX/api-lazy-tester?include_prereleases&style=flat" alt="release"></a>
  <a href="https://github.com/NissonCX/api-lazy-tester/blob/main/LICENSE"><img src="https://img.shields.io/github/license/NissonCX/api-lazy-tester?style=flat" alt="license"></a>
</p>

---

## 什么是 api-lazy-tester？

`api-lazy-tester` 是一个 AI 驱动的接口测试工作流，能够自动：
- 🔍 通过 git diff 发现新接口
- 📖 读取 OpenAPI / Controller 定义
- 🧪 生成测试用例（正常用例 + 边界用例 + 负例）
- ⚡ 自动执行测试
- 📊 输出清晰的测试报告

**代码你写，测试交给 AI。**

---

## 快速开始

```bash
# 克隆项目
git clone https://github.com/NissonCX/api-lazy-tester.git
cd api-lazy-tester
```

### 在 Claude Code 中

```
/api-lazy-tester 测试我新写的接口
Token: 你的token
```

### 在 Codex 中

```
测试我新写的接口
Token: 你的token
```

---

## 安装

### 独立脚本

```bash
# 下载测试脚本
curl -sL https://raw.githubusercontent.com/NissonCX/api-lazy-tester/main/skill/api-lazy-tester/scripts/test-api.sh -o test-api.sh
chmod +x test-api.sh
```

---

## 使用方法

```bash
# POST 请求
./skill/api-lazy-tester/scripts/test-api.sh \
  -m POST \
  -u "http://localhost:8080/api/login" \
  -t "Bearer 你的token" \
  -b '{"username":"test","password":"123456"}'

# GET 请求（带超时）
./skill/api-lazy-tester/scripts/test-api.sh \
  -m GET \
  -u "http://localhost:8080/api/users/1" \
  -t "Bearer 你的token" \
  -T 60
```

### 参数说明

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `-m` | HTTP 方法 | - |
| `-u` | 请求 URL | - |
| `-t` | 认证 Token | - |
| `-b` | 请求体 | - |
| `-T` | 超时秒数 | 30 |
| `-s` | 输出格式 | json |

---

## 功能特性

| 特性 | 说明 |
|------|------|
| 自动发现 | 通过 git diff 查找新接口 |
| 智能解析 | 读取 OpenAPI、Swagger 或 Controller 源码 |
| 测试生成 | 创建正常 + 边界 + 负例测试用例 |
| 安全优先 | DELETE 操作需要确认 |
| 通用兼容 | 支持任何 HTTP API |

---

## 文档

- [快速开始](docs/快速开始.md)
- [使用说明](docs/使用说明.md)
- [更多示例](docs/更多示例.md)
- [常见问题](docs/FAQ.md)
- [Claude Code 集成](docs/ClaudeCode集成指南.md)
- [Codex 集成](docs/Codex集成指南.md)

---

## 贡献

欢迎贡献！请先阅读[贡献指南](CONTRIBUTING.md)。

---

## 许可证

[MIT](LICENSE) — © 2024-present NissonCX

---

<p align="center">
  <sub>用 ❤️ 开发，为开发者服务</sub>
</p>