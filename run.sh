#!/usr/bin/env bash
# ============================================================
#  AI + 3D project - macOS one-click launcher
#  Activates the venv and runs the main program
# ============================================================
set -euo pipefail

# Run from the script's own directory; all paths are relative
cd "$(dirname "$0")"

# Check that venv is installed
if [ ! -x "venv/bin/python" ]; then
    echo "[ERROR] venv not found. Run ./install.sh first."
    exit 1
fi

echo "[RUN] Activating venv and running src/main.py ..."
# shellcheck disable=SC1091
source venv/bin/activate
python src/main.py

echo ""
echo "[DONE] Program finished. Output is in the output/ directory."
