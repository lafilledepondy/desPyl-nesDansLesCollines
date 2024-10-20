
void adjustSoundEol(PVector pos) {
  // Calculate the distance between the player and the wind turbine
  float distance = dist(posX, posY, posZ, pos.x, pos.y, pos.z);
  println("Distance: " + distance);
  
  // Map the distance to a volume level
  float maxDistance = terrainSize; // Adjust as needed
  //println("Max Distance: " + maxDistance);
  
  // Map the distance to the volume range (-50 to 6)
  float volume = map(distance, 0, maxDistance, 6, -60);
  //println("Mapped Volume: " + volume);
  
  // Constrain the volume within the valid range (-50 to 6)
  volume = constrain(volume, -50, 6);
  
  // Set the gain (volume) of the music object
  music.setGain(volume);
  
  //println("Volume after adjustment: " + music.getGain());
}
