# mostrar_tiempos.py
import csv

# Leer el archivo CSV
with open('resultados.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        print(f"Lenguaje: {row['Lenguaje']}, Tiempo: {row['Tiempo(ms)']} ms")