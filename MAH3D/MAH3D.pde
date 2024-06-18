PShape mah;
float angleX = 0;
float angleY = 0;
float scaleFactor = 1;
boolean mirror = false;
int posX, posY;

boolean moveUp, moveDown, moveLeft, moveRight;
boolean rotateClockwise, rotateCounterClockwise;
boolean rotateUp, rotateDown;
boolean scaleUp, scaleDown;
boolean flipHorizontal;

float thickness = 20; // Ketebalan huruf

void setup() {
  size(1000, 700, P3D);

  mah = createShape(GROUP);

// Huruf M
PShape mFront = createFace(new float[][] {
  {0, 0}, {0, 200}, {40, 200}, {40, 95}, {75, 200},
  {115, 200}, {150, 95}, {150, 200}, {190, 200},
  {190, 0}, {130, 0}, {95, 110}, {60, 0}
}, 0);
PShape mBack = createFace(new float[][] {
  {0, 0}, {0, 200}, {40, 200}, {40, 95}, {75, 200},
  {115, 200}, {150, 95}, {150, 200}, {190, 200},
  {190, 0}, {130, 0}, {95, 110}, {60, 0}
}, thickness);
PShape mSides = createSides(new float[][] {
  {0, 0}, {0, 200}, {40, 200}, {40, 95}, {75, 200},
  {115, 200}, {150, 95}, {150, 200}, {190, 200},
  {190, 0}, {130, 0}, {95, 110}, {60, 0}
}, thickness);

PShape m = createShape(GROUP);
m.addChild(mFront);
m.addChild(mBack);
m.addChild(mSides);

// Huruf A dengan lubang trapesium di tengahnya
float[][] outerA = {
  {210, 200}, {250, 0}, {320, 0}, {360, 200}, // Outer vertices
  {315, 200}, {305, 150}, {265, 150}, {255, 200} // Bottom part
};

float[][] innerA = {
  {260, 110}, {280, 30}, {290, 30}, {310, 110} // Inner vertices for the hole
};

PShape aFront = createFaceWithHole(outerA, innerA, 0);
PShape aBack = createFaceWithHole(outerA, innerA, thickness);
PShape aSides = createSidesWithHole(outerA, innerA, thickness);

PShape a = createShape(GROUP);
a.addChild(aFront);
a.addChild(aBack);
a.addChild(aSides);

// Huruf H
PShape hFront = createFace(new float[][] {
  {370, 0}, {370, 200}, {410, 200}, {410, 120},
  {450, 120}, {450, 200}, {490, 200}, {490, 0},
  {450, 0}, {450, 80}, {410, 80}, {410, 0}
}, 0);
PShape hBack = createFace(new float[][] {
  {370, 0}, {370, 200}, {410, 200}, {410, 120},
  {450, 120}, {450, 200}, {490, 200}, {490, 0},
  {450, 0}, {450, 80}, {410, 80}, {410, 0}
}, thickness);
PShape hSides = createSides(new float[][] {
  {370, 0}, {370, 200}, {410, 200}, {410, 120},
  {450, 120}, {450, 200}, {490, 200}, {490, 0},
  {450, 0}, {450, 80}, {410, 80}, {410, 0}
}, thickness);

PShape h = createShape(GROUP);
h.addChild(hFront);
h.addChild(hBack);
h.addChild(hSides);

mah.addChild(m);
mah.addChild(a); // Memasukkan huruf A yang telah diperbarui dengan lubang trapesium
mah.addChild(h);

centerObject();

}

