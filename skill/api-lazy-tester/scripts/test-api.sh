#!/bin/bash

# AI 接口测试脚本
# 用法: ./test-api.sh -m METHOD -u FULL_URL -t TOKEN [-b BODY] [-H "Header: Value"] [-s FORMAT] [-T TIMEOUT]
#
# 示例:
#   ./test-api.sh -m POST -u "http://your-api-host:port/api/login" -t "Bearer xxx" -b '{"username":"test"}'
#   ./test-api.sh -m GET -u "http://your-api-host:port/api/user/1" -t "Bearer xxx"
#   ./test-api.sh -m POST -u "http://your-api-host:port/api/xxx" -t "Bearer xxx" -H "X-Request-ID: test" -b '{}' -T 30

set -euo pipefail

# 默认值
METHOD=""
URL=""
TOKEN=""
BODY=""
OUTPUT_FORMAT="json"
TIMEOUT=30
EXTRA_HEADERS=""

show_usage() {
  echo "用法: $0 -m METHOD -u FULL_URL -t TOKEN [-b BODY] [-H 'Header: Value'] [-s FORMAT] [-T TIMEOUT]"
  echo ""
  echo "参数:"
  echo "  -m  HTTP 方法 (GET/POST/PUT/DELETE)"
  echo "  -u  完整 URL (包含 host 和 path)"
  echo "  -t  Authorization Token"
  echo "  -b  请求体 JSON (可选)"
  echo "  -H  自定义请求头 (可选，可多次使用)"
  echo "  -s  输出格式 (json/simple)，默认 json"
  echo "  -T  超时秒数，默认 30"
  echo ""
  echo "示例:"
  echo "  $0 -m POST -u 'http://your-api-host:port/api/login' -t 'Bearer xxx' -b '{\"username\":\"test\"}'"
  echo "  $0 -m GET -u 'http://your-api-host:port/api/user/1' -t 'Bearer xxx'"
  echo "  $0 -m POST -u 'http://your-api-host:port/api/xxx' -t 'Bearer xxx' -T 60"
  exit 0
}

# 解析参数
while getopts "m:u:t:b:H:s:T:h" opt; do
  case $opt in
    m) METHOD="$OPTARG" ;;
    u) URL="$OPTARG" ;;
    t) TOKEN="$OPTARG" ;;
    b) BODY="$OPTARG" ;;
    H) EXTRA_HEADERS="$EXTRA_HEADERS -H '$OPTARG'" ;;
    s) OUTPUT_FORMAT="$OPTARG" ;;
    T) TIMEOUT="$OPTARG" ;;
    h) show_usage ;;
    *) show_usage ;;
  esac
done

# 验证必要参数
if [ -z "$METHOD" ] || [ -z "$URL" ] || [ -z "$TOKEN" ]; then
  echo "错误: -m, -u, -t 都是必需参数" >&2
  show_usage
fi

# 构建 curl 命令（不用 eval，用数组避免安全问题）
# shellcheck disable=SC2086
CURL_CMD=(curl -s
  -w "\n---STAT---\n%{http_code}\n%{time_total}"
  -X "$METHOD"
  --max-time "$TIMEOUT"
  -H "Content-Type: application/json"
  -H "Authorization: $TOKEN"
  $EXTRA_HEADERS
  "$URL")

# 添加请求体
if [ -n "$BODY" ]; then
  CURL_CMD+=(-d "$BODY")
fi

# 执行请求
RESPONSE=$("${CURL_CMD[@]}" 2>&1) || true
EXIT_CODE=$?

# 解析响应和状态
RESPONSE_BODY=$(echo "$RESPONSE" | sed -n '/---STAT---/q;p')
STAT_LINE=$(echo "$RESPONSE" | sed -n '/---STAT---/,$p' | tail -n +2)
HTTP_CODE=$(echo "$STAT_LINE" | head -1)
TIME_TOTAL=$(echo "$STAT_LINE" | tail -1)

# 检查 curl 是否成功
if [ -z "$HTTP_CODE" ] || [[ ! "$HTTP_CODE" =~ ^[0-9]+$ ]]; then
  HTTP_CODE="000"
  TIME_TOTAL="0"
  RESPONSE_BODY="{\"error\": \"请求失败或超时\", \"raw_response\": \"$RESPONSE\"}"
fi

# 判断结果
if [ "$HTTP_CODE" -ge 200 ] && [ "$HTTP_CODE" -lt 300 ]; then
  RESULT="通过"
else
  RESULT="失败"
fi

# 输出结果
if [ "$OUTPUT_FORMAT" = "simple" ]; then
  echo "状态码: $HTTP_CODE"
  echo "耗时: ${TIME_TOTAL}s"
  echo "响应: $RESPONSE_BODY"
else
  # JSON 格式输出
  cat << EOF
{
  "request": {
    "method": "$METHOD",
    "url": "$URL",
    "token_preview": "${TOKEN:0:20}...",
    "body": $BODY
  },
  "response": {
    "status": $HTTP_CODE,
    "time": $TIME_TOTAL,
    "body": $RESPONSE_BODY
  },
  "result": "$RESULT"
}
EOF
fi