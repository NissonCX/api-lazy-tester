# api-lazy-tester

[English](README.md) | [简体中文](README-zh.md)

> AI-powered API testing for Claude Code & Codex

[![stars](https://img.shields.io/github/stars/NissonCX/api-lazy-tester?style=flat&color=orange)](https://github.com/NissonCX/api-lazy-tester/stargazers)
[![release](https://img.shields.io/github/v/release/NissonCX/api-lazy-tester?include_prereleases&style=flat)](https://github.com/NissonCX/api-lazy-tester/releases)
[![license](https://img.shields.io/github/license/NissonCX/api-lazy-tester?style=flat)](https://github.com/NissonCX/api-lazy-tester/blob/main/LICENSE)

---

## What is api-lazy-tester?

`api-lazy-tester` is an AI-powered API testing workflow that automatically:
- 🔍 Discovers new APIs via git diff
- 📖 Reads OpenAPI / Controller definitions
- 🧪 Generates test cases (happy path + edge cases + negative tests)
- ⚡ Executes tests automatically
- 📊 Reports results in a clean format

**You write the code. Let AI handle the testing.**

---

## Quick Start

```bash
# Clone the repo
git clone https://github.com/NissonCX/api-lazy-tester.git
cd api-lazy-tester
```

### In Claude Code

```
/api-lazy-tester test my new APIs
Token: your_token
```

### In Codex

```
test my new APIs
Token: your_token
```

---

## Installation

### Standalone Script

```bash
# Download the test script
curl -sL https://raw.githubusercontent.com/NissonCX/api-lazy-tester/main/skill/api-lazy-tester/scripts/test-api.sh -o test-api.sh
chmod +x test-api.sh
```

---

## Usage

```bash
# POST request
./skill/api-lazy-tester/scripts/test-api.sh \
  -m POST \
  -u "http://localhost:8080/api/login" \
  -t "Bearer your_token" \
  -b '{"username":"test","password":"123456"}'

# GET request with timeout
./skill/api-lazy-tester/scripts/test-api.sh \
  -m GET \
  -u "http://localhost:8080/api/users/1" \
  -t "Bearer your_token" \
  -T 60
```

### Options

| Flag | Description | Default |
|------|-------------|---------|
| `-m` | HTTP method | - |
| `-u` | Request URL | - |
| `-t` | Auth token | - |
| `-b` | Request body | - |
| `-T` | Timeout (seconds) | 30 |
| `-s` | Output format | json |

---

## Features

| Feature | Description |
|---------|-------------|
| Auto Discovery | Finds new APIs via git diff |
| Smart Parsing | Reads OpenAPI, Swagger, or Controller source |
| Test Generation | Creates happy + edge + negative test cases |
| Security First | DELETE operations require confirmation |
| Universal | Works with any HTTP API |

---

## Documentation

- [Getting Started](docs/快速开始.md)
- [Usage Guide](docs/使用说明.md)
- [Examples](docs/更多示例.md)
- [FAQ](docs/FAQ.md)
- [Claude Code Integration](docs/ClaudeCode集成指南.md)
- [Codex Integration](docs/Codex集成指南.md)

---

## Contributing

Contributions are welcome! Please read the [contributing guide](CONTRIBUTING.md) first.

---

## License

[MIT](LICENSE) — © 2024-present NissonCX

---

Built for developers who hate manual testing.
