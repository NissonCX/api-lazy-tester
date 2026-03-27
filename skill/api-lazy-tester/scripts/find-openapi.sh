#!/bin/bash

# OpenAPI 文件查找脚本
# 自动查找项目中的 OpenAPI/Swagger 定义文件和 Controller 文件

SEARCH_DIR="${1:-.}"

echo "=== 查找 OpenAPI/Swagger 文件 ==="
find "$SEARCH_DIR" -type f \( -name "openapi.yaml" -o -name "openapi.json" -o -name "swagger.yaml" -o -name "swagger.json" -o -name "*api-doc*.json" \) 2>/dev/null | head -20

echo ""
echo "=== 查找 Controller 文件 ==="
find "$SEARCH_DIR" -type f -name "*Controller.java" 2>/dev/null | head -20

echo ""
echo "=== 查找 DTO/Entity 文件 ==="
find "$SEARCH_DIR" -type f \( -name "*DTO.java" -o -name "*Entity.java" -o -name "*VO.java" -o -name "*Request.java" \) 2>/dev/null | head -20