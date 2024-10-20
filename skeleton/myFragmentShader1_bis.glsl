#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;
varying vec4 vertPosition;

void main() {
  int discr = int((vertPosition.y + 5.) / 10.);
  if(discr % 5 == 0) {
    gl_FragColor = vec4(0.,0.,0.,1.);
  } else {
    gl_FragColor = vertColor;
  }
  //gl_FragColor = vertColor;
}
