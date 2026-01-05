#!/bin/bash
# 
#Autor: Francisco Javier José Angeles  bocho_zic@hotmail.com
#Fecha de creación: dom 04 ene 2026 16:50:28 CST


###     CONFIGURACIONES INICIALES   ####
set -eu #-e termina el scrip de inmediato si algo falla   -u trata las variables no definidas como error
export PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium




###     DETECCIÓN DE FALTA DE ARGUMENTOS    #####
if [ $# -lt 1 ]; then
  echo "Usage: mmd file1.mmd [file2.mmd ...]"
  #echo "Usage: mmd file.mmd [output.png|output.svg]"
  exit 1
fi


### ITERAR SOBRE TODOS LOS ARCHIVOS DE ENTRADA
for in in "$@"; do
  case "$in" in
    *.mmd|*.md) ;;
    *)
      echo "Skipping '$in' (not a .mmd/.md file)"
      continue
      ;;
  esac

  out="${in%.*}.png"

  ### VERIFICAR SI EL ARCHIVO YA EXISTE
  if [ ! -f "$out" ]; then
    echo "Rendering: $in → $out"
    mmdc -i "$in" -o "$out"
  else
    echo "Already exists: $out (skipping render)"
  fi

  ### ABRIR EL ARCHIVO CON EL PROGRAMA POR DEFECTO
  xdg-open "$out" >/dev/null 2>&1 &
done
