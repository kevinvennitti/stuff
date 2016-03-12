import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam cam;

BufferedReader reader;
String line;
int failCurrent, occCurrent;
int mode = 9;

void setup() {
  // Open the file from the createWriter() example
  // reader = createReader("datas.txt");
  size(1200, 1000, P3D); 
  //if (mode == 1 || mode == 6 || mode == 7 || mode == 8 || mode == 9) { 
    //  size(1200, 1000, P3D); 
    cam = new PeasyCam(this, 0, 0, 0, 50);
    cam.setMinimumDistance(50);
    cam.setMaximumDistance(1000);
    cam.setDistance(1000);
    cam.rotateX(-200);
    cam.rotateY(100);
    cam.rotateZ(-100);


  frameRate(60);

  failCurrent = 0;
}

void draw() {
  background(245, 243, 242);

  failCurrent++;
  occCurrent++;

  String[] lines = loadStrings("datas.txt");

  int[][] pts = new int[lines.length][4];

  for (int i = 0; i < lines.length; i++) {

    String[] datas = split(lines[i], "{");
    datas = split(datas[1], "}");
    datas = split(datas[0], ",");

    int xOrigin = pts[i][0] = int(datas[0]);
    int yOrigin = pts[i][1] = int(datas[1]);
    int xUser   = pts[i][2] = int(datas[2]);
    int yUser   = pts[i][3] = int(datas[3]);

    float ratio = 1.7;
    float fail = int(dist(xOrigin, yOrigin, xUser, yUser));

    if (mode == 1) {
      pushMatrix();

      if (fail < 1000/* && fail == failCurrent*/) {
        noStroke();
        fill(255, 0, 0);
        ellipse(xOrigin, yOrigin, 5, 5);

        noFill();
        stroke(200, 200, 200/*map(fail, 0,100,0,255)*/);
        strokeWeight(1);
        line(xOrigin, yOrigin, 0, xUser, yUser, fail);
      }

      popMatrix();
    }

    if (mode == 2) {

      pushMatrix();

      if (fail < 100/* && fail == failCurrent*/) {
        noStroke();
        fill(255, 0, 0);

        noFill();
        stroke(0, map(fail, 0, 100, 255, 0));
        strokeWeight(1);
        line(xOrigin*ratio, yOrigin*ratio, xUser*ratio, yUser*ratio);
      }

      popMatrix();
    }

    if (mode == 3) {
      pushMatrix();

      if (i < occCurrent) {
        if (fail < 10000/* && fail == failCurrent*/) {  
          noFill();
          stroke(0, map(fail, 0, 1000, 255, 0));
          strokeWeight(1);
          line(xOrigin*ratio, yOrigin*ratio, xUser*ratio, yUser*ratio);
        }
      }

      popMatrix();
    }

    if (mode == 4) {
      pushMatrix();

      if (i < occCurrent) {
        if (fail < 100/* && fail == failCurrent*/) {  
          noFill();
          stroke(0, map(fail, 0, 1000, 255, 0));
          strokeWeight(1);
          //  line(xOrigin*ratio, yOrigin*ratio, xUser*ratio, yUser*ratio);
          if (i > 0) { 
            stroke(200, 200, 200);
            line(xOrigin*ratio, yOrigin*ratio, pts[i-1][0]*ratio, pts[i-1][1]*ratio);
            stroke(255, 99, 71);
            line(xUser*ratio, yUser*ratio, pts[i-1][2]*ratio, pts[i-1][3]*ratio);
          }
        }
      }

      popMatrix();
    }

    if (mode == 5) {

      if (i < occCurrent) {
        if (fail < 100/* && fail == failCurrent*/) {  
          noFill();
          fill(255, 99, 71, map(fail, 0, 100, 50, 200));
          textSize(map(fail, 0, 100, 0, 100));
          text(int(fail), xOrigin*ratio, yOrigin*ratio);
        }
      }
    }

    if (mode == 6) {

      if (i < occCurrent) {
        if (fail < 1000/* && fail == failCurrent*/) {  
          pushMatrix();
          textMode(SHAPE);
          translate(xUser*ratio, yUser*ratio, -fail*ratio);
          noFill();
          fill(255, 99, 71, map(fail, 0, 400, 255, 50));
          textSize(map(fail, 0, 400, 20, 100));
          text(int(fail), 0, 0);

          noFill();
          stroke(200, 200, 200, map(fail, 0, 400, 255, 50));

          popMatrix();
          line(xOrigin*ratio, yOrigin*ratio, 0, xUser*ratio, yUser*ratio, -fail*ratio);
        }
      }
    }



    if (mode == 7) {

      if (i < occCurrent) {

        stroke(255, 99, 71);

        if (fail > 30 /* && fail == failCurrent*/) {  
          noFill();

          // stroke(200,200,200);
          if (i > 0) { 
            //  line(xOrigin*ratio, yOrigin*ratio, 0,  pts[i-1][0]*ratio, pts[i-1][1]*ratio,0);

            line(xUser*ratio, yUser*ratio, -fail*ratio, pts[i-1][2]*ratio, pts[i-1][3]*ratio, -int(dist(pts[i-1][0], pts[i-1][1], pts[i-1][2], pts[i-1][3]))*ratio);
          }

          //   line(xOrigin*ratio,yOrigin*ratio,0,xUser*ratio,yUser*ratio,-fail*ratio);
        } else {
          if (i > 0) { 
            line(xUser*ratio, yUser*ratio, 0*ratio, pts[i-1][2]*ratio, pts[i-1][3]*ratio, -int(dist(pts[i-1][0], pts[i-1][1], pts[i-1][2], pts[i-1][3]))*ratio);
          }
        }
      }
    }


    if (mode == 8) {

      if (i < occCurrent) {

        stroke(255, 99, 71);

        if (fail > 0 /* && fail == failCurrent*/) {  
          noFill();

          // stroke(200,200,200);
          if (i > 0) { 
            //  line(xOrigin*ratio, yOrigin*ratio, 0,  pts[i-1][0]*ratio, pts[i-1][1]*ratio,0);

            line((xUser-xOrigin)*ratio, (yUser-yOrigin)*ratio, -fail*ratio, (pts[i-1][2]-pts[i-1][0])*ratio, (pts[i-1][3]-pts[i-1][1])*ratio, -int(dist(pts[i-1][0], pts[i-1][1], pts[i-1][2], pts[i-1][3]))*ratio);
          }

          //   line(xOrigin*ratio,yOrigin*ratio,0,xUser*ratio,yUser*ratio,-fail*ratio);
        }
      }
    }



    if (mode == 9) {

      if (i < occCurrent) {

        stroke(255, 99, 71);

        if (fail > 0 /* && fail == failCurrent*/) {  
          noFill();

          // stroke(200,200,200);
          if (i > 0) { 
            //  line(xOrigin*ratio, yOrigin*ratio, 0,  pts[i-1][0]*ratio, pts[i-1][1]*ratio,0);
            pushMatrix();
            translate((xUser-xOrigin)*ratio, (yUser-yOrigin)*ratio, -fail*ratio);
            sphere(3);
            popMatrix();

            stroke(200, 200, 200);
            line((xUser-xOrigin)*ratio, (yUser-yOrigin)*ratio, -fail*ratio, (pts[i-1][2]-pts[i-1][0])*ratio, (pts[i-1][3]-pts[i-1][1])*ratio, -int(dist(pts[i-1][0], pts[i-1][1], pts[i-1][2], pts[i-1][3]))*ratio);
          }

          //   line(xOrigin*ratio,yOrigin*ratio,0,xUser*ratio,yUser*ratio,-fail*ratio);
        }
      }
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    mode++;
    if (mode > 9) {
      mode = 1;
    }
  }
}