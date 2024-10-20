float cubeSize = 0.25;
color pyloneCouleur = color(0.8, 0.8, 0.8);
float halfSize = cubeSize / 2.0;

void diagonalsCube() {
  pushMatrix();
  //rotateX(PI/2);
  float[][] vertices = {
    {-halfSize, -halfSize, -halfSize},
    {halfSize, -halfSize, -halfSize}, // Vertex 1
    {halfSize, halfSize, -halfSize}, // Vertex 2
    {-halfSize, halfSize, -halfSize}, // Vertex 3
    {-halfSize, -halfSize, halfSize}, // Vertex 4
    {halfSize, -halfSize, halfSize}, // Vertex 5
    {halfSize, halfSize, halfSize}, // Vertex 6
    {-halfSize, halfSize, halfSize}    // Vertex 7
  };

  for (int i = 0; i < 6; i++) {
    int v1 = i % 4;
    int v2 = (i + 1) % 4;
    int v3 = (i + 4) % 8;
    int v4 = (i + 1) % 4 + 4;

    stroke(pyloneCouleur);

    line(vertices[v1][0], vertices[v1][1], vertices[v1][2], vertices[v3][0], vertices[v3][1], vertices[v3][2]); // Diagonal 1
    line(vertices[v1][0], vertices[v1][1], vertices[v1][2], vertices[v4][0], vertices[v4][1], vertices[v4][2]); // Diagonal 3
    line(vertices[v2][0], vertices[v2][1], vertices[v2][2], vertices[v3][0], vertices[v3][1], vertices[v3][2]); // Diagonal 4
    line(vertices[v1][0], vertices[v1][1], vertices[v1][2], vertices[v2][0], vertices[v2][1], vertices[v2][2]); // Diagonal 5
    line(vertices[v3][0], vertices[v3][1], vertices[v3][2], vertices[v4][0], vertices[v4][1], vertices[v4][2]); // Diagonal 6
  }
  popMatrix();
}

void pyramide(float coordX, float coordY, float coordZ) {
  pushMatrix();
  beginShape(TRIANGLES);
  // \/ front
  vertex(-coordX, coordY, coordZ);
  vertex(coordX, coordY, coordZ);
  vertex(0, 0, 0);

  // \/ side left
  vertex(coordX, coordY, -coordZ);
  vertex(coordX, coordY, coordZ);
  vertex(0, 0, 0);

  // \/ right
  vertex(-coordX, coordY, -coordZ);
  vertex(-coordX, coordY, coordZ);
  vertex(0, 0, 0);

  // \/ back
  vertex(coordX, coordY, -coordZ);
  vertex(-coordX, coordY, -coordZ);
  vertex(0, 0, 0);
  endShape();
  popMatrix();
  
  float h = coordY/3;
  float k = 4*(5*pow(coordX, 2)*sqrt(4*pow(coordY, 2)+pow(coordX, 2))/(6*(4*pow(coordY, 2)+pow(4, 2))));
  
  noFill(); // Disable filling
  //noTexture(); // Disable texture mapping
  stroke(pyloneCouleur);
  strokeWeight(1);
  // Front face diagonals
  line(-coordX, coordY, coordZ, k, h, coordZ / 3);
  line(coordX, coordY, coordZ, -k, h, coordZ / 3);

  // Side left face diagonals
  line(coordX, coordY, -coordZ, k, h, -coordZ / 3);
  line(coordX, coordY, coordZ, k, h, -coordZ / 3);

  // Right face diagonals
  line(-coordX, coordY, -coordZ, -k, h, -coordZ / 3);
  line(-coordX, coordY, coordZ, -k, h, -coordZ / 3);

  // Back face diagonals
  line(coordX, coordY, -coordZ, -k, h, -coordZ / 3);
  line(-coordX, coordY, -coordZ, k, h, -coordZ / 3);
}

PVector[] drawPylone(float x, float y, float z) {
  
  PVector[] pairSommet = new PVector[2];
  int max = 16;
  pushMatrix();
  translate(x, y, z+halfSize);
  for (int i=0; i<max; i++) {
    if(i==max-3){
      pushMatrix();
      translate((-cubeSize*3) -halfSize, 0, 0);
      rotateZ(-PI / 2); //Sommet vers à la gauche
      rotateY(-PI / 2);
      pyramide(cubeSize/2, 3*cubeSize, cubeSize/2);
      PVector vLeft = new PVector(modelX(0,0,0),modelY(0,0,0),modelZ(0,0,0));
      pairSommet[1]=(vLeft);      
      popMatrix();

      pushMatrix();      
      translate((cubeSize*3) +halfSize,0, 0);
      rotateZ(PI / 2); //Somme vers à la droite
      rotateY(-PI / 2);
      pyramide(cubeSize / 2, 3 * cubeSize, cubeSize / 2);      
      PVector vRight = new PVector(modelX(0,0,0),modelY(0,0,0),modelZ(0,0,0));
      pairSommet[0]=(vRight);
      popMatrix();      
  }else if(i==max-1){
      translate(0, 0, halfSize);
      rotateX(-PI / 2); //sommet vers le haut
      pyramide(cubeSize, cubeSize, cubeSize/2);
      break;
    }    
    diagonalsCube();
    translate(0, 0, cubeSize);
  }
  popMatrix();
  return pairSommet;
}
