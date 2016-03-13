import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioOutput out;
AudioOutput out2;
WhiteNoise wnl;
SineWave wnr;

float amp, pan, gain = 10;
int dim;
int[][] bbl = new int[10][2];

void setup() {
  size(displayWidth, displayHeight);
  background(0);
  noStroke();
  ellipseMode(RADIUS);
  frameRate(40);
  minim = new Minim(this);
  out = minim.getLineOut();
  out2 = minim.getLineOut();
  amp = 0.8;
  
  wnl = new WhiteNoise(amp);
  wnr = new SineWave(40, 0.5, out.sampleRate());
  wnr.setFreq(2800);
  
  wnl.setPan(0);
  wnr.setPan(0);
  
  out.addSignal(wnl);
  out2.addSignal(wnr);
  
  out.setGain(gain);
  
  for (int i = 0; i < bbl.length; i++) {
    bbl[i][0] = int(random(100,width-100));
    bbl[i][1] = int(random(50,height));
  } 
}

void draw() {
  background(220,220,255);
  
  wnl.setAmp(random(amp-0.2,amp+0.1));
 // wnr.setAmp(random(amp-0.1,amp+0.2));
 
  pan = constrain(random(pan-0.1,pan+0.1), -0.7, 0.7);
  wnl.setPan(pan);
  
//  gain = constrain(int(random(gain-1,gain+2)),8,25);
  gain = int(random(10,20));
  out.setGain(gain);
  
  println(gain);
//  wnr.setPan(int(random(-1,1)));
 
  for (int i = 0; i < bbl.length; i++) {
    drawGradient(i, bbl[i][0], bbl[i][1]);
  } 
}

void drawGradient(int id, float x, float y) {
  int radius = displayWidth/7;
  for (int r = radius; r > 0; r-=6) {
    fill(255,int(random(220,255)),255,10);
    
    bbl[id][0] = int(random(bbl[id][0]-4, bbl[id][0]+5));
    bbl[id][1] = int(random(bbl[id][1]-4, bbl[id][1]+5));
    
    if (bbl[id][0] < 0) { bbl[id][0] = width/2; }
    if (bbl[id][0] > width) { bbl[id][0] = width-5; }
    if (bbl[id][1] < 0) { bbl[id][1] = height/2; }
    if (bbl[id][1] > height) { bbl[id][1] = height-5; }
    
    ellipse(bbl[id][0], bbl[id][1], r, r);
  }
}
