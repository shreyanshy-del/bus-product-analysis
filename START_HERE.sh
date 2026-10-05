#!/usr/bin/env bash
# Start CR Analyser (India) on http://127.0.0.1:8080
# Creates .venv and installs Python deps on first run (including macOS CLT Python 3.9).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

free_port() {
  # macOS fuser is not the Linux one (it prints usage and does not free the port).
  if [[ "$(uname -s)" != "Darwin" ]] && command -v fuser >/dev/null 2>&1; then
    fuser -k 8080/tcp >/dev/null 2>&1 || true
    return
  fi
  if command -v lsof >/dev/null 2>&1; then
    local pids
    pids="$(lsof -tiTCP:8080 -sTCP:LISTEN 2>/dev/null || true)"
    if [[ -n "${pids}" ]]; then
      # shellcheck disable=SC2086
      kill ${pids} 2>/dev/null || true
      sleep 0.3
    fi
  fi
}

py_ok() {
  local bin="$1" ver
  command -v "$bin" >/dev/null 2>&1 || return 1
  ver="$("$bin" -c 'import sys; print(f"{sys.version_info[0]}.{sys.version_info[1]}")' 2>/dev/null || true)"
  case "$ver" in
    3.9|3.1[0-9]|3.[2-9]*) return 0 ;;
    *) return 1 ;;
  esac
}

pick_python() {
  local c
  for c in python3.13 python3.12 python3.11 python3.10 python3.9 python3; do
    if py_ok "$c"; then
      echo "$c"
      return 0
    fi
  done
  echo "Python 3.9+ is required. Install it from https://www.python.org/downloads/ then re-run ./START_HERE.sh" >&2
  exit 1
}

free_port

PY="$(pick_python)"
VENV="$ROOT/.venv"
if [[ ! -x "$VENV/bin/python" ]]; then
  echo "Creating $VENV with $PY ($("$PY" -V))"
  "$PY" -m venv "$VENV"
fi
# shellcheck disable=SC1091
source "$VENV/bin/activate"

PY_MINOR="$(python -c 'import sys; print(sys.version_info[1])')"
echo "Installing Python packages (first run can take a minute)..."
python -m pip install -q --upgrade pip
if [[ "$PY_MINOR" -le 9 ]]; then
  # Current fastapi/pandas/numpy releases dropped Python 3.9. Pin the last compatible set.
  python -m pip install -q \
    'fastapi>=0.115,<0.116' \
    'uvicorn>=0.30,<0.33' \
    'pandas>=2.0,<2.3' \
    'numpy>=1.26,<2.1' \
    'python-dotenv>=1.0,<2' \
    'pydantic>=2.7,<2.11'
else
  python -m pip install -q -r "$ROOT/backend/requirements.txt"
fi

export PYTHONPATH="$ROOT/backend${PYTHONPATH:+:$PYTHONPATH}"
cd "$ROOT/backend"

python - <<'PY'
from csv_data_engine import CRDataEngine
e = CRDataEngine()
m = e.meta()
print("data ready", m["date_min"], "→", m["date_max"], "rows", m["rows_main"], "mode", m["data_mode"])
PY

echo "Starting CR Analyser at http://127.0.0.1:8080"
echo "Leave this window open. Open that address in a browser on this same Mac."
exec python -m uvicorn main:app --host 127.0.0.1 --port 8080
