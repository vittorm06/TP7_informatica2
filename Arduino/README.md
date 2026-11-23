#  Arduino — Control y Monitoreo de E/S

## Esquemático del circuito
![Esquemático del circuito en SimulIDE](circuito.png)

## Asignación de pines
* Entrada E1 (Pulsador 1): Pin Digital `2` conectado a `GND` (configurado con resistencia interna `INPUT_PULLUP`).
* Entrada E2 (Pulsador 2): Pin Digital `3` conectado a `GND` (configurado con resistencia interna `INPUT_PULLUP`).
* Salida L1 (LED 1): Pin Digital `8` en serie con resistencia de $220\,\Omega$ a `GND`.
* Salida L2 (LED 2): Pin Digital `9` en serie con resistencia de $220\,\Omega$ a `GND`.

## Características del funcionamiento
* Lectura con antirrebote: Detecta el flanco de pulsación de `E1` y `E2` para alternar (conmutar) el estado de las salidas `L1` y `L2` respectivamente.
* Comunicación Serie (9600 baudios):
  * Recepción: Al recibir el carácter `'1'` o `'2'` desde Processing, invierte el estado de `L1` o `L2`.
  * Transmisión: Envía el estado actual en formato `E1,E2,L1,L2\n` cada vez que ocurre un cambio de estado en alguna entrada o salida (y un refresco periódico de respaldo cada `500 ms` para evitar saturar el puerto en simulación).
