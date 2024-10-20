uniform float minZ; // Valeur minimale de z (non utilisée ici)
uniform float maxZ; // Valeur maximale de z (non utilisée ici)

// Coordonnées interpolées du fragment
float zInterpolated = vZ; 

void main() {
    // Déterminez les bornes des niveaux de z (exemple)
/*    float level1 = -185.0; // Niveau 1
    float level2 = -195.0; // Niveau 2
*/
    float moduloStart = 0.0; // Début de la plage pour le test du modulo
    float moduloEnd = 1.0; // Fin de la plage pour le test du modulo


    // Testez si zInterpolated se situe entre deux niveaux
    float modulo = mod(zInterpolated, 100.0);
    if (modulo >= moduloStart && modulo <= moduloEnd) {
        // Rendre le pixel noir (ou plus foncé)
        gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0); // Noir opaque
    } else {
        // Utiliser la texture par défaut
        discard; // gl_FragColor = ;
        
        // Teinter la vallée en vert si Z interpolé est inférieur à une certaine valeur
        if (zInterpolated < minZ) {
            gl_FragColor = vec4(0.0, 1.0, 0.0, 1.0); // Vert opaque
        }
    }
}