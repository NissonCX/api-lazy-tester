# 接口写完了，测试的事交给 AI

> 写接口 5 分钟，测试 2 小时？

作为一个后端仔，你肯定遇到过这种情况：
- 接口写完了，本地启动服务
- 打开 Postman/Apifox
- 一个个填参数、点发送、看结果
- 测完一个再测下一个
- 2 小时过去了......

**太累了。**

于是有了 `api-lazy-tester` —— 你的接口测试小助手。

## 它能做什么

- 自动发现你新写的接口（git diff 了解一下）
- 自动读取接口定义（OpenAPI、Controller 都能看懂）
- 自动生成测试用例（正常用例 + 边界用例 + 负例）
- 自动执行测试并输出报告

**你只需要做两件事：**
1. 告诉 AI："测一下我新写的接口"
2. 给 AI 你的 token

然后该喝茶喝茶，该摸鱼摸鱼 🐟

## 谁会用它

- 刚写完接口的后端同学
- 不想手动测试的懒人
- 日常需要快速验证接口的开发者

## 快速开始

```bash
# 告诉 AI
请测试我新写的接口
Token: 你的token
```

AI 会自动跑完整个流程，最后给你一个测试报告：

```
✅ POST /api/user/login - 通过 3/3
├── 正常登录 - 200 ✓
├── 用户名为空 - 400 ✓
└── 密码错误 - 401 ✓
```

## 为什么不用 Postman

| 特性 | Postman | api-lazy-tester |
|------|---------|-----------------|
| 配置 | 要手动填 | AI 全自动 |
| 测试用例 | 要手写 | AI 根据接口定义生成 |
| 门槛 | 需要学习 | 会说话就行 |
| 价格 | 免费/付费 | 免费开源 |

## 核心原则

- **token 你来给**：自己提供，AI 不主动要
- **测试 AI 来跑**：你喝咖啡，它干活
- **安全第一**：DELETE 这种危险操作需要你确认

## 在 Claude Code 中用

直接在 Claude Code 里告诉它：

```
测试我新写的接口
Token: xxx
```

或者用 skill：

```
/api-lazy-tester
```

详细说明见 [skill/api-lazy-tester/SKILL.md](skill/api-lazy-tester/SKILL.md)

## 在 Codex 中用

Codex 已内置 Skill，直接告诉它：

```
测试我新写的接口
Token: xxx
```

或者让它先读取接口定义再测试：

```
请帮我测试刚写的用户管理接口
Token: Bearer xxx
BaseUrl: http://localhost:8080
```

详细说明见 [skill/codex-api-tester/SKILL.md](skill/codex-api-tester/SKILL.md)

## 支持的 AI 工具

| 工具 | Skill 文件 | 状态 |
|------|------------|------|
| Claude Code | `skill/api-lazy-tester/SKILL.md` | ✅ 可用 |
| Codex | `skill/codex-api-tester/SKILL.md` | ✅ 可用 |

## 文档

- [项目介绍](docs/项目介绍.md)
- [快速开始](docs/快速开始.md)
- [更多示例](docs/更多示例.md)
- [FAQ](docs/FAQ.md)
- [Claude Code 集成](docs/ClaudeCode集成指南.md)
- [Codex 集成](docs/Codex集成指南.md)

## 技术栈

- Claude Code Skill / Codex Skill
- bash 脚本（curl 封装）
- OpenAPI / Swagger 解析
- Java Controller 源码解析

---

写接口已经够累了，测试的事就交给 AI 吧 🚀

MIT License