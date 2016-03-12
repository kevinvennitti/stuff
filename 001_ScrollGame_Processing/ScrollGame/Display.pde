void displayScroll() {
  image(cursor,width-55, map(score+10,0,displayHeight,5,displayHeight-5));
  
  noStroke();
  fill(couleurScrollBarre);
  rect(width-15, 0, 15, displayHeight);

  fill(couleurScroll);
  rect(width-11, map(score,0,displayHeight,5,displayHeight-5), 8, 50, 5);
}

void displayScore() {
  if (sens) {
    fill(couleurFond2);
  } else {
    fill(couleurFond1);
  }

  textSize(36);
  textAlign(CENTER);
  textFont(font);
  text(score, width/2, height/2+18);

  if (is(SCORING)) {
    textAlign(CENTER);
    textFont(font);
    textSize(20);
    text("SCORE", width/2, height/2-28);
  }


  pushMatrix();
  translate(width/2, height/2);
  for (int i = 1; i <= 360; i++) {
    if (i > timerTotal.passedTime()*360/15000) {
      fill(255, 255);
      ellipse(cos(radians(i-90))*(113+score_radiusOuter), sin(radians(i-90))*(113+score_radiusOuter), 20, 20);
    }
  }
  popMatrix();
}

void displayGo() {
  if (is(WAITING)) {
    float dx = 250 - go_size;
    if (abs(dx) > 1) {
      go_size += dx * easing;
    }
  }

  if (is(PLAYING)) {
    float dx = 160 - go_size;
    if (abs(dx) > 1) {
      go_size += dx * easing;
    } /*
    if (go_size < 140) {
     float dx4 = 60 - score_radiusOuter;
     if (abs(dx4) > 1) {
     score_radiusOuter += dx4 * easing;
     }
     }*/

    /*
    float dx2 = 0 - go_opacity;
     if (abs(dx2) > 1) {
     go_opacity += dx2 * easing2;
     }
     */

    float dx3 = 0 - go_opacityText;
    if (abs(dx3) > 1) {
      go_opacityText += dx3 * easing2;
    }
  }

  if (is(SCORING)) {

    float dx = 250 - go_size;
    if (abs(dx) > 1) {
      go_size += dx * easing;
    }
  }

  fill(255, go_opacity);
  noStroke();
  ellipseMode(CENTER);
  ellipse(width/2, height/2, go_size, go_size);

  if (sens) {
    fill(couleurFond2, go_opacityText);
  } else {
    fill(couleurFond1, go_opacityText);
  }

  if (is(WAITING)) {
    textAlign(CENTER);
    textFont(font);
    textSize(36);
    text("LET'S\nSCROLL", width/2, height/2-12);
  }
}

void displayFond() {
  if (sens) {
    float dx = radiusScreen - fond_size2;
    fond_size2 += dx * easing2;

    if (fond_size2 >= radiusScreen-50) {
      fond_opacity1 = 0;
      fond_size1 = 0;
    }


    float dx2 = 255 - fond_opacity2;
    fond_opacity2 += dx2 * easing2;
  }

  if (!sens) {
    float dx3 = radiusScreen - fond_size1;
    fond_size1 += dx3 * easing2;

    if (fond_size1 >= radiusScreen-50) {
      fond_opacity2 = 0;
      fond_size2 = 0;
    }

    float dx4 = 255 - fond_opacity1;
    fond_opacity1 += dx4 * easing2;
  }

  if (sens) {
    ellipseMode(CENTER);
    noStroke();

    fill(couleurFond1);
    ellipse(width/2, height/2, fond_size1, fond_size1);

    fill(couleurFond2);
    ellipse(width/2, height/2, fond_size2, fond_size2);
  }

  // couleurFond1 = rouge
  // couleurFond2 = bleu

  if (!sens) {
    ellipseMode(CENTER);
    noStroke();

    fill(couleurFond2);
    ellipse(width/2, height/2, fond_size2, fond_size2);

    fill(couleurFond1);
    ellipse(width/2, height/2, fond_size1, fond_size1);
  }
}

