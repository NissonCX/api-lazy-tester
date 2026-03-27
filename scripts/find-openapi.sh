#!/bin/bash

# OpenAPI 文件查找脚本
# 用法: ./scripts/find-openapi.sh [directory]

SEARCH_DIR="${1:-.}"

echo "查找 OpenAPI/Swagger 文件..."

find "$SEARCH_DIR" -type f \( -name "openapi.yaml" -o -name "openapi.json" -o -name "swagger.yaml" -o -name "swagger.json" -o -name "*api-doc*" \) 2>/dev/null

echo "查找 Controller 文件..."

find "$SEARCH_DIR" -type f -name "*Controller.java" 2>/dev/null