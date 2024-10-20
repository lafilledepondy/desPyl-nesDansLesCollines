#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;

uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

varying float mdlZ;

void main() {
    //plus le pourcentage augmente plus on l'altitude diminue
    //la valeur minimum qu'on a dans le modele avec ce pourcentage est 0.88 (mdl = -179)
    //la valeur maximale est 1.0 (mdl = -202)
    //on utilise un pourcentage pour que ça soit plus facile a manipuler
    //si on veut que le modele soit plus vert, on diminue la valeur de la borne minimum du if (0.95)
    if((mdlZ/-202) > 0.975){
        vec4 vertC = vec4(0.04, 0.6, 0.12, 1.0);
        gl_FragColor = texture2D(texture, vertTexCoord.st) * vertC;
    }
    //on a un ecart de 22 entre le z le plus petit et le plus grand
    //on fait un modulo 1 comme ça on a une bonne quantite de lignes dans le modele
    //si on avait modulo 20 par exemple, y aurait presque pas de lignes
    else if((mod(mdlZ, 1.0) > 0.1) && (mod(mdlZ, 1.0) < 0.2)){
        vec4 noirC = vec4(0.0,0.0,0.0,1.0);
        gl_FragColor = texture2D(texture, vertTexCoord.st) * noirC;

    }
    else {
        gl_FragColor = texture2D(texture, vertTexCoord.st) * vertColor;
    }
}
