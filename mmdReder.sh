#!/bin/bash
# 
#Autor: Francisco Javier José Angeles  bocho_zic@hotmail.com
#Fecha de creación: dom 04 ene 2026 16:50:28 CST


###    IDENTIFICADOR DE LA RAMA ACTUAL  ###
echo "$(date)"
echo "$(git branch --show-current)"
echo "$(git log --oneline -1)" # Imprime el didentificador de la rama para saber desde dónde se está haciedo la prueba


###     CONFIGURACIONES INICIALES   ####
set -eu #-e termina el scrip de inmediato si algo falla   -u trata las variables no definidas como error

SCRIPT_SELF="$0"  # $0 contiene el nombre/path del script
echo -n "versión del scrip--> "
ls -l $SCRIPT_SELF | awk '{print $6 " " $7  " " $8}'

export PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
CURRENT_DIRECTORY_WORK=$(pwd)"/"


###     DETECCIÓN DE FALTA DE ARGUMENTOS    #####
if [ $# -lt 1 ]; then
  echo "Usage: mmd file.mmd [output.png|output.svg]"
  exit 1
fi


####    ASIGNACIÓN DE VARIABLES     ###########
in="$1"
out="${2:-${in%.mmd}.svg}"
#echo "$in --> $out"
archivo_creado="$CURRENT_DIRECTORY_WORK$out"


### EJECUCIÓN DEL SCRIPT

#exec mmdc --scale 2 --backgroundColor '#FFFFFF' -i "$in" -o "$out"
echo "creando imágen svg $out"
mmdc  -i "$in" -o "$out"
#exec mmdc -i "$in" -o "$out" # Ejecuta el comando 
#echo "-----------------"


echo "abiendo imágen svg $archivo_creado"
firefox --new-window "$archivo_creado"
#firefox --new-window architecture.svg
