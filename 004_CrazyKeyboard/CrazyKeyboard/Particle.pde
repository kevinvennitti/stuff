// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

// A circular particle

class Particle {

  // We need to keep track of a Body and a radius
  Body body;
  float r;

  color col;

  char letter;
  int opacity = 255;


  Particle(float x_, float y, float r_, color couleur_, char letter_) {
    r = r_;
    col = couleur_;
    letter = letter_;
    float x;
    // This function puts the particle in the Box2d world
    if (x_ == -1) {
      x = random(300, width-300);
    } else {
      x = (width-600) * x_/mapLettersString.length() + 300;
    }

    y = height-150-200;
    makeBody(x, y, r);
    body.setUserData(this);
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }
  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > width+r*2) {
      killBody();
      return true;
    }

    if (opacity <= 0) {
      killBody();
      return true;
    }
    return false;
  }


  void change() {
    /*
    char[] broken = {
      ',', ':', ';', '.'
    }; 
    letter = broken[int(random(broken.length))];
    */
  }


  // 
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);

    opacity-=1;

    // Get its angle of rotation
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(col, opacity);
    noStroke();
    /*    stroke(0);
     strokeWeight(1);*/
    // ellipse(0, 0, r*2, r*2);

    fill(255, 255, 255, opacity);
    textSize(30);
    textAlign(CENTER, CENTER);
    text(letter, 0, 0);
    fill(0);
    // Let's add a line so we can see the rotation
    //   line(0, 0, r, 0);
    popMatrix();
  }

  // Here's our function that adds the particle to the Box2D world
  void makeBody(float x, float y, float r) {
    // Define a body
    BodyDef bd = new BodyDef();
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x, y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    //  cs.setAsBox(2, 1);
    cs.m_radius = box2d.scalarPixelsToWorld(r);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 5;
    fd.friction = 3;
    fd.restitution = 0.8;

    // Attach fixture to body
    body.createFixture(fd);

    body.setAngularVelocity(0);

    Vec2 v3 = new Vec2(random(-10, 10), 60.0); // Go a little high
    body.setLinearVelocity(v3);
  }
}