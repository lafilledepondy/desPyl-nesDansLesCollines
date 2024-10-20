//Gère les touches de clavier

void mouseWheel(MouseEvent event) {
  if(event.getCount() == -1){
    posY -= scale*scale*scale;
  }else{
    posY += scale*scale*scale; 
    //println("Mouse wheel scrolled");
  }
}

/*
void mouseMoved() {
  // Map mouseY to a smaller range within the valid range for centreZ
  float newCentreZ = map(mouseY, 0, height, minZ, maxZ);
  
  // Update centreZ with the mapped value
  centreZ = newCentreZ;
}
*/

void keyPressed() {
  //Modifier l'hauteur du joueur
  if (keyCode == UP) {
    movingUp = true;
  } else if (keyCode == DOWN) {
    movingDown = true;
  } else if (keyCode == RIGHT) {
    movingRight = true;
  } else if (keyCode == LEFT) {
    movingLeft = true;
    
  //Deplacer le joueur sur l'axe x et y 
  }else if(keyCode == 'W' || keyCode == 'w'){
    goingUp = true;
  }else if(keyCode == 'S' || keyCode == 's'){
    goingDown = true;
  }else if(keyCode == 'A' || keyCode == 'a'){
    goingLeft = true;
  }else if(keyCode == 'D' || keyCode == 'd'){
    goingRight = true;
    
  //Afficher ou cacher les modèles
  }else if(keyCode == '2'){
    shaders = !shaders;
  }else if (keyCode == '3'){
    pylones = !pylones;
  }else if (keyCode == '4'){
    lignesElec = !lignesElec;
  }else if (keyCode == '5'){
    heolienne = ! heolienne;
  }
    
}

void keyReleased() {
  if (keyCode == UP) {
    movingUp = false;
  } else if (keyCode == DOWN) {
    movingDown = false;
  } else if (keyCode == RIGHT) {
    movingRight = false;
  } else if (keyCode == LEFT) {
    movingLeft = false;
  }else if(keyCode == 'W' || keyCode == 'w'){
    goingUp = false;
  }else if(keyCode == 'S' || keyCode == 's'){
    goingDown = false;
  }else if(keyCode == 'A' || keyCode == 'a'){
    goingLeft = false;
  }else if(keyCode == 'D' || keyCode == 'd'){
    goingRight = false;
  }else if (keyCode == 32) {
    if (! music.isPlaying()) {
      System.out.println("PLAY");
      music.play();
    }else{
      music.pause();
      System.out.println("PLAY");
    }
  }
}
void handleKeys() {
 if (movingUp) {
   posZ+=scale; centreZ+= scale;
 }else if (movingDown) {
   posZ-=scale; centreZ-= scale;
 }else if(movingRight){     
   
   float relX = centreX - posX;
   float relY = centreY - posY;
  
   // Rotate the relative position around the origin (0, 0)
   float newX = relX * cos(theta) - relY * sin(theta);
   float newY = relX * sin(theta) + relY * cos(theta);
  
   // Translate the rotated position back to the original coordinate system
   centreX = newX + posX;
   centreY = newY + posY;
   
   //float newX = cos(theta) * (centreX - posX) - sin(theta) * (centreY - posY) + posX;
   //float newY = sin(theta) * (centreX - posX) + cos(theta) * (centreY - posY) + posY;
   
   //centreX= cos(theta) * centreX + sin(theta) * centreY; 
   //centreY= cos(theta) * centreY - sin(theta) * centreY;
 }else if(movingLeft){
   
   cosAngle += theta;
   sinAngle += theta;
   
   //float newX = cos(-theta) * (centreX - posX) - sin(-theta) * (centreY - posY) + posX;
   //float newY = sin(-theta) * (centreX - posX) + cos(-theta) * (centreY - posY) + posY;
    
   //centreX = newX;
   //centreY = newY;
    
   //centreX= cos(theta) * centreX - sin(theta) * centreX; 
   //centreY= cos(theta) * centreY + sin(theta) * centreY;
 }else if(goingUp){
   posY-=scale; centreY-= scale;
 }else if(goingDown){
   posY+=scale; centreY+= scale;
 }else if(goingRight){
   posX+=scale; centreX+= scale;
 }else if(goingLeft){
   posX-=scale; centreX-= scale;
 }
}
