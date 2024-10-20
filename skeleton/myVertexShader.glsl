uniform mat4 transform;
uniform mat4 modelview;
uniform mat4 texMatrix;

attribute vec4 position;
attribute vec4 color;
attribute vec2 texCoord;
attribute vec3 normal;

varying vec2 vTexCoord;
varying float vZ;
varying float vZvert;

void main() {
	vec4 nposition = vec4(position.x, position.y, position.z + texCoord.x, position.w);
	gl_Position = transform * position;
	vTexCoord = (texMatrix*vec4(texCoord, 0.0, 1.0)).xy;
	vZ = position.z * 1000.0; 
	vZvert = -203; //-203
}