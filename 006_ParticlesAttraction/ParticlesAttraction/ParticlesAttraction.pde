/*  
 *  ParticlesAttraction
 *  
 *  Ce script permet de générer des particules
 *  au clic et d'attirer les autres particules
 *  proportionnellement à leurs distances.
 *
 */
 
int nbParticules = 100;    // Nombre de particules générées au lancement du script (0 pour ne pas en mettre)
int canvasWidth = 400;     // Largeur du canvas
int canvasHeight = 400;    // Hauteur du canvas

float lastPartX = 0;       // Position x de la dernière particule ajoutée
float lastPartY = 0;       // Position y de la dernière particule ajoutée

Part Particules[] = new Part[0];  // Tableau qui contient toutes les particules

void setup() {
  size(canvasWidth, canvasHeight);
  frameRate(60);
  smooth();
  background(255);

  /////////////////////////////////////////////////////
  // On génère les particules au chargement du script
  // en les ajoutant dans le tableau des particules
  
  for (int i = 0; i < nbParticules; i++) {
    Particules = (Part[]) append(Particules, new Part(i, random(canvasWidth), random(canvasHeight)));
  }
}

void draw() {
  background(255);

  /////////////////////////////////////////////////////
  // On parcourt le tableau des particules,
  // on met à jour leur position et on les affiche
  
  for (int i = 0; i < Particules.length; i++) {
    Particules[i].updatePosition();
    Particules[i].draw();
  }
}
