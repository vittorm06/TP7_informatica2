import processing.serial.*;

Serial puerto;
boolean conectado = false; // Bandera para saber si hay puerto activo

// Estados recibidos desde Arduino (0 = Bajo, 1 = Alto)
int e1 = 0, e2 = 0, l1 = 0, l2 = 0;

// Coordenadas de los botones de salida (L1 y L2)
float xL1 = 310, yL1 = 230, diamL = 75;
float xL2 = 450, yL2 = 230;

void setup() {
  size(600, 340);
  textAlign(CENTER, CENTER);
  textSize(18);
  
  printArray(Serial.list());
  
  // Solo intenta abrir el puerto si existe al menos uno en Windows

if (Serial.list().length > 0) {
  String nombrePuerto = "COM5"; // <-- Poné acá el puerto pareja de COM4
  puerto = new Serial(this, nombrePuerto, 9600);
  puerto.bufferUntil('\n');
  conectado = true;
}
  else {
    println("AVISO: No se detectaron puertos COM. Ejecutando en modo visual.");
  }
}

void draw() {
  background(255);
  strokeWeight(2);
  stroke(0);

  // Cartel "Entradas"
  fill(140, 170, 205);
  rect(60, 80, 140, 45);
  fill(0);
  text("Entradas", 130, 102);

  // Cartel "Salidas"
  fill(245, 225, 210);
  rect(60, 208, 140, 45);
  fill(0);
  text("Salidas", 130, 230);

  // E1
  fill(e1 == 1 ? color(80, 220, 100) : color(255));
  rect(272, 80, 75, 45);
  fill(0);
  text("E1", 310, 102);

  // E2
  fill(e2 == 1 ? color(80, 220, 100) : color(255));
  rect(412, 80, 75, 45);
  fill(0);
  text("E2", 450, 102);

  // L1
  fill(l1 == 1 ? color(80, 220, 100) : color(255));
  ellipse(xL1, yL1, diamL, diamL);
  fill(0);
  text("L1", xL1, yL1);

  // L2
  fill(l2 == 1 ? color(80, 220, 100) : color(255));
  ellipse(xL2, yL2, diamL, diamL);
  fill(0);
  text("L2", xL2, yL2);
  
  // Aviso de estado al pie
  textSize(12);
  fill(conectado ? color(0, 140, 60) : color(200, 0, 0));
  text(conectado ? "Conectado a Arduino" : "Sin puerto COM detectado (Modo vista previa)", width/2, 310);
  textSize(18);
}

void mousePressed() {
  if (dist(mouseX, mouseY, xL1, yL1) <= diamL / 2) {
    if (conectado) {
      puerto.write('1');
    } else {
      l1 = (l1 == 0) ? 1 : 0; // Simula el cambio localmente si no hay Arduino
    }
  } else if (dist(mouseX, mouseY, xL2, yL2) <= diamL / 2) {
    if (conectado) {
      puerto.write('2');
    } else {
      l2 = (l2 == 0) ? 1 : 0; // Simula el cambio localmente si no hay Arduino
    }
  }
}

void serialEvent(Serial p) {
  String linea = p.readStringUntil('\n');
  if (linea != null) {
    linea = trim(linea);
    int[] valores = int(split(linea, ','));
    if (valores.length == 4) {
      e1 = valores[0];
      e2 = valores[1];
      l1 = valores[2];
      l2 = valores[3];
    }
  }
}
