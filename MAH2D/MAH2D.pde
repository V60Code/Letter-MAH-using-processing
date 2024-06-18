PShape mah;
PShape b;
float angle = 0;
float scale = 1;
boolean mirror = false;
int posX, posY;

boolean moveUp, moveDown, moveLeft, moveRight;
boolean rotateLeft, rotateRight, rotateClockwise, rotateCounterClockwise;
boolean scaleUp, scaleDown;
boolean flipHorizontal;

void setup(){
  size(1000, 700, P2D);

  mah = createShape(GROUP);

  // Huruf M
  PShape m = createShape();
  m.beginShape();
  m.vertex(0, 0);
  m.vertex(0, 200);
  m.vertex(40, 200);
  m.vertex(40, 95);
  m.vertex(75, 200);
  m.vertex(115, 200);
  m.vertex(150, 95);
  m.vertex(150, 200);
  m.vertex(190, 200);
  m.vertex(190, 0);
  m.vertex(130, 0);
  m.vertex(95, 110);
  m.vertex(60, 0);
  m.endShape(CLOSE);

  // Huruf A yang diperbagus dan simetris
  PShape a = createShape();
  a.beginShape();
  a.vertex(210, 200); // Kiri bawah
  a.vertex(260, 0);   // Kiri atas
  a.vertex(310, 0);   // Kanan atas
  a.vertex(360, 200); // Kanan bawah
  a.vertex(315, 200); // Garis bawah kanan
  a.vertex(305, 150); // Garis tengah kanan
  a.vertex(265, 150); // Garis tengah kiri
  a.vertex(255, 200); // Garis bawah kiri
  a.endShape(CLOSE);

  // Garis horizontal tengah untuk huruf "A"
  b = createShape();
  b.beginShape();
  b.noStroke();
  b.fill(0, 0, 0);
  b.vertex(278, 40);  // Kiri garis horizontal
  b.vertex(292, 40);  // Kanan garis horizontal
  b.vertex(315, 113); // Kanan bawah garis horizontal
  b.vertex(255, 113); // Kiri bawah garis horizontal
  b.endShape(CLOSE);

  // Huruf H
  PShape h = createShape();
  h.beginShape();
  h.vertex(370, 0);
  h.vertex(370, 200);
  h.vertex(410, 200);
  h.vertex(410, 120);
  h.vertex(450, 120);
  h.vertex(450, 200);
  h.vertex(490, 200);
  h.vertex(490, 0);
  h.vertex(450, 0);
  h.vertex(450, 80);
  h.vertex(410, 80);
  h.vertex(410, 0);
  h.vertex(370, 0);
  h.endShape(CLOSE);

  mah.addChild(m);
  mah.addChild(a);
  mah.addChild(h);
  mah.addChild(b);

  centerObject();
}

void draw(){
  noStroke();
  background(0);  // Mengubah warna latar belakang menjadi abu-abu

  // Adjust translation to center of "A" (width of M + half width of A)
  float aCenterX = 210 + 75;
  float aCenterY = 100; // Half the height of A

  translate(posX, posY); // Centering in the canvas
  translate(aCenterX, aCenterY); // Move origin to the center of "A"
  if (mirror) scale(-1, 1); // Pembalikan horizontal
  rotate(angle); // Rotasi
  scale(scale); // Skala
  translate(-aCenterX, -aCenterY); // Move back to original position
  shape(mah);

  // Menggerakkan bangun
  if (moveUp) {
    posY -= 5;
  }
  if (moveDown) {
    posY += 5;
  }
  if (moveLeft) {
    posX -= 5;
  }
  if (moveRight) {
    posX += 5;
  }
  if (rotateClockwise) {
    angle += 0.1;
  }
  if (rotateCounterClockwise) {
    angle -= 0.1;
  }
  if (scaleUp) {
    scale += 0.01;
  }
  if (scaleDown) {
    scale -= 0.01;
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) moveUp = true;
    if (keyCode == DOWN) moveDown = true;
    if (keyCode == LEFT) moveLeft = true;
    if (keyCode == RIGHT) moveRight = true;
  } else {
    if (key == 'a') rotateCounterClockwise = true;
    if (key == 'd') rotateClockwise = true;
    if (key == 's') scaleUp = true;
    if (key == 'w') scaleDown = true;
    if (key == 'm') flipHorizontal = true;
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) moveUp = false;
    if (keyCode == DOWN) moveDown = false;
    if (keyCode == LEFT) moveLeft = false;
    if (keyCode == RIGHT) moveRight = false;
  } else {
    if (key == 'a') rotateCounterClockwise = false;
    if (key == 'd') rotateClockwise = false;
    if (key == 's') scaleUp = false;
    if (key == 'w') scaleDown = false;
    if (key == 'm') {
      flipHorizontal = false;
      mirror = !mirror;
    }
  }
}

void centerObject() {
  // Ukuran huruf MAH
  float widthMAH = 490;
  float heightMAH = 200;

  // Pusatkan posX dan posY
  posX = (width - (int)widthMAH) / 2;
  posY = (height - (int)heightMAH) / 2;
}
