<p align="center">
  <img src="https://api-lazy-tester.github.io/logo.png" alt="api-lazy-tester" width="200"/>
</p>

<h1 align="center">api-lazy-tester</h1>

<p align="center">
  <strong>让 AI 测试你的接口 —— 代码是你写的，测试交给 AI。</strong>
</p>

<p align="center">
  <a href="https://github.com/NissonCX/api-lazy-tester/stargazers">
    <img src="https://img.shields.io/github/stars/NissonCX/api-lazy-tester?style=flat" alt="stars"/>
  </a>
  <a href="https://github.com/NissonCX/api-lazy-tester/releases">
    <img src="https://img.shields.io/github/v/release/NissonCX/api-lazy-tester?include_prereleases&style=flat" alt="release"/>
  </a>
  <a href="https://github.com/NissonCX/api-lazy-tester/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/NissonCX/api-lazy-tester?style=flat" alt="license"/>
  </a>
  <a href="https://github.com/NissonCX/api-lazy-tester/issues">
    <img src="https://img.shields.io/github/issues/NissonCX/api-lazy-tester?style=flat" alt="issues"/>
  </a>
</p>

---

## 痛点

刚写完一个接口，测试的时间就到了：

```
1. 启动本地服务
2. 打开 Postman/Apifox
3. 填参数、点发送、看响应
4. 一个接一个地测...
5. 2 小时过去了... 😴
```

**相信我，真的很烦。**

---

## 解决方案

`api-lazy-tester` —— 你的 AI 接口测试助手。

### 它能做什么

- 🔍 **自动发现** 新接口（通过 git diff）
- 📖 **读取** OpenAPI / Controller 定义
- 🧪 **生成** 测试用例（正常用例 + 边界用例 + 负例）
- ⚡ **自动执行** 测试
- 📊 **输出** 清晰的结果报告

### 你需要做什么

1. 告诉 AI："测试我新写的接口"
2. 提供你的 token

搞定。去喝杯咖啡，AI 帮你测。☕

---

## 快速开始

### 在 Claude Code 中

```
测试我新写的接口
Token: 你的token
```

或使用 skill：

```
/api-lazy-tester
```

### 在 Codex 中

```
测试我新写的接口
Token: 你的token
```

### 输出示例

```
✅ POST /api/user/login - 通过 3/3
├── 正常登录 - 200 ✓
├── 用户名为空 - 400 ✓
└── 密码错误 - 401 ✓
```

---

## 功能特性

| 特性 | 说明 |
|------|------|
| 🤖 自动发现 | 通过 git diff 查找新接口 |
| 📖 智能解析 | 读取 OpenAPI、Swagger 或 Controller 源码 |
| 🧪 自动生成测试 | 创建正常 + 边界 + 负例测试用例 |
| 🔒 安全优先 | DELETE 操作需要确认 |
| 🔌 通用性 | 兼容任何 HTTP API |

---

## 安装

```bash
# 克隆项目
git clone https://github.com/NissonCX/api-lazy-tester.git
cd api-lazy-tester
```

---

## 使用方法

### 基础请求

```bash
./skill/api-lazy-tester/scripts/test-api.sh \
  -m POST \
  -u "http://localhost:8080/api/login" \
  -t "Bearer 你的token" \
  -b '{"username":"test","password":"123456"}'
```

### 自定义超时

```bash
./skill/api-lazy-tester/scripts/test-api.sh \
  -m GET \
  -u "http://localhost:8080/api/users/1" \
  -t "Bearer 你的token" \
  -T 60
```

### 参数说明

| 参数 | 说明 | 示例 |
|------|------|------|
| `-m` | HTTP 方法 | GET, POST, PUT, DELETE |
| `-u` | 完整 URL | https://api.example.com/api/login |
| `-t` | Token | Bearer 你的token |
| `-b` | 请求体 | '{"key":"value"}' |
| `-T` | 超时秒数 | 30 |
| `-s` | 输出格式 | json (默认), simple |

---

## 为什么不用 Postman？

| 特性 | Postman | api-lazy-tester |
|------|---------|-----------------|
| 配置 | 手动填写 | AI 自动 |
| 测试用例 | 手动编写 | AI 自动生成 |
| 学习成本 | 中等 | 零门槛 |
| 价格 | 免费/付费 | 免费开源 |

---

## 支持的 AI 工具

| 工具 | Skill 文件 | 状态 |
|------|------------|------|
| Claude Code | `skill/api-lazy-tester/SKILL.md` | ✅ 可用 |
| Codex | `skill/codex-api-tester/SKILL.md` | ✅ 可用 |

---

## 文档

- [快速开始](docs/快速开始.md) — 5 分钟入门
- [使用说明](docs/使用说明.md) — 详细使用指南
- [更多示例](docs/更多示例.md) — 进阶用法
- [FAQ](docs/FAQ.md) — 常见问题
- [Claude Code 集成](docs/ClaudeCode集成指南.md)
- [Codex 集成](docs/Codex集成指南.md)

---

## 技术栈

- Claude Code Skill / Codex Skill
- bash 脚本（curl 封装）
- OpenAPI / Swagger 解析
- Java Controller 源码解析

---

## 核心原则

- **token 你来给** — 自己提供，AI 不主动要
- **测试 AI 来跑** — 你喝咖啡，它干活
- **安全第一** — DELETE 需要你确认

---

## 贡献

欢迎贡献！请先阅读[贡献指南](CONTRIBUTING.md)。

---

## 许可证

MIT License — 详见 [LICENSE](LICENSE)。

---

## 支持

- ⭐ 觉得有用就点个 Star！
- 🐛 通过 [Issues](https://github.com/NissonCX/api-lazy-tester/issues) 报告问题
- 💬 在讨论区提问

---

<p align="center">
  用 ❤️ 开发，为开发者服务
</p>

<p align="center">
  <sub>接口测试：交给 AI。你写代码，它测接口。🚀</sub>
</p>