#!/bin/bash
# 
#Autor: Francisco Javier José Angeles  bocho_zic@hotmail.com
#El presente script sirve para crear diagramas mermaid localmente 
#Uso de la dependencia mmdc que se tiene que instalar previmente
#Fecha de creación: dom 04 ene 2026 16:50:28 CST
#!/bin/sh

### ─── STRICT MODE ─────────────────────────────────────────────
set -eu

### ─── CONFIGURATION ───────────────────────────────────────────
export PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
DEFAULT_BG="#FFFFFF"
DEFAULT_FORMAT="svg"
SCRIPT_SELF="$0"




### ───  FILTER LACK ARGUMENTS    #####
if [ $# -lt 1 ]; then  #-lt-->les that
  echo "Usage: mmd file1.mmd [file2.mmd ...]"
  #echo "Usage: mmd file.mmd [output.png|output.svg]"
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
    mmdc  -i "$in" -o "$out"
  fi

  #-----------abir el archivo creado-------------"
   firefox --new-window "$out" 
done

