void mousePressed() {
  Particules = (Part[]) append(Particules, new Part(Particules.length, mouseX, mouseY));

  lastPartX = mouseX;
  lastPartY = mouseY;

  for (int i = 0; i < Particules.length; i++) {
    Particules[i].setSavePosition();
  }
}

void mouseMoved() {
//  Particules = (Part[]) append(Particules, new Part(Particules.length, mouseX, mouseY));

  lastPartX = mouseX;
  lastPartY = mouseY;

  for (int i = 0; i < Particules.length; i++) {
    Particules[i].setSavePosition();
  }
}
