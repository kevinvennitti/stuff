class Timer {

  int savedTime;
  int totalTime;

  Timer(int tempTotalTime) {
    totalTime = tempTotalTime;
  }

  void start() {
    savedTime = millis();
  }

  boolean isFinished() { 
    int passedTime = millis()- savedTime;
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }

  int passedTime() {
    return millis()- savedTime;
  }
}



void initTimerScroll() {
  timer = new Timer(1000+round(random(dureeChangement)));
  timer.start();
}

void checkTimerScroll(Boolean forceSwitch) {
  if (timer.isFinished() || forceSwitch) {
    initTimerScroll();
    sens = !sens;
    
    if (sens && firstSensTop) {
      firstSensTop = false;
    }
    
    if (!sens && firstSensBottom) {
      firstSensBottom = false;
    }
    
    countScrollSens = 0;
  }
}





void initTimerEndGame() {
  timerEndGame = new Timer(dureeEndGame);
  timerEndGame.start();
}

void checkTimerEndGame() {
  if (timerEndGame.isFinished()) {
    newGame();
  }
}

