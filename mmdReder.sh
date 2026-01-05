#!/bin/bash
# 
#Autor: Francisco Javier José Angeles  bocho_zic@hotmail.com
#Fecha de creación: dom 04 ene 2026 16:50:28 CST
#!/bin/sh

### ─── STRICT MODE ─────────────────────────────────────────────
set -eu

### ─── CONFIGURATION ───────────────────────────────────────────
export PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
DEFAULT_BG="#FFFFFF"
DEFAULT_FORMAT="svg"
SCRIPT_SELF="$0"

### ─── USAGE ───────────────────────────────────────────────────
if [ "$#" -lt 1 ]; then
  echo "Usage: mmd file1.mmd [file2.mmd ...]"
  exit 1
fi

### ─── METADATA ────────────────────────────────────────────────
echo "Render started at: $(date)"
echo -n "Script version: "
ls -l "$SCRIPT_SELF" | awk '{print $6, $7, $8}'
echo "----------------------------------------"

### ─── MAIN LOOP ───────────────────────────────────────────────
for in in "$@"; do

  case "$in" in
    *.mmd|*.md) ;;
    *)
      echo "Skipping '$in' (not a Mermaid file)"
      continue
      ;;
  esac

  out="${in%.*}.${DEFAULT_FORMAT}"

  if [ -f "$out" ]; then
    echo "Already exists → $out"
  else
    echo "Rendering → $in → $out"
    mmdc \
      --backgroundColor "$DEFAULT_BG" \
      -i "$in" \
      -o "$out"
  fi

  xdg-open "$out" >/dev/null 2>&1 &
done