void draw() {
  noStroke();
  background(0);  // Mengubah warna latar belakang menjadi abu-abu

  // Adjust translation to center of "A" (width of M + half width of A)
  float aCenterX = 210 + 75;
  float aCenterY = 100; // Half the height of A

  translate(posX, posY, 0); // Centering in the canvas
  translate(aCenterX, aCenterY, 0); // Move origin to the center of "A"
  if (mirror) scale(-1, 1, 1); // Pembalikan horizontal
  rotateX(angleX); // Rotasi di sumbu X untuk efek 3D vertikal
  rotateY(angleY); // Rotasi di sumbu Y untuk efek 3D horizontal
  scale(scaleFactor); // Skala
  translate(-aCenterX, -aCenterY, 0); // Move back to original position
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
    angleY += 0.1;
  }
  if (rotateCounterClockwise) {
    angleY -= 0.1;
  }
  if (rotateUp) {
    angleX -= 0.1;
  }
  if (rotateDown) {
    angleX += 0.1;
  }
  if (scaleUp) {
    scaleFactor += 0.01;
  }
  if (scaleDown) {
    scaleFactor -= 0.01;
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
    if (key == 'w') rotateUp = true;
    if (key == 's') rotateDown = true;
    if (key == 'o') scaleUp = true;
    if (key == 'p') scaleDown = true;
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
    if (key == 'w') rotateUp = false;
    if (key == 's') rotateDown = false;
    if (key == 'o') scaleUp = false;
    if (key == 'p') scaleDown = false;
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

PShape createFace(float[][] vertices, float z) {
  PShape face = createShape();
  face.beginShape();
  face.fill(255);
  face.stroke(0);
  for (int i = 0; i < vertices.length; i++) {
    face.vertex(vertices[i][0], vertices[i][1], z);
  }
  face.endShape(CLOSE);
  return face;
}

PShape createSides(float[][] vertices, float thickness) {
  PShape sides = createShape();
  sides.beginShape(QUADS);
  sides.fill(200); // Warna sisi
  sides.stroke(0);

  for (int i = 0; i < vertices.length; i++) {
    int next = (i + 1) % vertices.length;
    sides.vertex(vertices[i][0], vertices[i][1], 0);
    sides.vertex(vertices[next][0], vertices[next][1], 0);
    sides.vertex(vertices[next][0], vertices[next][1], thickness);
    sides.vertex(vertices[i][0], vertices[i][1], thickness);
  }
  sides.endShape(CLOSE);
  return sides;
} // <-- ADDED CLOSING BRACE

PShape createFaceWithHole(float[][] outerVertices, float[][] innerVertices, float z) {
  PShape face = createShape();
  face.beginShape();
  face.fill(255);
  face.stroke(0);
  for (int i = 0; i < outerVertices.length; i++) {
    face.vertex(outerVertices[i][0], outerVertices[i][1], z);
  }
  face.beginContour();
  for (int i = innerVertices.length - 1; i >= 0; i--) { // Reverse direction for hole
    face.vertex(innerVertices[i][0], innerVertices[i][1], z);
  }
  face.endContour();
  face.endShape(CLOSE);
  return face;
}

PShape createSidesWithHole(float[][] outerVertices, float[][] innerVertices, float thickness) {
  PShape sides = createShape();
  sides.beginShape(QUADS);
  sides.fill(200); // Warna sisi
  sides.stroke(0);

  for (int i = 0; i < outerVertices.length; i++) {
    int next = (i + 1) % outerVertices.length;
    sides.vertex(outerVertices[i][0], outerVertices[i][1], 0);
    sides.vertex(outerVertices[next][0], outerVertices[next][1], 0);
    sides.vertex(outerVertices[next][0], outerVertices[next][1], thickness);
    sides.vertex(outerVertices[i][0], outerVertices[i][1], thickness);
  }

  for (int i = 0; i < innerVertices.length; i++) {
    int next = (i + 1) % innerVertices.length;
    sides.vertex(innerVertices[i][0], innerVertices[i][1], 0);
    sides.vertex(innerVertices[next][0], innerVertices[next][1], 0);
    sides.vertex(innerVertices[next][0], innerVertices[next][1], thickness);
    sides.vertex(innerVertices[i][0], innerVertices[i][1], thickness);
  }
  sides.endShape(CLOSE);
  return sides;
}
