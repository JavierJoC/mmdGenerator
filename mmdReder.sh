#!/bin/bash
# 
#Autor: Francisco Javier José Angeles  bocho_zic@hotmail.com
#Fecha de creación: dom 04 ene 2026 16:50:28 CST


###     CONFIGURACIONES INICIALES   ####
set -eu #-e termina el scrip de inmediato si algo falla   -u trata las variables no definidas como error
export PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium




###     DETECCIÓN DE FALTA DE ARGUMENTOS    #####
if [ $# -lt 1 ]; then
  echo "Usage: mmd file.mmd [output.png|output.svg]"
  exit 1
fi


####    ASIGNACIÓN DE VARIABLES     ###########
in="$1"
out="${2:-${in%.mmd}.png}"



### EJECUCIÓN DEL SCRIPT
#echo "$in --> $out"
exec mmdc -i "$in" -o "$out" # Ejecuta el comando 
#echo "-----------------"
