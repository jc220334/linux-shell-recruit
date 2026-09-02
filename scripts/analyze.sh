#!/usr/bin/env bash

# Task 07: complete this script.
# Usage: ./scripts/analyze.sh FILE

# 校验参数:必须恰好一个参数
if [ $# -ne 1 ]; then
    echo "Usage: ./scripts/analyze.sh FILE" >&2
    exit 1
fi

log="$1"

# 校验文件存在
if [ ! -f "$log" ]; then
    echo "Error: file not found: $log" >&2
    exit 1
fi

# 统计 ERROR 行数
total_error=$(grep -c 'ERROR' "$log")

# 统计 ERROR 行里出现最多的 code
top_code=$(grep 'ERROR' "$log" | grep -oE 'code=[0-9]+' | cut -d= -f2 | sort | uniq -c | sort -rn | head -1 | awk '{print $2}')

echo "Total ERROR: $total_error"
echo "Top Code: $top_code"
