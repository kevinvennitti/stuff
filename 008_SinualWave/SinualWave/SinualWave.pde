import ddf.minim.*;
import ddf.minim.signals.*;
 
Minim minim;
AudioOutput out;
SineWave sine1, sine3;
SineWave sine2;
int F = 100;
 
void setup()
{
  size(800, 600, P2D);
  minim = new Minim(this);
  out = minim.getLineOut(Minim.MONO);
  /*
  sine1 = new SineWave(540, 0.5, out.sampleRate());
  sine2 = new SineWave(850, 0.5, out.sampleRate());
  */
  sine1 = new SineWave(F, 0.5, out.sampleRate());
//  sine2 = new SineWave(50, 0.5, out.sampleRate());
//  sine3 = new SineWave(40, 0.5, out.sampleRate());
  
  // 40, 50 = écart
  
  sine1.portamento(600);
//  sine2.portamento(200);
//  sine3.portamento(200);
  out.addSignal(sine1);
//  out.addSignal(sine2);
//  out.addSignal(sine3);
//  out.setGain(5);

 F = 100;
}

void draw()
{
  //sine1.setFreq(180); // 180 // 100
 // sine2.setFreq(44000);
  
  
  background(0);
  stroke(255);
  for(int i = 0; i < out.bufferSize() - 1; i++)
  {
    float x1 = map(i, 0, out.bufferSize(), 0, width);
    float x2 = map(i+1, 0, out.bufferSize(), 0, width);
    line(x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
    line(x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
    line(x1, 250 + (out.left.get(i)+out.right.get(i))*25, x2, 250 + (out.left.get(i)+out.right.get(i))*25);
  }
  /*
  if (mousePressed) {
      sine1.setFreq(300); // 180 // 100
  } else {
      sine1.setFreq(105); // 35 : minimum
  }*/
  
  text(F,50,50);
  
  // 86 : cool
  // 94 : très cool, segments géométriques
}

void keyPressed() {
 if (keyCode == UP) {
   F++;
 } 
 if (keyCode == DOWN) {
   F--;
 } 
 sine1.setFreq(F);
 
}
/*
 
void mouseMoved()
{
  
  float freq1 = map(mouseY, 0, height, 3000, 1500);
//  float freq2 = freq1 + mouseX * 30 / width;
//  sine1.setFreq(freq1);
//  sine2.setFreq(freq2);
  
//  println(freq1+' '+freq2);
  
  float pan1 = -1;
  float pan2 = 1;
//  sine1.setFreq(15000);
 // sine2.setPan(pan2);
  
}
 */
void stop()
{
  out.close();
  minim.stop();
   
  super.stop();
}

