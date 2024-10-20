uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;

uniform vec4 lightPosition;

attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;

varying vec4 vertColor;
varying vec4 vertPosition;

void main() {
  gl_Position = transform * position;    
  vec3 ecPosition = vec3(modelview * position);  
  vec3 ecNormal = normalize(normalMatrix * normal);

  vec3 direction = normalize(lightPosition.xyz - ecPosition);    
  float intensity = max(0.0, dot(direction, ecNormal));

  // Use the parameters above to compute vertColor e.g.
  vertColor = vec4(intensity, intensity, intensity, 1) * color; 
  vertPosition = position;
//  if(position.y >= -5. && position.y <= 5.) {
// if(gl_Position.y >= -5. && gl_Position.y <= 5.) {
//  int discr = int((ecPosition.y + 5.) / 10.);
//  if(4 <= discr && discr <= 6) {
//    vertColor = vec4(0.,0.,0.,1.);
//  } else {
//    vertColor = vertColor;
//  }
}