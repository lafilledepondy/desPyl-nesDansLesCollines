ArrayList<PVector> findHighestPositions() {
  ArrayList<PVector> highestPositions = new ArrayList<PVector>();
  int numberOfEoliennes = 7; // Adjust the number of wind turbines as needed
  float stepSize = Tdepth / numberOfEoliennes; // Calculate the step size for dividing the terrain height
  
  // Loop through the number of wind turbines
  for (int i = 0; i < numberOfEoliennes; i++) {
    float minZRange = minZ + i * stepSize; // Calculate the minimum Z value for the current range
    float maxZRange = maxZ;//minZ + (i + 1) * stepSize; // Calculate the maximum Z value for the current range
    
    float highestZ = minZRange;
    PVector highestPosition = new PVector();
    
    // Loop through all vertices to find the highest point within the current range
    for (PVector vertex : vertices) {
      if (vertex.z >= minZRange && vertex.z <= maxZRange && vertex.z > highestZ) {
        highestZ = vertex.z;
        highestPosition.set(vertex);
      }
    }
    
    highestPositions.add(highestPosition); // Add the highest position within the range to the list
    System.out.println("xHighPos: "+ highestPosition.x + " yHighPos: "+ highestPosition.y  + "zHighPos: "+ highestPosition.z);
  }
  
  return highestPositions;
}


void drawCylinder(float radius, int h) {
  int detail = 30; // Number of segments around the circumference
  
  // Bottom circle
  beginShape();
  for (int i = 0; i < detail; i++) {
    float angle = TWO_PI / detail * i;
    float x = cos(angle) * radius;
    float y = sin(angle) * radius;
    vertex(x, y, h);
  }
  endShape(CLOSE);
  
  // Top circle
  beginShape();
  for (int i = 0; i < detail; i++) {
    float angle = TWO_PI / detail * i;
    float x = cos(angle) * radius;
    float y = sin(angle) * radius;
    vertex(x, y, 0);
  }
  endShape(CLOSE);
  
  // Lines connecting the two bases of the cylinder
  beginShape(LINES);
  for (int i = 0; i < detail; i++) {
    float angle = TWO_PI / detail * i;
    float x = cos(angle) * radius;
    float y = sin(angle) * radius;
   
    vertex(x, y, h); // Bottom circle
    vertex(x, y, 0); // Top circle
  }
  endShape(CLOSE);
}
void drawMatForEolienne(float taille) {
  float halfSize = taille * 2; // Adjust the size as needed
  beginShape();
  vertex(-halfSize, -halfSize, 0); // Bottom left corner
  vertex(halfSize, -halfSize, 0); // Bottom right corner
  vertex(halfSize, halfSize, 0); // Top right corner
  vertex(-halfSize, halfSize, 0); // Top left corner
  endShape(CLOSE);
}
void drawPales(float rotationAngle,float cylinR) { 
  ///HEOLIENNE
  final float bladeLength = 15;
  final float XOffest  = 3; 
  final float YTop = bladeLength * 0.6; //0.6=60% de la longueur totale de la pale vers le haut depuis le centre 
  final float YBottom = bladeLength * 0.1; //0.1=10%    "
  
  stroke(0); 
  strokeWeight(2);   
  
  float cx1 = -XOffest, cy1 = -YTop; 
  float cx2 = XOffest, cy2 = -YTop;
  float cx3 = -(XOffest/2), cy3 = -YBottom;
  float cx4 = XOffest/2, cy4 = -YBottom;
  
  //Dessiner les 3 pales d'éolienne
  for (int i = 0; i < 3; i++) {
    float angle = TWO_PI / 3 * i;
    pushMatrix();
    rotate(angle + rotationAngle);
    beginShape();
    vertex(0, 0);
    bezierVertex(cx1, cy1, cx3, cy3, 0, -bladeLength);
    endShape();
    
    beginShape();
    vertex(0, 0);
    bezierVertex(cx2, cy2, cx4, cy4, 0, -bladeLength);
    endShape();
    popMatrix();
  }
  
  //ellipse(0, 0, cylinR, cylinR);
}
void drawEoliennes(){
  
  for(PVector vec : findHighestPositions()){
    drawEolienne(vec);
  }
}
void drawEolienne(PVector pos){
  int cylinH = 50; //Hauteur de l'eolienne
  float cylinR = 1;
  float rotationAngle = radians(frameCount * 2); 
  
  pushMatrix();
  translate(pos.x, pos.y, pos.z);
  //Le corps de l'heolienne
  drawMatForEolienne(cylinR);
  drawCylinder(cylinR, cylinH);
  
  translate(0,cylinH/32,cylinH);
  rotateX(PI/2);
  drawCylinder(cylinR, cylinH/16);
  
  drawPales(rotationAngle,cylinR);
  
  PVector posSound = new PVector(pos.x,pos.y,pos.z+cylinH);
  adjustSoundEol(posSound);        
  
  popMatrix();
}
