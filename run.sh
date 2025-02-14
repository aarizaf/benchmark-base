#!/bin/bash

# Definir el archivo de resultados
RESULTADOS="resultados.txt"

# Ejecutar contenedor y capturar tiempo
for LENGUAJE in cpp java javascript python rust; do
  TIEMPO=$(docker run --rm "${LENGUAJE//+/}-benchmark")
  
  if [ -n "$TIEMPO" ]; then
    echo "$LENGUAJE,$TIEMPO" >> "$RESULTADOS"
    echo "✅ $LENGUAJE: $TIEMPO ms"
  else
    echo "❌ Error: Salida inesperada del contenedor para $LENGUAJE"
  fi
done

echo "📊 Resultados guardados en $RESULTADOS"