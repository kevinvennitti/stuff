
import processing.video.*;
import java.awt.Rectangle;

Timer timer = new Timer(100);

int nbPointsHumains;
boolean isPresent = false;
float maxAmp = 0;
float AMP = maxAmp;

int nbPics = 1;
Pic[] pics = new Pic[1000];

int maxPointsHumains = 307200;
float[][] pointsHumains = new float[maxPointsHumains][5];
int occPointsHumains = 0;

int raieY = 1;

float threshold = 50;

Capture video;
PImage backgroundImage, oldImage;

void setup() {
  size(640, 480);

  video = new Capture(this, width, height, 30);
  video.start();

  backgroundImage = createImage(video.width, video.height, RGB);
  oldImage = createImage(video.width, video.height, RGB);

  for (int i = 0; i < 1000; i++) {
    pics[i] = new Pic(0, 0, 0, 0);
  }
}

void draw() {
  if (video.available()) {
    video.read();
  }

  raieY = 1;

  for (int i = 0; i < 307200; i++) {
    pointsHumains[i][0] = 0;
    pointsHumains[i][1] = 0;
    pointsHumains[i][2] = 0;
    pointsHumains[i][3] = 0;
    pointsHumains[i][4] = 0;
  }

  loadPixels();
  video.loadPixels(); 
  backgroundImage.loadPixels();

  occPointsHumains = 0;

  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      int loc = x + y*video.width; // Step 1, what is the 1D pixel location
      color fgColor = video.pixels[loc]; // Step 2, what is the foreground color

      color bgColor = backgroundImage.pixels[loc];
      float diff = dist(red(fgColor), green(fgColor), blue(fgColor), red(bgColor), green(bgColor), blue(bgColor));


      // Si on détecte un blob différent du fond
      if (diff > threshold) {
        nbPointsHumains++;

        pointsHumains[occPointsHumains][0] = x;
        pointsHumains[occPointsHumains][1] = y;

        pointsHumains[occPointsHumains][2] = red(fgColor);
        pointsHumains[occPointsHumains][3] = green(fgColor);
        pointsHumains[occPointsHumains][4] = blue(fgColor);

        occPointsHumains++;

        if (y < (video.height - 10) && 1 == int(random(50))) {
          pixels[loc] = fgColor;

          rectMode(CENTER);
          fill(fgColor);
          //    rect(x+int(random(-600, 600)), y, 1, 1);
        }

        pixels[loc] = fgColor;
      } else {
        pixels[loc] = bgColor;
      }
    }
  }

  updatePixels();


  for (int i = 0; i < maxPointsHumains; i++) {

    /* Raies */
    if (int(random(1, 10000)) == 4) {

      //  for (float amplitude = 0 ; amplitude <= 10 ; amplitude+=1 ) {  
      //  if (raieY < pointsHumains[i][1]) {

      raieY = int(pointsHumains[i][1]);
      PImage raie;
      imageMode(CORNER);

      // Visage
      if (int(random(1, 3+AMP)) == 2) {
        raie = video.get(int(pointsHumains[i][0]-100), int(pointsHumains[i][1]), int(random(150, 300)), int(random(5, constrain(int(6+AMP), 0, 35))));
        image(raie, pointsHumains[i][0]-100, pointsHumains[i][1]);
      }

      // Visage old
      if (int(random(1, 3+AMP)) == 2) {
        raie = oldImage.get(int(pointsHumains[i][0]-100), int(pointsHumains[i][1]), int(random(150, 300)), int(random(5, constrain(int(6+AMP), 0, 35))));
        image(raie, pointsHumains[i][0]-100, pointsHumains[i][1]);
      }

      // Fond
      else {
        raie = backgroundImage.get(int(pointsHumains[i][0]-100), int(pointsHumains[i][1]), int(random(150, 300)+AMP), int(random(1, int(2*AMP))));
        image(raie, pointsHumains[i][0]-100, pointsHumains[i][1]);
      }
    }

    if (int(random(constrain(200-AMP*2, 30, 150))) == 1) {
      rectMode(CENTER);
      noStroke();

      /*
      if (int(random(10)) > 7) {
       fill(255, 0, 0);
       rect(pointsHumains[i][0], pointsHumains[i][1], 1, 1);
       }
       if (int(random(10)) > 7) {
       fill(0, 255, 0);
       rect(pointsHumains[i][0], pointsHumains[i][1], 1, 1);
       }
       if (int(random(10)) > 7) {
       fill(0, 0, 255);
       rect(pointsHumains[i][0], pointsHumains[i][1], 1, 1);
       }
       */

      /* Rectangles */
      if (int(random(10)) > 7) {

        fill( pointsHumains[i][2], 
        pointsHumains[i][3], 
        pointsHumains[i][4]);

        rect(pointsHumains[i][0]+int(random(-20, 20)), pointsHumains[i][1]+(int(random(-26, 26))), random(6, 20), int(random(1, int(constrain(1+AMP, 1, 30)))));

        fill(0, 255, 0, 20);
        rect(pointsHumains[i][0]+int(random(-20, 20)), pointsHumains[i][1]+(int(random(-26, 26))), random(6, 20), int(random(1, int(constrain(1+AMP, 1, 30)))));

        fill(255, 0, 0, 20);
        rect(pointsHumains[i][0]+int(random(-20, 20)), pointsHumains[i][1]+(int(random(-26, 26))), random(6, 20), int(random(1, int(constrain(1+AMP, 1, 30)))));

        fill(0, 0, 255, 20);
        rect(pointsHumains[i][0]+int(random(-20, 20)), pointsHumains[i][1]+(int(random(-26, 26))), random(6, 20), int(random(1, int(constrain(1+AMP, 1, 30)))));
      }

      /* Triangles */
      /*
      if (int(random(10)) > 7) {
       fill(pointsHumains[i][2], pointsHumains[i][3], pointsHumains[i][4]);
       triangle(pointsHumains[i][0]+int(random(-20, 20)), pointsHumains[i][1]+(int(random(-6, 6))), 
       pointsHumains[i][0]+int(random(-20, 20)), pointsHumains[i][1]+int(random(-20, 20)), 
       pointsHumains[i][0]+int(random(-20, 20)), pointsHumains[i][1]+int(random(-20, 20)));
       }
       */

      /* RVB */
      /*
      if (int(random(10)) > 7) {
       fill(255, 0, 0, 150);
       rect(pointsHumains[i][0]-2, pointsHumains[i][1], 2, 4);
       
       fill(0, 255, 0, 150);
       rect(pointsHumains[i][0], pointsHumains[i][1], 2, 4);
       
       fill(0, 0, 255, 150);
       rect(pointsHumains[i][0]+2, pointsHumains[i][1], 2, 4);
       
       }
       */
    }
  }

  if (occPointsHumains > maxPointsHumains/7) {

    if (timer.isFinished()) { 
      AMP+=3; 
      timer = new Timer(1000); 
      timer.start();

      oldImage.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
      oldImage.updatePixels();
    }
  } else { 
    AMP = maxAmp;
  }
}

void mousePressed() {
  backgroundImage.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
  backgroundImage.updatePixels();
}

