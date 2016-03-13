/*  
 *  class Part
 *  
 *  Chaque particule générée possède
 *  la même structure définie ci-dessous.
 *
 */

class Part {
  float x;        // Position x de la particule
  float y;        // Position y de la particule

  float saveX;    // Position x sauvegardée lorsqu'une attirance est déclenchée
  float saveY;    // Position y sauvegardée lorsqu'une attirance est déclenchée

  float dx;       // Décalage x de transition entre deux positions
  float dy;       // Décalage y de transition entre deux positions

  float easing = .05;  // Facteur de transition cool
  int diam = 5;        // Diamètre de la particule
  int id;              // Id de la particule


  /////////////////////////////////////////////////////
  // Lorsqu'on génère une particule,
  // on lui fournit des paramètres uniques,
  // comme la position (aléatoire ou via le clic)
  // ou l'id

    Part (int input_id, float input_x, float input_y) {
    x = input_x;
    y = input_y;
    saveX = input_x;
    saveY = input_y;
    id = input_id;
  }


  /////////////////////////////////////////////////////
  // On met à jour la position de la particule
  // en considérant la translation par attirance

  void updatePosition() {

    /////////////////////////////////////////////////////
    // Comment fonctionne la transition de la particule ?
    // 
    // Lorsqu'on clique et qu'on génère une nouvelle particule,
    // on stocke dans lastPartX et lastPartY la position de cette nouvelle particule.
    //
    // Ensuite, ici, on calcule la distance entre ce point
    // (qui est donc le point vers lequel doit se diriger chaque particule)
    // et notre point actuel.
    // La fonction dist() nous donne alors cette distance.

    float dist = dist(x, y, lastPartX, lastPartY);


    /////////////////////////////////////////////////////
    // Ensuite, avec cette distance, on définit
    // l'attirance du point, et par extension
    // son déplacement.
    //
    // Plus les deux points sont proches,
    // plus ils sont attirés.
    //
    // Vous pouvez définir la distance maximale
    // pour attirer un point.
    //
    // Vous pouvez aussi définir la force
    // d'attirance : de 0 à 100, on augmente l'attirance.
    
    int maximumDistance = 100;
    int puissanceAttirance = 40;
    
    float attirance = max(map(dist, 0, maximumDistance, puissanceAttirance, 0), 0);


    float closePointX = (lastPartX-saveX)*attirance/100+saveX;
    float closePointY = (lastPartY-saveY)*attirance/100+saveY;


    noStroke();
    fill(0, 255, 0);
    ellipse(closePointX, closePointY, 3, 3);


    dx = closePointX - x;
    dy = closePointY - y;


    if (abs(dx) > 1) {
      x += dx * easing;
    }
    if (abs(dy) > 1) {
      y += dy * easing;
    }
  }

  void setSavePosition() {
    saveX = x;
    saveY = y;
  }

  void draw() {
    noStroke();
    fill(0);
    ellipse(x, y, diam, diam);
  }
}

