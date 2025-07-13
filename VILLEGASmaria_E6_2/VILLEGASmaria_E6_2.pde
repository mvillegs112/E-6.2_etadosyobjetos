//variables

import processing.sound.*;

// Tipografía y sonido
PFont miFuente;
SoundFile soundfile;

// Escena portada
PImage portada;
float imgportada = 0.2;

// Escenas con clase
Escena escena1, escena2, escena3;

// Estado actual
int estado = 0;

void setup() {
  size(800, 600);

  // Fuente y música
  miFuente = createFont("Times New Roman", 28);
  textFont(miFuente);
  soundfile = new SoundFile(this, "vals.mp3");
  soundfile.play();

  // Cargar imágenes
  portada = loadImage("portada.jpg");
  PImage img1 = loadImage("escenaI.jpg");
  PImage img2 = loadImage("escenaII.jpg");
  PImage img3 = loadImage("escenaIII.jpg");

  // Dimensiones imagenes
  if (portada != null) portada.resize(900, 600);
  if (img1 != null) img1.resize(800, 0);
  if (img2 != null) img2.resize(800, 0);
  if (img3 != null) img3.resize(800, 0);

  // Crear escenas
  escena1 = new Escena(img1, "Invitación al baile real");
  escena2 = new Escena(img2, "Transformación de cenicienta por el hada madrina");
  escena3 = new Escena(img3, "Postura del zapato de cristal");
}

void draw() {
  background(0);
  imageMode(CENTER);

  //que se muestra en el lienzo
  if (estado == 0 && portada != null) {
    imgportada = min(imgportada + 0.01, 1.0);
    image(portada, width/2, height/2, 800 * imgportada, 600 * imgportada);
    mostrarTexto("Presiona 1, 2 o 3 para seguir la historia\nHaz clic para avanzar o 0 para volver al inicio");
  } else if (estado == 1) {
    escena1.mostrar();
  } else if (estado == 2) {
    escena2.mostrar();
  } else if (estado == 3) {
    escena3.mostrar();
  }
}

// Pasar con clic
void mousePressed() {
  estado++;
  if (estado > 3) estado = 0;

  // Reiniciar imagenes
  if (estado == 0) imgportada = 0.2;
  if (estado == 1) escena1.reiniciarEscala();
  if (estado == 2) escena2.reiniciarEscala();
  if (estado == 3) escena3.reiniciarEscala();
}

// Ir directo con teclas
void keyPressed() {
  if (key == '0') {
    estado = 0;
    imgportada = 0.2;
  } else if (key == '1') {
    estado = 1;
    escena1.reiniciarEscala();
  } else if (key == '2') {
    estado = 2;
    escena2.reiniciarEscala();
  } else if (key == '3') {
    estado = 3;
    escena3.reiniciarEscala();
  }
}

// Mostrar texto en pantalla
void mostrarTexto(String mensaje) {
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(20);
  text(mensaje, width/2, height - 50);
}

// CLASE ESCENA
class Escena {
  PImage imagen;
  String texto;
  float escala;

  Escena(PImage img, String t) {
    imagen = img;
    texto = t;
    escala = 0.2;
  }

  void mostrar() {
    escala = min(escala + 0.01, 1.0);
    image(imagen, width/2, height/2, 800 * escala, 600 * escala);
    mostrarTexto(texto);
  }

  void reiniciarEscala() {
    escala = 0.2;
  }
}
