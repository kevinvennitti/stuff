void newGame() {
  score = 0;
  
  state = WAITING;
  
  firstSensTop = true;
  firstSensBottom = true;
}

void startGame() {
  timerTotal = new Timer(dureeTempsTotal);
  timerTotal.start();

  initTimerScroll();
  
  state = PLAYING;
}

void endGame() {
  println("Votre score : "+score);
  initTimerEndGame();
  state = SCORING;
  
  go_opacityText = 255;
  go_opacity = 255;
}

