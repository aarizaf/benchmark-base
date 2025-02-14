#!/bin/bash

# Clonar el repositorio con las soluciones
git clone https://github.com/JP1604/dockerlanguages.git
cd dockerlanguages

# Archivo CSV para resultados
RESULTADOS="resultados/resultados.csv"
echo "Lenguaje,Tiempo(ms)" > "$RESULTADOS"

# Recorrer carpetas de lenguajes
echo "Ejecutando benchmarks..."
for dir in Lenguajes/*/; do
  # Verifica si es un directorio válido
  if [ -d "$dir" ]; then
    LENGUAJE=$(basename "$dir")
    echo "🔹 Ejecutando $LENGUAJE..."
    
    # Construir imagen Docker
    docker build -t "${LENGUAJE//+/}-benchmark" "$dir"
    
    # Ejecutar contenedor y capturar tiempo
    TIEMPO=$(docker run --rm "${LENGUAJE//+/}-benchmark")
    
    if [ -n "$TIEMPO" ]; then
      echo "$LENGUAJE,$TIEMPO" >> "$RESULTADOS"
      echo "✅ $LENGUAJE: $TIEMPO ms"
    else
      echo "❌ Error: Salida inesperada del contenedor para $LENGUAJE"
    fi
  fi
done

echo "📊 Resultados guardados en $RESULTADOS"
