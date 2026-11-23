// Pines de Entradas (Pulsadores)
const int pinE1 = 2;
const int pinE2 = 3;

// Pines de Salidas (LEDs)
const int pinL1 = 8;
const int pinL2 = 9;

// Variables de estado
bool estadoE1 = false;
bool estadoE2 = false;
bool antE1 = false;
bool antE2 = false;

bool estadoL1 = false;
bool estadoL2 = false;

unsigned long ultimoEnvio = 0;

void setup() {
  Serial.begin(9600);
  
  // INPUT_PULLUP: HIGH cuando está suelto, LOW cuando se presiona
  pinMode(pinE1, INPUT_PULLUP);
  pinMode(pinE2, INPUT_PULLUP);
  
  pinMode(pinL1, OUTPUT);
  pinMode(pinL2, OUTPUT);
}

void loop() {
  // 1. Leer entradas (invertimos con '!' porque usamos INPUT_PULLUP)
  estadoE1 = !digitalRead(pinE1);
  estadoE2 = !digitalRead(pinE2);

  // Detectar flanco ascendente (cuando se presiona el botón) para cambiar el LED
  if (estadoE1 && !antE1) {
    estadoL1 = !estadoL1;
    delay(25); // Antirrebote básico
  }
  if (estadoE2 && !antE2) {
    estadoL2 = !estadoL2;
    delay(25);
  }

  antE1 = estadoE1;
  antE2 = estadoE2;

  // 2. Leer comandos desde Processing (clics en L1 o L2)
  if (Serial.available() > 0) {
    char cmd = Serial.read();
    if (cmd == '1') {
      estadoL1 = !estadoL1;
    } else if (cmd == '2') {
      estadoL2 = !estadoL2;
    }
  }

  // 3. Actualizar salidas físicas
  digitalWrite(pinL1, estadoL1);
  digitalWrite(pinL2, estadoL2);

  // 4. Enviar estado actual a Processing cada 50 ms (Formato: E1,E2,L1,L2)
  if (millis() - ultimoEnvio >= 50) {
    Serial.print(estadoE1 ? 1 : 0);
    Serial.print(",");
    Serial.print(estadoE2 ? 1 : 0);
    Serial.print(",");
    Serial.print(estadoL1 ? 1 : 0);
    Serial.print(",");
    Serial.println(estadoL2 ? 1 : 0);
    ultimoEnvio = millis();
  }
}