// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

// ContactListener to listen for collisions!

import org.jbox2d.callbacks.ContactImpulse;
import org.jbox2d.callbacks.ContactListener;
import org.jbox2d.collision.Manifold;
import org.jbox2d.dynamics.contacts.Contact;

class CustomListener implements ContactListener {
  CustomListener() {
  }

  // This function is called when a new collision occurs
  void beginContact(Contact cp) {
    Fixture f1 = cp.getFixtureA();
    Fixture f2 = cp.getFixtureB();
    // Get both bodies
    Body b1 = f1.getBody();
    Body b2 = f2.getBody();

    // Get our objects that reference these bodies
    Object o1 = b1.getUserData();
    Object o2 = b2.getUserData();
    /*
    if (o1.getClass() == Particle.class && o2.getClass() == Particle.class) {
     Particle p1 = (Particle) o1;
     p1.change();
     Particle p2 = (Particle) o2;
     p2.change();
     }
     */


    if ((o1.getClass() == Particle.class && o2.getClass() != Particle.class)
      || (o1.getClass() != Particle.class && o2.getClass() == Particle.class)) {

      if (o1.getClass() == Particle.class) {
        Particle p1 = (Particle) o1;
        p1.change();
      }

      if (o2.getClass() == Particle.class) {
        Particle p2 = (Particle) o2;
        p2.change();
      }
    }
  }

  void endContact(Contact contact) {
    // TODO Auto-generated method stub
  }

  void preSolve(Contact contact, Manifold oldManifold) {
    // TODO Auto-generated method stub
  }

  void postSolve(Contact contact, ContactImpulse impulse) {
    // TODO Auto-generated method stub
  }
}

