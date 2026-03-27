#!/bin/bash

# 测试输入模板生成脚本
# 用法: ./scripts/init-test-input.sh <output-file>

OUTPUT_FILE="${1:-test-input.json}"

cat > "$OUTPUT_FILE" << 'EOF'
{
  "token": "your-token-here",
  "baseUrl": "http://localhost:8080",
  "target": {
    "method": "POST",
    "path": "/api/example"
  }
}
EOF

echo "测试输入模板已生成: $OUTPUT_FILE"
echo "请编辑文件，替换 token 和 baseUrl"