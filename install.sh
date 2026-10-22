#!/usr/bin/env bash
# ============================================================
#  AI + 3D project - macOS one-click installer
#  Creates a venv and installs requirements.txt
# ============================================================
set -euo pipefail

# Run from the script's own directory; all paths are relative
cd "$(dirname "$0")"

# 1. Check Python
if ! command -v python3 >/dev/null 2>&1; then
    echo "[ERROR] python3 not found. Install Python 3.12 first."
    exit 1
fi

echo "[1/3] Creating virtual environment venv ..."
if [ ! -d "venv" ]; then
    python3 -m venv venv
else
    echo "      venv already exists, skipping"
fi

echo "[2/3] Activating venv and upgrading pip ..."
# shellcheck disable=SC1091
source venv/bin/activate
python -m pip install --upgrade pip

echo "[3/3] Installing dependencies ..."
python -m pip install -r requirements.txt

echo ""
echo "============================================================"
echo " Done! Activate the environment before developing:"
echo "     source venv/bin/activate"
echo "============================================================"
