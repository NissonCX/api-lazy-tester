<p align="center">
  <img src="https://api-lazy-tester.github.io/logo.png" alt="api-lazy-tester" width="200"/>
</p>

<h1 align="center">api-lazy-tester</h1>

<p align="center">
  <strong>Let AI test your APIs — because you wrote the code, not the tests.</strong>
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

## The Problem

You just finished writing a new API endpoint. Now comes the tedious part:

```
1. Start your local server
2. Open Postman/Apifox
3. Fill in parameters, click send, check response
4. Repeat for each test case...
5. 2 hours later... 😴
```

**Been there. Done that. It's exhausting.**

---

## The Solution

`api-lazy-tester` — your AI-powered API testing assistant.

### What it does

- 🔍 **Auto-discovers** new APIs (via git diff)
- 📖 **Reads** OpenAPI / Controller definitions
- 🧪 **Generates** test cases (happy path + edge cases + negative tests)
- ⚡ **Executes** tests automatically
- 📊 **Reports** results in a clean format

### What you do

1. Tell AI: "Test my new APIs"
2. Provide your token

That's it. Go grab a coffee while AI does the work. ☕

---

## Quick Start

### In Claude Code

```
test my new APIs
Token: your_token_here
```

Or use the skill:

```
/api-lazy-tester
```

### In Codex

```
test my new APIs
Token: your_token_here
```

### Output Example

```
✅ POST /api/user/login - Pass 3/3
├── Normal login - 200 ✓
├── Empty username - 400 ✓
└── Wrong password - 401 ✓
```

---

## Features

| Feature | Description |
|---------|-------------|
| 🤖 Auto Discovery | Finds new APIs via git diff |
| 📖 Smart Parsing | Reads OpenAPI, Swagger, or Controller source |
| 🧪 Auto Test Generation | Creates happy + edge + negative test cases |
| 🔒 Security First | DELETE operations require confirmation |
| 🔌 Universal | Works with any HTTP API |

---

## Installation

```bash
# Clone the repo
git clone https://github.com/NissonCX/api-lazy-tester.git
cd api-lazy-tester
```

---

## Usage

### Basic Request

```bash
./skill/api-lazy-tester/scripts/test-api.sh \
  -m POST \
  -u "http://localhost:8080/api/login" \
  -t "Bearer your_token" \
  -b '{"username":"test","password":"123456"}'
```

### With Custom Timeout

```bash
./skill/api-lazy-tester/scripts/test-api.sh \
  -m GET \
  -u "http://localhost:8080/api/users/1" \
  -t "Bearer your_token" \
  -T 60
```

### Options

| Flag | Description | Example |
|------|-------------|---------|
| `-m` | HTTP method | GET, POST, PUT, DELETE |
| `-u` | Full URL | https://api.example.com/api/login |
| `-t` | Token | Bearer your_token |
| `-b` | Request body | '{"key":"value"}' |
| `-T` | Timeout (seconds) | 30 |
| `-s` | Output format | json (default), simple |

---

## Why Not Just Use Postman?

| Feature | Postman | api-lazy-tester |
|---------|---------|-----------------|
| Setup | Manual | AI automated |
| Test cases | You write them | AI generates them |
| Learning curve | Medium | Zero |
| Price | Free/Paid | Free & Open Source |

---

## Supported AI Tools

| Tool | Skill File | Status |
|------|------------|--------|
| Claude Code | `skill/api-lazy-tester/SKILL.md` | ✅ Ready |
| Codex | `skill/codex-api-tester/SKILL.md` | ✅ Ready |

---

## Documentation

- [Quick Start](docs/快速开始.md) — Get started in 5 minutes
- [Usage Guide](docs/使用说明.md) — Detailed usage
- [More Examples](docs/更多示例.md) — Advanced usage
- [FAQ](docs/FAQ.md) — Common questions
- [Claude Code Integration](docs/ClaudeCode集成指南.md)
- [Codex Integration](docs/Codex集成指南.md)

---

## Tech Stack

- Claude Code Skill / Codex Skill
- Bash scripts (curl wrapper)
- OpenAPI / Swagger parsing
- Java Controller source parsing

---

## Core Principles

- **Token is yours** — You provide, AI never asks
- **AI does the work** — You drink coffee, it tests
- **Safety first** — DELETE operations need your confirmation

---

## Contributing

Contributions are welcome! Please read our [contributing guide](CONTRIBUTING.md) first.

---

## License

MIT License — see [LICENSE](LICENSE) for details.

---

## Support

- ⭐ Star this repo if it helps!
- 🐛 Report bugs via [Issues](https://github.com/NissonCX/api-lazy-tester/issues)
- 💬 Ask questions in discussions

---

<p align="center">
  Made with ❤️ by developers, for developers
</p>

<p align="center">
  <sub>API testing: Let AI handle it. You wrote the code, not the tests. 🚀</sub>
</p>