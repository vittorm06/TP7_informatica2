 # TP7_informatica2 Interfaz Gráfica en Processing

## Requisitos para el proyecto
* Processingcon la librería estándar `processing.serial.*`.
* Placa Arduino Uno cargada con el codigo de la carpeta `Arduino` o usando SimulIDE 1.1.0 para simular el arduino junto con un par de puertos virtuales creados con com0com

## Instrucciones para ejecutar y replicar
1. Conectar la placa Arduino al puerto USB de la PC o iniciar la simulación en SimulIDE vinculada a uno de los puertos virtuales.
2. Abrir el archivo `TP7_Processing.pde` en el IDE de Processing.
3. Verificar en el código dentro de `setup()` que el nombre o índice del puerto serie coincida con el puerto asignado en tu sistema.
4. Presionar el botón **Ejecutar (Run)** en Processing.
5. **Uso de la interfaz:**
   * Los rectángulos **E1** y **E2** cambian a color verde al mantener presionados los pulsadores correspondientes en Arduino/SimulIDE.
   * Hacer clic con el mouse sobre los círculos **L1** o **L2** envía la orden por puerto serie para encender o apagar los LEDs físicos/simulados, sincronizando su color en pantalla.
