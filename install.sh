#!/usr/bin/env bash
# ============================================================
#  AI + 3D 项目 macOS 一键安装脚本
#  自动创建 venv 并安装 requirements.txt 中的依赖
# ============================================================
set -euo pipefail

# 切到脚本所在目录，后续全部使用相对路径
cd "$(dirname "$0")"

# 1. 检查 Python
if ! command -v python3 >/dev/null 2>&1; then
    echo "[错误] 未检测到 python3，请先安装 Python 3.12（推荐）"
    exit 1
fi

echo "[1/3] 创建虚拟环境 venv ..."
if [ ! -d "venv" ]; then
    python3 -m venv venv
else
    echo "      venv 已存在，跳过创建"
fi

echo "[2/3] 激活虚拟环境并升级 pip ..."
# shellcheck disable=SC1091
source venv/bin/activate
python -m pip install --upgrade pip

echo "[3/3] 安装依赖 ..."
python -m pip install -r requirements.txt

echo ""
echo "============================================================"
echo " 安装完成！后续开发请先激活环境："
echo "     source venv/bin/activate"
echo "============================================================"
