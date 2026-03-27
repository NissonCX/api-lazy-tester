# FAQ

常见问题解答。

## 基础问题

### Q: 这个项目是什么？

一个 AI Agent 接口测试工作流规范 + Claude Code Skill。让 AI Agent 能自动测试 API 接口。

### Q: 和 Postman 有什么区别？

| 特性 | 本项目 | Postman |
|------|--------|---------|
| 使用方式 | AI 驱动 | 手动 |
| 学习成本 | 低 | 中 |
| 适用场景 | AI Agent 辅助 | 复杂测试 |

### Q: 支持哪些 AI 工具？

- Claude Code（主要）
- Codex
- 其他支持 skill 的 AI 工具

---

## 使用问题

### Q: token 怎么提供？

用户手动提供，测试时直接给 AI：

```
Token: Bearer eyJhbGciOiJIUzI1NiIs...
```

### Q: 可以测试本地接口吗？

可以，只要网络可达：

```bash
./test-api.sh -m GET -u "http://localhost:8080/api/health" -t "xxx"
```

### Q: 可以测试线上环境吗？

可以，替换 URL 即可：

```bash
./test-api.sh -m GET -u "https://api.yourcompany.com/api/user" -t "Bearer xxx"
```

### Q: 支持哪些 HTTP 方法？

支持：GET、POST、PUT、DELETE、PATCH

### Q: 如何查看所有参数？

```bash
./test-api.sh -h
```

---

## 技术问题

### Q: 请求超时怎么办？

使用 -T 参数增加超时：

```bash
./test-api.sh -m GET -u "http://xxx.com/api" -t "xxx" -T 60  # 60 秒
```

### Q: 响应是中文乱码怎么办？

脚本默认 UTF-8，如果还有问题，检查终端编码：

```bash
export LANG=en_US.UTF-8
```

### Q: 如何调试看完整 curl 命令？

使用 -s simple 格式查看原始响应：

```bash
./test-api.sh -m GET -u "http://xxx.com/api" -t "xxx" -s simple
```

### Q: 脚本支持 macOS 和 Linux 吗？

支持。Windows 用户建议使用 WSL 或 Git Bash。

---

## 安全问题

### Q: token 会被保存吗？

不会。脚本不保存任何数据，token 只在内存中用于请求。

### Q: 可以测试生产环境吗？

可以，但注意：
- 默认只读操作
- DELETE 需要确认
- 建议先在测试环境验证

### Q: 如何避免 token 泄露？

1. 测试完成后立即失效 token
2. 使用临时 token
3. 不要在公开场合分享 token

---

## 集成问题

### Q: 如何在 Claude Code 中使用？

方式一：直接对话
```
请测试 POST /api/login 接口
Token: Bearer xxx
BaseUrl: https://api.example.com
```

方式二：使用 skill
```
/ai-api-test
```

### Q: Skill 不生效怎么办？

1. 检查 .claude/settings.json 配置
2. 确认 skill 文件在正确位置
3. 尝试重启 Claude Code

### Q: 可以自定义脚本吗？

可以。脚本位置：
```
skill/ai-api-test/scripts/test-api.sh
```

---

## 报错处理

### Q: 报错 "curl: (7) Failed to connect"

检查：
1. URL 是否正确
2. 服务是否启动
3. 防火墙是否阻止

### Q: 报错 "curl: (28) Operation timed out"

服务响应慢，增加超时：
```bash
-T 60
```

### Q: 报错 "SSL certificate problem"

跳过 SSL 验证（仅测试环境）：
```bash
# 脚本暂不支持，可使用 curl 原始命令
curl -k ...
```

---

## 更多问题

如果没有找到答案，请提交 [Issue](https://github.com/NissonCX/ai-api-workflow/issues)。