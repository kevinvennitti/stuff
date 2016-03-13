// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2012
// Box2DProcessing example

// A fixed boundary class

class Boundary {

  float x;
  float y;
  float w;
  float h;
  float a;
  Body b;

  Boundary(float x_, float y_, float w_, float h_, float a_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    a = a_;



    // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);



    // Create the body
    BodyDef bd = new BodyDef();
    bd.angle = a;
    //  bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    b = box2d.createBody(bd);

    // Attached the shape to the body using a Fixture
    b.createFixture(sd, 1);

    b.setUserData(this);
  }


  void killBody() {
    box2d.destroyBody(b);
  }

  void setHeight(int h_) {
  }


  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    float a = b.getAngle();

    pushMatrix();
    translate(x, y);
    rotate(-a);
    fill(200);
    noStroke();
    rectMode(CENTER);
    rect(0, 0, w, h);
    popMatrix();
  }
}
