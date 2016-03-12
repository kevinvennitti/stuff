Timer timerTotal;
Timer timer;
Timer timerEndGame;

int score = 0;  
int countScrollSens = 0;

boolean sens = true;

color couleurScrollBarre = color(252);
color couleurScroll = color(194);

color couleurFond1 = color(255, 154, 141);
color couleurFond2 = color(88, 240, 220);

float easing = 0.2;
float easing2 = 0.1;
float easing3 = 0.05;

int dureeTempsTotal = 15000;
int dureeChangement = 1500;
int dureeEndGame = 5000;

int WAITING = 0;
int PLAYING = 1;
int SCORING = 2;

int state;

float radiusScreen;

int go_size = 0;
int go_opacity = 255;
int go_opacityText = 255;

int score_radiusOuter = 0;

int fond_size1 = 0;
int fond_opacity1 = 0;
int fond_size2 = 0;
int fond_opacity2 = 0;

boolean firstSensTop, firstSensBottom;

PFont font;
PImage cursor, scrollUp, scrollDown;

void setup() {
  size(500, 700);
  smooth();

  font = loadFont("Panamera-Bold-50.vlw");
  cursor = loadImage("cursor.png");
  scrollUp = loadImage("scrollUp.png");
  scrollDown = loadImage("scrollDown.png");

  radiusScreen = sqrt(((width/2)*(width/2)) + ((height/2)*(height/2)))*2+40;

  newGame();
}

void draw() {
  background(couleurFond2);

  displayFond();
  displayScroll();

  if (is(PLAYING)) {
    if (timerTotal.isFinished()) {
      endGame();
    } else {
      checkTimerScroll(false);
    }
  }

  displayGo();

  if (is(PLAYING) || is(SCORING)) {
    displayScore();
    
    if (firstSensTop && !sens) {
      image(scrollDown,width/2-25,height/2+150);
    }
    
    if (firstSensBottom && sens) {
      image(scrollUp,width/2-25,height/2-260);
    }
  }

  if (is(SCORING)) {
    checkTimerEndGame();
  }
} 

void mouseWheel(MouseEvent event) {
  if (is(PLAYING)) {
    if (!timerTotal.isFinished()) {
      float e = event.getCount();

      if (sens == true) {
        score += int(e/10);
      } else {
        score -= int(e/5);
      }

  score = min(max(score, 0), displayHeight-150);

      countScrollSens += abs(e/5);

      if (countScrollSens > 200) {
        checkTimerScroll(true);
      }
    }
  }
}

void mousePressed() {
  if (is(WAITING)) {    
    startGame();
  }
}