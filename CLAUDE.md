# CLAUDE.md

本文件是 AI Agent 的工作指南。

## 项目概述

AI IDE 接口测试工作流 - 一个定义 AI Agent 如何执行 Java 后端接口测试的开源规范项目。

## 核心原则

1. **token 由用户提供**：不实现自动获取 token 的功能
2. **先可用后增强**：V1 聚焦核心工作流
3. **安全优先**：默认禁止高风险写操作
4. **规范优先**：重在定义工作流规范，而非实现复杂工具

## 工作流核心

当用户要求测试接口时：

1. 读取 `docs/ai接口测试工作流.md` 了解详细工作流
2. 读取 `docs/使用说明.md` 了解使用方法
3. 确认必要输入：token、baseUrl、目标接口
4. 查找接口定义（OpenAPI > Controller 源码）
5. 生成测试用例（正常用例 + 边界用例）
6. 执行测试
7. 输出结构化报告

## 重要约束

- 不允许凭空编造参数信息
- 不执行高风险操作（DELETE、批量操作）除非用户明确确认
- 不自动获取 token，必须由用户提供
- 优先使用 OpenAPI 定义，其次使用源码
- 测试报告使用 JSON 格式

## 文件结构

```
.
├── README.md                    # 项目简介
├── docs/
│   ├── 项目介绍.md              # 项目背景和目标
│   ├── ai接口测试工作流.md       # 核心工作流规范
│   ├── 使用说明.md              # 使用指南
│   └── 设计边界与风险.md         # 边界和风险说明
├── examples/
│   ├── 示例输入.md              # 用户输入示例
│   └── 示例输出.md              # 输出示例
├── skill/                       # 可选的 Skill 包装层
├── templates/                   # 模板文件
└── scripts/                     # 辅助脚本
```

## 工具集成

当用户请求测试接口时，使用 skill/ai-api-test/ 中的工具：

- **SKILL.md**：skill 定义文件
- **scripts/test-api.sh**：HTTP 请求执行脚本
- **scripts/find-openapi.sh**：OpenAPI 文件查找脚本
- **examples/demo-api.yaml**：示例 OpenAPI 文件

调用方式：
```bash
./skill/ai-api-test/scripts/test-api.sh -m POST -u "http://your-api-host:port/api/login" -t "Bearer xxx" -b '{"username":"test"}'
```
- [使用说明](docs/使用说明.md) - 使用前阅读
- [设计边界与风险](docs/设计边界与风险.md) - 了解限制

## 禁止事项

1. 禁止自动获取 token
2. 禁止执行未确认的高风险操作
3. 禁止上传测试数据到第三方服务
4. 禁止在生产环境执行写操作（除非明确确认）
5. 禁止生成复杂的测试框架（V1 阶段）

## 风格要求

- 使用中文进行交流
- 文档使用中文
- 提交信息使用中文（Conventional Commits 格式）
- 代码注释使用中文