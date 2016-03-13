class Pic {
  int x, y;
  float amp;
  color teinte; 

  Pic (int varx, int vary, float varamp, color varteinte) {  
    x = varx; 
    y = vary;
    amp = varamp;
    teinte = varteinte;
  } 

  void setup() {/*
    x = x; 
    y = y;
    amp = amp;
    teinte = teinte;*/
  }

  void create() {
    x = 240;
  }
}

