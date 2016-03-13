import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

String[] mapLetters = {"a", "q", "w", "z", "s", "x", "e", "d", "c", "r", "f", "v", "t", "g", "b", "y", "h", "n", "u", "j", ",", "i", "k", ";", "o", "l", ":", "p", "m", "="};
String mapLettersString = "aqwzsxedcrfvtgbyhnuj,ik;ol:pm=";

int timerPressed = 0;

char keySave;
char keySave_old;

boolean isPressed = false;

Box2DProcessing box2d;

ArrayList<Particle> particles;

Boundary keyboard;

void setup() {
  size(displayWidth, displayHeight);
  smooth();

  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -100);
  box2d.world.setContactListener(new CustomListener());

  particles = new ArrayList<Particle>();

  /*                      x            y         w    h    angle */
  keyboard = new Boundary(width/2, height-150, 800, 300, 0);

  frameRate(60);
}

void draw() {
  background(0);


  box2d.step();

  for (int i = particles.size ()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.display();
    if (p.done()) {
      particles.remove(i);
    }
  }

  keyboard.display();
}

void addLetter(char letter) {
  particles.add(new Particle(mapLettersString.indexOf(letter), random(0, 20)+160, 5, color(255, 255, 255), key));
}

void addLetterGlob(char letter) {
  particles.add(new Particle(mapLettersString.indexOf(letter), random(0, 20)+160, 5, color(255, 255, 255), key));
}

void keyPressed() {
  if (key == ' ') {
    for (int i = 0; i < mapLettersString.length(); i++) {
      addLetterGlob(mapLettersString.charAt(i));
    }
  } else {
    addLetter(key);
  }
}

void keyReleased() {
  //  isPressed = false;
  //  timerPressed = 0;
}