// Learning Processing — Daniel Shiffman
// http://www.learningprocessing.com

class Timer {
 
  int savedTime;
  int totalTime;
  
  Timer(int tempTotalTime) {
    totalTime = tempTotalTime;
  }
 
  void start() {
    savedTime = millis(); 
  }
  
  int passedTime() {
    return (millis()-savedTime);
  }
  
  boolean isFinished() { 
    int passedTime = millis()-savedTime;
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}
