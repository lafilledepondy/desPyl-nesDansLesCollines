PShape Terrain;
String terrain_path = "TerrainFiles/hypersimple.obj";
PShader monProgrammeShader;

float minX = -135; float minY = -158; float minZ = -202.09592;
float maxX = 127; float maxY = 159; float maxZ = -179.59933;

float scale = 2.5;

//Taille du terrain
float Twidth = maxX - minX;
float Theight = maxY - minY;
float Tdepth= maxZ - minZ;

float terrainSize = dist(minX, minY, maxX, maxY);


//La position du joueur
float posX, posY,posZ;
float centreX, centreY, centreZ;
float eyeX; float eyeY; float eyeZ = 0;

float cosAngle; float sinAngle;
float theta = PI/32;

String[] lines; // Array to store lines of the file
ArrayList<PVector> vertices; // ArrayList to store vertex coordinates

int NPylones = 25;//Le nombres de pylones

//Keys for moving
boolean movingUp = false; boolean movingDown = false;
boolean movingRight = false; boolean movingLeft = false;

boolean goingUp = false; boolean goingDown = false;
boolean goingRight = false; boolean goingLeft = false;

// Cacher/Afficher les diff modèles
boolean shaders = true;
boolean pylones = true;
boolean lignesElec = true;
boolean heolienne = true;

//EOLIENNE

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer music;

public void setup(){
  size(1920,1000,P3D);
  Terrain = loadShape(terrain_path);
  //System.out.println("childCount(): " + Terrain.getChildCount());
  
  monProgrammeShader = 
    loadShader("Shaders2/myFragmentShader2.glsl", 
               "Shaders2/myVertexShader2.glsl");
  
  cosAngle = 1; sinAngle = 0; 
  posX =(maxX +minX)/2 ; posY = maxY; posZ = maxZ+150;
  centreX = cos(cosAngle) + (maxX +minX)/2; centreY = sin(sinAngle) + (maxY + minY)/2; centreZ = minZ;
  eyeX =0; eyeY=1;
  
  float fov = PI/3.0; // 60 degrés
  float aspect = width/height;
  float near = 0.1;
  float far = 5000.0;
  
  perspective(fov, aspect, near, far);
   
   
  // Load the lines of the file into the 'lines' array
  lines = loadStrings(terrain_path);
  
  // Initialize the ArrayList
  vertices = new ArrayList<PVector>();
  
  // Parse the object file
  // We iterate through each line of the file and split it into words.
  // We check if the line starts with 'v', indicating a vertex line. If it does, we extract the vertex coordinates and create a PVector object to represent the vertex.
  parseObjFile();
  
  println("Number of vertices: " + vertices.size());
  
  minim = new Minim(this);
  music = minim.loadFile("MusicSamples/WindTurbineSound.mp3");
  
  music.loop(); 
}    

public void draw(){
  background(255);
  lights();
  
  drawAxes(200);
  handleKeys();
  camera( posX, posY,posZ,
        centreX, centreY, centreZ,
        eyeX, eyeY, eyeZ);
  //System.out.println("centreX: " + centreX+ " centreY: "+centreY);
  shape(Terrain);  
  
  
  //drawVerticalLine( (maxX+minX)/2, (maxY+minY)/2, 200);   // Example line at (100, 100) extending to z = 200
  //drawVerticalLine(127-50, 159-50, 300);   // Example line at (200, 300) extending to z = 300
  
  //System.out.println("milZ: "+ milZ);
  //drawPylones( milX ,milY,milZ);
  
  //float posZ = findTerrainZ(minX+30, milY);
  //System.out.println("posZ: "+ posZ);
  //drawPylones(minX+30,milY,posZ);
  //ie 20,100 et 40.-115
  
  if (shaders) {
    shader(monProgrammeShader);
  } else {
    resetShader();
  }
  
  PVector pointDeb = new PVector(20, 100);
  PVector pointFin = new PVector(40, -115);
  drawPyloneWLines(pointDeb, pointFin);
  /*
  float milX= (maxX+minX)/2; float milY = (maxY+minY)/2; float milZ = findTerrainZ(milX, milY);
  PVector mil= new PVector(milX,milY,milZ);
  drawEolienne(mil);
  */
  drawEoliennes();
}


void dispose() {
  music.close();
  minim.stop();
  super.dispose();
}

void drawAxes(float length) {
  float zOffset = maxZ;  // Z offset value to position the axes above maxZ
  
  // Axe X (Rouge)
  stroke(255, 0, 0);
  line(-length, 0, zOffset, length, 0, zOffset);
  
  // Axe Y (Vert)
  stroke(0, 255, 0);
  line(0, -length, zOffset, 0, length, zOffset);
  
  // Axe Z (Bleu)
  stroke(0, 0, 255);
  line(0, 0, -length, 0, 0, length);
}
