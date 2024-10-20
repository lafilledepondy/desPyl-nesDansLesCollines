float findTerrainZ(float x, float y) {
  float closestZ = 0;         // Initialize the closest z-coordinate
  float closestDist = Float.MAX_VALUE;  // Initialize the closest distance with a large value
  
  // Loop through all vertices of the terrain
  for (PVector vertex : vertices) {
    float vertexX = vertex.x;
    float vertexY = vertex.y;
    float vertexZ = vertex.z;
    
    // Calculate the squared Euclidean distance between the vertex and the specified (x, y) point
    float distSquared = (vertexX - x) * (vertexX - x) + (vertexY - y) * (vertexY - y);
    
    // Check if this squared distance is the smallest found so far
    if (distSquared < closestDist) {
      closestDist = distSquared;
      closestZ = vertexZ;  // Update the closest z-coordinate
    }
  }
  
  return closestZ; // Return the closest z-coordinate
}
void parseObjFile() {
  for (String line : lines) {
    // Split the line into words
    String[] words = splitTokens(line);
    
    // Check if it's a vertex line (starts with 'v')
    if (words.length > 0 && words[0].equals("v")) {
      // Extract vertex coordinates
      float x = Float.parseFloat(words[1]);
      float y = Float.parseFloat(words[2]);
      float z = Float.parseFloat(words[3]);
      PVector vertex = new PVector(x, y, z);
      
      // Add the vertex to the ArrayList
      vertices.add(vertex);
    }
  }
}
void drawPyloneWLines(PVector pDeb,PVector pFin){
  ArrayList<PVector[]> pairsSommet = new ArrayList<>();
  //System.out.println("pDeb.x: "+pDeb.x+" pDeb.y: "+pDeb.y);
  //System.out.println("pFin.x: "+pFin.x+" pFin.y: "+pFin.y);
  
  PVector gap = PVector.sub(pFin, pDeb);
  gap.div(NPylones);
  
  for (int i = 0 ;i < NPylones ;i++){
    
    float x = pDeb.x + (i * gap.x);
    float y = pDeb.y + (i * gap.y);
    float z = findTerrainZ(x,y);
    //System.out.println("x "+ x + " y "+ y +" z " + z);
    
    if(pylones){
      pairsSommet.add(drawPylone(x,y,z));
    
      if(i>0 && lignesElec ){
        drawElecLines(pairsSommet.get(i-1)[0],pairsSommet.get(i)[0]);
        drawElecLines(pairsSommet.get(i-1)[1],pairsSommet.get(i)[1]);
      }
    }
    
  }
}

void drawElecLines(PVector pInit, PVector pFin){
  // Calculate distance between initial and final points
  float distance = dist(pInit.x, pInit.y, pFin.x, pFin.y);
  float maxdist = distance * 4;
  
  // Calculate curvature based on distance
  // Adjust the parameters to increase the curvature effect
  float minCurvature = 8; // Minimum curvature to ensure the curve stays above the terrain
  float curvature = map(distance, 0, maxdist, -(pInit.y + pInit.z)/2, -(pFin.y + pFin.z)/2); // Adjusted parameters
  curvature = min(curvature, minCurvature); // Ensure that the curvature doesn't go below the minimum
  
  // Draw quadratic curve with adjusted curvature
  noFill();
  stroke(0);
  
  beginShape();
  vertex(pInit.x, pInit.y, pInit.z); // First point
  
  // Calculate control points
  PVector controlPoint = new PVector((pInit.x + pFin.x) / 2, (pInit.y + pFin.y) / 2, min(pInit.z, pFin.z) - curvature / 2); // Reduce curvature
  
  // Draw quadratic curve with adjusted curvature
  quadraticVertex(controlPoint.x, controlPoint.y, controlPoint.z, pFin.x, pFin.y, pFin.z);
  endShape();
}
